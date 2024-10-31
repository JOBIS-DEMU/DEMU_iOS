import UIKit
import DesignSystem
import Core
import SnapKit
import Then
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController {

    private let viewModel = LoginViewModel()
    private let disposeBag = DisposeBag()

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

    override func attribute() {
        view.backgroundColor = .background
    }

    private func bindTextField(_ textField: UITextField) {
        textField.rx.text
            .orEmpty
            .subscribe(onNext: { [weak self] _ in
                self?.updateLoginButtonState()
            })
            .disposed(by: disposeBag)
    }

    override func bind() {
        let input = LoginViewModel.Input(
            email: emailTextField.textField.rx.text.orEmpty.asDriver(),
            password: passWordTextField.textField.rx.text.orEmpty.asDriver(),
            doneTap: loginButton.button.rx.tap.asSignal()
        )
        let output = viewModel.transform(input)

        output.result.subscribe(onNext: { [weak self] bool in
            if bool {
                let vc = TabBarController()
                self?.navigationController?.pushViewController(vc, animated: true)
            } else {
                self?.emailTextField.errorLabel.text = "유효하지 않은 이메일 입니다."
                self?.passWordTextField.errorLabel.text = "비밀번호가 올바르지 않습니다."
            }
        }).disposed(by: disposeBag)
    }

    override func bindAction() {
        signUpButton.textButton.rx.tap
            .bind {
                let vc = SignUpViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        passWordChagneButton.rx.tap
            .bind {
                let vc = EmailSendViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)

        bindTextField(emailTextField.textField)
        bindTextField(passWordTextField.textField)
    }

    override func addView() {
        [
            emailTextField,
            passWordTextField,
            passWordChagneButton,
            loginButton,
            signUpButton
        ].forEach { view.addSubview($0) }

    }

    override func layout() {
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

        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.titleView = loginLabel
    }

    private func updateLoginButtonState() {
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
}
