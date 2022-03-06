import RxCocoa
import RxSwift
import UIKit

class RegisterUserViewController: UIViewController {

    private let registerView = RegisterView()
    private let disposeBag = DisposeBag()
    private let viewStream: RegisterUserViewStreamType
    init(viewStream: RegisterUserViewStreamType) {
        self.viewStream = viewStream
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemGray6
        view.addSubview(registerView)
        setLayout()

        registerView.secureButton.rx.tap.subscribe(with: self, onNext: { me, _ in
            me.registerView.passwordTextField.isSecureTextEntry = me.registerView.passwordTextField.isSecureTextEntry ? false : true
        }).disposed(by: disposeBag)

        registerView.usernameTextField.rx.controlEvent([.editingChanged])
            .bind(to: viewStream.input.userNameEditingChanged)
            .disposed(by: disposeBag)

        registerView.usernameTextField.rx.text.orEmpty
            .bind(to: viewStream.input.userNameText)
            .disposed(by: disposeBag)

        registerView.passwordTextField.rx.controlEvent([.editingChanged])
            .bind(to: viewStream.input.passwordEditingChanged)
            .disposed(by: disposeBag)

        registerView.passwordTextField.rx.text.orEmpty
            .bind(to: viewStream.input.passwordText)
            .disposed(by: disposeBag)

        registerView.registerButton.rx.controlEvent([.touchUpInside])
            .bind(to: viewStream.input.registerButtonTapped)
            .disposed(by: disposeBag)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            registerView.heightAnchor.constraint(equalToConstant: 320),
            registerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            registerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
