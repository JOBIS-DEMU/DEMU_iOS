import UIKit
import DesignSystem
import Core
import SnapKit
import Then
import RxSwift
import RxCocoa

public class PassWordChangeViewController: BaseViewController {
    private let disposeBag = DisposeBag()
    private let passWordChageLabel = UILabel().then {
        $0.text = "비밀번호 변경"
        $0.font = .boldSystemFont(ofSize: 22)
    }

    private let backButton = UIButton().then {
        $0.setImage(UIImage.back, for: .normal)
    }

    private let pwdTextField = DMTextFieldView(type: .pwd)
    private let confirmPwdTextField = DMTextFieldView(type: .confirmpwd)
    private let finishButton = DMButtonView(type: .finish)
    public override func attribute() {
        view.backgroundColor = UIColor.background
        backButton.rx.tap
            .bind { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)

        pwdTextField.textField.rx.text
            .orEmpty
            .bind { [weak self] _ in
                self?.loginButtonCheck()
            }
            .disposed(by: disposeBag)

        confirmPwdTextField.textField.rx.text
            .orEmpty
            .bind { [weak self] _ in
                self?.loginButtonCheck()
            }
            .disposed(by: disposeBag)

        finishButton.button.rx.tap
            .bind { [weak self] in
                self?.navigationController?.popToViewController(LoginViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }

    public override func addView() {
        [
            pwdTextField,
            confirmPwdTextField,
            finishButton
        ].forEach { view.addSubview($0) }
    }

    public override func layout() {
        pwdTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(83)
        }
        confirmPwdTextField.snp.makeConstraints {
            $0.top.equalTo(pwdTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(83)
        }
        finishButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(64)
        }
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.titleView = passWordChageLabel
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

    private func loginButtonCheck() {
        let pwdTFNone = !(pwdTextField.textField.text ?? "").isEmpty
        let confirmNone = !(confirmPwdTextField.textField.text ?? "").isEmpty

        if pwdTFNone && confirmNone {
            finishButton.button.backgroundColor = UIColor.main1
            finishButton.button.setTitleColor(UIColor.white, for: .normal)
            finishButton.button.isEnabled = true
        } else {
            finishButton.button.backgroundColor = UIColor.main2
            finishButton.button.setTitleColor(UIColor.text2, for: .normal)
            finishButton.button.isEnabled = false
        }
    }
}
