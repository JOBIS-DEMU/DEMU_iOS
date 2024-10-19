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
    private let pwdTextField = DMTextFieldView(type: .pwd)
    private let confirmPwdTextField = DMTextFieldView(type: .confirmpwd)

    private let signUpButton = DMButtonView(type: .signup)
    private let loginButton = DMTextButtonView(type: .login)

    public override func attribute() {
        view.backgroundColor = UIColor.background

        emailTextField.textField.addTarget(self, action: #selector(updateLoginButtonState), for: .editingChanged)
        nicknameTextField.textField.addTarget(self, action: #selector(updateLoginButtonState), for: .editingChanged)
        pwdTextField.textField.addTarget(self, action: #selector(updateLoginButtonState), for: .editingChanged)
        confirmPwdTextField.textField.addTarget(self, action: #selector(updateLoginButtonState), for: .editingChanged)

        loginButton.textButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signUpButton.button.addTarget(self, action: #selector (signUpButtonTapped), for: .touchUpInside)
    }

    public override func addView() {
        [
            emailTextField,
            nicknameTextField,
            pwdTextField,
            confirmPwdTextField,
            signUpButton,
            loginButton
        ].forEach{ view.addSubview($0)}
    }

    public override func layout() {
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
        pwdTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(83)
        }
        confirmPwdTextField.snp.makeConstraints {
            $0.top.equalTo(pwdTextField.snp.bottom).offset(20)
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
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.titleView = signUpLabel
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    @objc private func updateLoginButtonState() {
        let emailTFNil = !(emailTextField.textField.text ?? "").isEmpty
        let nickNameTFNil = !(nicknameTextField.textField.text ?? "").isEmpty
        let pwdTFNil = !(pwdTextField.textField.text ?? "").isEmpty
        let confirmPwdTFNil = !(confirmPwdTextField.textField.text ?? "").isEmpty
        if emailTFNil && nickNameTFNil && pwdTFNil && confirmPwdTFNil {
            signUpButton.button.backgroundColor = UIColor.main1
            signUpButton.button.setTitleColor(UIColor.white, for: .normal)
            signUpButton.button.isEnabled = true
        } else {
            signUpButton.button.backgroundColor = UIColor.textField
            signUpButton.button.setTitleColor(.black, for: .normal)
            signUpButton.button.isEnabled = false
        }
    }
    @objc private func signUpButtonTapped() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func loginButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
