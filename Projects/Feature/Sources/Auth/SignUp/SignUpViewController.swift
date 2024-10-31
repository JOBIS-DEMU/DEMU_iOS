import UIKit
import DesignSystem
import Core
import SnapKit
import Then
import RxSwift
import RxCocoa

class SignUpViewController: BaseViewController {

    private let viewModel = SignUpViewModel()
    private let disposeBag = DisposeBag()

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

    override func attribute() {
        view.backgroundColor = UIColor.background
    }

    private func bindTextField(_ textField: UITextField) {
        textField.rx.text
            .orEmpty
            .bind { _ in
                self.updateLoginButtonState()
            }
            .disposed(by: disposeBag)
    }

    override func bind() {
        let input = SignUpViewModel.Input(
            email: emailTextField.textField.rx.text.orEmpty.asDriver(),
            nickname: nicknameTextField.textField.rx.text.orEmpty.asDriver(),
            password: pwdTextField.textField.rx.text.orEmpty.asDriver(),
            doneTap: signUpButton.button.rx.tap.asSignal()
        )
        let output = viewModel.transform(input)

        output.result.subscribe(onNext: { [weak self] bool in
            if bool {
                let vc = LoginViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            } else {
                self?.emailTextField.errorLabel.text = "유효하지 않은 이메일 입니다."
                self?.nicknameTextField.errorLabel.text = "이미 있는 닉네임 입니다."
                self?.pwdTextField.errorLabel.text = "올바르지 않은 형식의 비밀번호 입니다."
            }
        }).disposed(by: disposeBag)
    }

    override func bindAction() {
        bindTextField(emailTextField.textField)
        bindTextField(nicknameTextField.textField)
        bindTextField(pwdTextField.textField)
        bindTextField(confirmPwdTextField.textField)

        loginButton.textButton.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }

    override func addView() {
        [
            emailTextField,
            nicknameTextField,
            pwdTextField,
            confirmPwdTextField,
            signUpButton,
            loginButton
        ].forEach{ view.addSubview($0)}
    }

    override func layout() {
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationItem.titleView = signUpLabel
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    private func updateLoginButtonState() {
        let emailTFNil = !(emailTextField.textField.text ?? "").isEmpty
        let nickNameTFNil = !(nicknameTextField.textField.text ?? "").isEmpty
        let pwdTFNil = !(pwdTextField.textField.text ?? "").isEmpty
        let confirmPwdTFNil = !(confirmPwdTextField.textField.text ?? "").isEmpty
        if emailTFNil && nickNameTFNil && pwdTFNil && confirmPwdTFNil {
            signUpButton.button.backgroundColor = UIColor.main1
            signUpButton.button.setTitleColor(UIColor.white, for: .normal)
            signUpButton.button.isEnabled = true
        } else {
            signUpButton.button.backgroundColor = UIColor.main2
            signUpButton.button.setTitleColor(UIColor.text2, for: .normal)
            signUpButton.button.isEnabled = false
        }
    }
}
