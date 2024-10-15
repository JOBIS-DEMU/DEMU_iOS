import UIKit
import DesignSystem
import Core
import SnapKit
import Then

public class SignUpViewController: BaseViewController {
    private let signUpLabel = UILabel().then {
        $0.text = "회원가입"
        $0.font = .boldSystemFont(ofSize: 22)
    }

    private let emailTextField = DMTextFieldView(type: .email)
    private let nicknameTextField = DMTextFieldView(type: .nickname)
    private let passWordTextField = DMTextFieldView(type: .pwd)
    private let confirmPassWordTextField = DMTextFieldView(type: .confirmpwd)

    private let signUpButton = DMButtonView(type: .signup)
    private let loginButton = DMTextButtonView(type: .login)

    override public func attribute() {
        view.backgroundColor = UIColor.background
    }

    override public func addView() {
        [
            emailTextField,
            nicknameTextField,
            passWordTextField,
            confirmPassWordTextField,
            signUpButton,
            loginButton
        ].forEach{ view.addSubview($0)}
        self.navigationItem.titleView = signUpLabel
    }

    override public func layout() {
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(83)
        }
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(83)
        }
        passWordTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(83)
        }
        confirmPassWordTextField.snp.makeConstraints {
            $0.top.equalTo(passWordTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(83)
        }
        signUpButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(64)
        }
        loginButton.snp.makeConstraints {
            $0.top.equalTo(signUpButton.button.snp.bottom).offset(3)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(110)
        }
    }
}
