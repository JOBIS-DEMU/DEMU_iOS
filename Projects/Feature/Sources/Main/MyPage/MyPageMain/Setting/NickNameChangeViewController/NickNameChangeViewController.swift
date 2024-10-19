import UIKit
import DesignSystem
import Core
import SnapKit
import Then

class NickNameChangeViewController: BaseViewController {
    private let backButton = UIButton().then {
        $0.setImage(UIImage.back, for: .normal)
    }
    private let titleLabel = UILabel().then {
        $0.text = "변경하실\n대뮤니티 닉네임을 입력해주세요"
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    private let nickNameTextField = DMTextFieldView(type: .nickname)
    private let finishButton = DMButtonView(type: .finish)

    override public func attribute() {
        view.backgroundColor = UIColor.background

        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        nickNameTextField.textField.addTarget(self, action: #selector(updateFinishButtonState), for: .editingChanged)
        finishButton.button.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
    }
    override public func addView() {
        [
            titleLabel,
            nickNameTextField,
            finishButton
        ].forEach{ view.addSubview($0) }
    }
    override public func layout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(15)
            $0.leading.equalToSuperview().inset(24)
        }
        nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(64)
        }
        finishButton.snp.makeConstraints {
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
        navigationController?.popViewController(animated: true)
    }
    @objc private func updateFinishButtonState() {
        let nickNameTFNil = !(nickNameTextField.textField.text ?? "").isEmpty
        if nickNameTFNil {
            finishButton.button.backgroundColor = UIColor.main1
            finishButton.button.setTitleColor(UIColor.white, for: .normal)
            finishButton.button.isEnabled = true
        } else {
            finishButton.button.backgroundColor = UIColor.main2
            finishButton.button.setTitleColor(UIColor.text2, for: .normal)
            finishButton.button.isEnabled = false
        }
    }
    @objc private func finishButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
