import UIKit
import DesignSystem
import Core
import SnapKit
import Then

class PwdViewController: BaseViewController {
    private let backButton = UIButton().then {
        $0.setImage(UIImage.back, for: .normal)
    }
    private let titleLabel = UILabel().then {
        $0.text = "기존 대뮤니티\n비밀번호 입력해주세요"
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = UIColor.text
    }
    private let pwdTextField = DMTextFieldView(type: .pwd)
    private let nextButton = DMButtonView(type: .next)
    override internal func attribute() {
        view.backgroundColor = UIColor.background

        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        pwdTextField.textField.addTarget(self, action: #selector(updateNextButtonState), for: .editingChanged)
        nextButton.button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    override internal func addView() {
        [
            titleLabel,
            pwdTextField,
            nextButton
        ].forEach { view.addSubview($0) }
    }
    override internal func layout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(15)
            $0.leading.equalToSuperview().inset(24)
        }
        pwdTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(83)
        }
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(64)
        }
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc private func updateNextButtonState() {
        let pwdTFNil = !(pwdTextField.textField.text ?? "").isEmpty
        if pwdTFNil {
            nextButton.button.backgroundColor = UIColor.main1
            nextButton.button.setTitleColor(UIColor.white, for: .normal)
            nextButton.button.isEnabled = true
        } else {
            nextButton.button.backgroundColor = UIColor.main2
            nextButton.button.setTitleColor(UIColor.text2, for: .normal)
            nextButton.button.isEnabled = false
        }
    }
    @objc private func nextButtonTapped() {
        self.navigationController?.pushViewController(PassWordChangeViewController(), animated: true)
    }
}
