import UIKit

class FeedViewController: UIViewController {
    
    private let tableView = UITableView()
    private var posts: [Post] = []
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        loadFeed()
    }

    private func setupUI() {
        title = "Лента"
        view.backgroundColor = .systemBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FeedCell.self, forCellReuseIdentifier: FeedCell.identifier)
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshFeed), for: .valueChanged)

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(addPostTapped)
        )
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupBindings() {
        FeedManager.shared.onFeedUpdated = { [weak self] updatedPosts in
            DispatchQueue.main.async {
                self?.posts = updatedPosts
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
    }

    private func loadFeed() {
        FeedManager.shared.fetchPosts()
    }

    @objc private func refreshFeed() {
        loadFeed()
    }

    @objc private func addPostTapped() {
        let alert = UIAlertController(title: "Новый пост", message: "Введите текст поста", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Текст поста..."
        }
        alert.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { _ in
            if let text = alert.textFields?.first?.text, !text.isEmpty {
                FeedManager.shared.addPost(content: text)
            }
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(alert, animated: true)
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.identifier, for: indexPath) as! FeedCell
        cell.configure(with: posts[indexPath.row])
        cell.onLikeTapped = { [weak self] in
            FeedManager.shared.likePost(postId: self?.posts[indexPath.row].id ?? UUID())
        }
        return cell
    }
}
