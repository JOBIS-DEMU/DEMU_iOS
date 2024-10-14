import UIKit
import DesignSystem
import Core
import SnapKit
import Then

public class LoginViewController: BaseViewController {
    private let emailTextField = DMTextFieldView(type: .email)
    private let passWordTextField = DMTextFieldView(type: .pwd)

    private let loginButton = DMButtonView(type: .login)

    override public func addView() {
        [
            emailTextField,
            passWordTextField,
            loginButton
        ].forEach { view.addSubview($0) }
    }
    override public func layout() {
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(89)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(100)
        }
        passWordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(100)
        }
        loginButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(64)
        }
    }

    override public func attribute() {
        view.backgroundColor = .white
    }

}
