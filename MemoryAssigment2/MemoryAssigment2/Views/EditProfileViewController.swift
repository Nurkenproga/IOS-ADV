import UIKit

class EditProfileViewController: UIViewController {
    
    var userProfile: UserProfile?
    var onProfileUpdated: ((UserProfile) -> Void)?
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Введите имя"
        return textField
    }()
    
    private let bioTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "О себе"
        return textField
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupActions()
        loadProfileData()
    }
    
    private func setupUI() {
        view.addSubview(usernameTextField)
        view.addSubview(bioTextField)
        view.addSubview(saveButton)
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        bioTextField.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            bioTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            bioTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bioTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            saveButton.topAnchor.constraint(equalTo: bioTextField.bottomAnchor, constant: 30),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupActions() {
        saveButton.addAction(UIAction(handler: { [weak self] _ in
            self?.saveProfile()
        }), for: .touchUpInside)
    }
    
    private func loadProfileData() {
        usernameTextField.text = userProfile?.username
        bioTextField.text = userProfile?.bio
    }
    
    private func saveProfile() {
        guard let name = usernameTextField.text, !name.isEmpty,
              let bio = bioTextField.text, !bio.isEmpty else {
            print("Заполните все поля")
            return
        }
        
        let updatedProfile = UserProfile(username: name, bio: bio)
        onProfileUpdated?(updatedProfile)
        dismiss(animated: true)
    }
}
