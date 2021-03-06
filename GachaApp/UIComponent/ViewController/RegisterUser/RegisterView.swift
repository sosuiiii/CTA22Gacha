import UIKit

final class RegisterView: UIView {

    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.username
        label.textColor = UIColor(named: "LabelBase")
        return label
    }()

    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.configure()
        return textField
    }()

    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.password
        label.textColor = UIColor(named: "LabelBase")
        return label
    }()

    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.configure()
        textField.isSecureTextEntry = true
        return textField
    }()

    let underline: UIView = {
        let underLine = UIView()
        underLine.backgroundColor = UIColor(named: "Base")
        return underLine
    }()

    let underline2: UIView = {
        let underLine = UIView()
        underLine.backgroundColor = UIColor(named: "Base")
        return underLine
    }()

    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(L10n.register, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 22)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "Base")
        button.layer.cornerRadius = 5
        return button
    }()

    let secureButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        clipsToBounds = true

        addSubviews()
        setLayout()
    }
    private func addSubviews() {
        addSubview(usernameTextField)
        addSubview(passwordTextField)
        addSubview(userNameLabel)
        addSubview(passwordLabel)
        addSubview(underline)
        addSubview(underline2)
        addSubview(registerButton)
        addSubview(secureButton)
    }

    private func setLayout() {
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            usernameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            usernameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])

        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 50),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])

        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameLabel.heightAnchor.constraint(equalToConstant: 30),
            userNameLabel.bottomAnchor.constraint(equalTo: usernameTextField.topAnchor, constant: 10),
            userNameLabel.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor)
        ])

        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordLabel.heightAnchor.constraint(equalToConstant: 30),
            passwordLabel.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 10),
            passwordLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            passwordLabel.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor)
        ])

        underline.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            underline.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: -8),
            underline.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            underline.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            underline.heightAnchor.constraint(equalToConstant: 2)
        ])

        underline2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            underline2.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: -8),
            underline2.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            underline2.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            underline2.heightAnchor.constraint(equalToConstant: 2)
        ])

        registerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            registerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 40),
            registerButton.widthAnchor.constraint(equalToConstant: 100)
        ])

        secureButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secureButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            secureButton.leadingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            secureButton.heightAnchor.constraint(equalToConstant: 20),
            secureButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
