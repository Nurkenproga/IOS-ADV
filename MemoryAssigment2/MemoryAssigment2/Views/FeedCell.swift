import UIKit

class FeedCell: UITableViewCell {
    
    static let identifier = "FeedCell"
    
    private let postLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("❤️ 0", for: .normal)
        button.tintColor = .systemRed
        return button
    }()
    
    private let imageLoader = ImageLoader() 
    
    var onLikeTapped: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(postLabel)
        contentView.addSubview(postImageView)
        contentView.addSubview(likeButton)
        
        postLabel.translatesAutoresizingMaskIntoConstraints = false
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        
        likeButton.addAction(UIAction(handler: { [weak self] _ in
            self?.onLikeTapped?()
        }), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            postLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            postLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            postLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            postImageView.topAnchor.constraint(equalTo: postLabel.bottomAnchor, constant: 10),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            postImageView.heightAnchor.constraint(equalToConstant: 200),

            likeButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with post: Post) {
        postLabel.text = post.content
        likeButton.setTitle("❤️ \(post.likes)", for: .normal)
        
        if let imageUrl = post.imageUrl {
            imageLoader.loadImage(url: imageUrl) { [weak self] image in
                self?.postImageView.image = image
            }
        } else {
            postImageView.image = UIImage(named: "placeholder")
        }
    }
}
