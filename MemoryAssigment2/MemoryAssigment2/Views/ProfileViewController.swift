import UIKit

class ProfileViewController: UIViewController {
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.image = UIImage(named: "profile_placeholder")
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.text = "Загрузка..."
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "О себе..."
        return label
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Редактировать", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        return button
    }()
    
    private var userProfile = UserProfile(username: "Иван Иванов", bio: "Программист iOS")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProfileManager.shared.onProfileUpdated = { [weak self] updatedProfile in
            self?.userProfile = updatedProfile
            self?.updateUI()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Профиль"
        
        view.addSubview(profileImageView)
        view.addSubview(usernameLabel)
        view.addSubview(bioLabel)
        view.addSubview(editProfileButton)
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            usernameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            bioLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10),
            bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            editProfileButton.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 20),
            editProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupActions() {
        editProfileButton.addAction(UIAction(handler: { [weak self] _ in
            self?.editProfileTapped()
        }), for: .touchUpInside)
    }
    
    private func updateUI() {
        usernameLabel.text = userProfile.username
        bioLabel.text = userProfile.bio
    }
    
    private func editProfileTapped() {
        let editVC = EditProfileViewController()
        editVC.userProfile = userProfile
        editVC.onProfileUpdated = { [weak self] updatedProfile in
            self?.userProfile = updatedProfile
            self?.updateUI()
        }
        present(editVC, animated: true)
    }
    
    private func loadProfile() {
        ProfileManager.shared.loadProfile { [weak self] profile in
            self?.userProfile = profile
            self?.updateUI()
        }
    }



}
