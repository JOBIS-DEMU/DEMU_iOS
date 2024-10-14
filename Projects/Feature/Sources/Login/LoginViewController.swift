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
    private let passWorldChagneButton = UIButton().then {
        $0.setTitle("비밀번호 변경", for: .normal)
        $0.setTitleColor(UIColor.text, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 11, weight: .semibold)
    }
    private let loginButton = DMButtonView(type: .login)

    override public func addView() {
        [
            emailTextField,
            passWordTextField,
            passWorldChagneButton,
            loginButton
        ].forEach { view.addSubview($0) }
        self.navigationItem.titleView = loginLabel

    }
    override public func layout() {
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
        passWorldChagneButton.snp.makeConstraints {
            $0.top.equalTo(passWordTextField.snp.bottom)
            $0.trailing.equalToSuperview().inset(24)
        }
        loginButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(64)
        }
    }

    override public func attribute() {
        view.backgroundColor = .background
    }

}
