import UIKit
import DesignSystem
import Core
import SnapKit
import Then

public class LoginViewController: BaseViewController {
    private let loginLabel = UILabel().then {
        $0.text = "로그인"
        $0.font = .boldSystemFont(ofSize: 22)
    }

    private let emailTextField = DMTextFieldView(type: .email)
    private let passWordTextField = DMTextFieldView(type: .pwd)

    private let passWordChagneButton = UIButton().then {
        $0.setTitle("임시 비밀번호 받기", for: .normal)
        $0.setTitleColor(UIColor.text, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 11, weight: .semibold)
    }
    private let loginButton = DMButtonView(type: .login)
    private let signUpButton = DMTextButtonView(type: .singup)

    public override func attribute() {
        view.backgroundColor = .background
        emailTextField.textField.addTarget(self, action: #selector(updateLoginButtonState), for: .editingChanged)
        passWordTextField.textField.addTarget(self, action: #selector(updateLoginButtonState), for: .editingChanged)

        passWordChagneButton.addTarget(self, action: #selector(passWordChagneButtonTapped), for: .touchUpInside)
        loginButton.button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signUpButton.textButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

    public override func addView() {
        [
            emailTextField,
            passWordTextField,
            passWordChagneButton,
            loginButton,
            signUpButton
        ].forEach { view.addSubview($0) }

    }
    public override func layout() {
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(83)
        }
        passWordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(83)
        }
        passWordChagneButton.snp.makeConstraints {
            $0.top.equalTo(passWordTextField.snp.bottom)
            $0.trailing.equalToSuperview().inset(24)
        }
        loginButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(64)
        }
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.button.snp.bottom).offset(3)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(110)
        }
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.titleView = loginLabel
    }

    @objc private func updateLoginButtonState() {
        let emailTFNil = !(emailTextField.textField.text ?? "").isEmpty
        let passWordTFNil = !(passWordTextField.textField.text ?? "").isEmpty
        if emailTFNil && passWordTFNil {
            loginButton.button.backgroundColor = UIColor.main1
            loginButton.button.setTitleColor(UIColor.white, for: .normal)
            loginButton.button.isEnabled = true
        } else {
            loginButton.button.backgroundColor = UIColor.main2
            loginButton.button.setTitleColor(UIColor.text2, for: .normal)
            loginButton.button.isEnabled = false
        }
    }

    @objc private func passWordChagneButtonTapped() {
        let vc = EmailSendViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func loginButtonTapped() {
        let vc = TabBarController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func signUpButtonTapped() {
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
