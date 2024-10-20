import UIKit
import DesignSystem
import Core
import SnapKit
import Then

public class EmailSendViewController: BaseViewController {
    private let passWordChageLabel = UILabel().then {
        $0.text = "임시 비밀번호 받기"
        $0.font = .boldSystemFont(ofSize: 22)
    }

    private let backButton = UIButton().then {
        $0.setImage(UIImage.back, for: .normal)
    }

    private let emailSendTextField = DMTextFieldView(type: .emailsend)
    private let finishButton = DMButtonView(type: .finish)

    public override func attribute() {
        view.backgroundColor = UIColor.background
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        emailSendTextField.sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        finishButton.button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }

    public override func addView() {
        [
            emailSendTextField,
            finishButton
        ].forEach{ view.addSubview($0) }
    }

    public override func layout() {
        emailSendTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(30)
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

    @objc public func sendButtonTapped() {
        self.emailSendTextField.sendButton.backgroundColor = UIColor.textField
        finishButton.button.backgroundColor = UIColor.main1
        finishButton.button.setTitleColor(UIColor.white, for: .normal)
        finishButton.button.isEnabled = true
    }

    @objc public func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc public func nextButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
