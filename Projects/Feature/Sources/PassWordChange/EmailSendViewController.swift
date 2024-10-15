import UIKit
import DesignSystem
import Core
import SnapKit
import Then

public class EmailSendViewController: BaseViewController {
    private let passWordChageLabel = UILabel().then {
        $0.text = "비밀번호 변경"
        $0.font = .boldSystemFont(ofSize: 22)
    }

    private let backButton = UIButton().then {
        $0.setImage(UIImage.back, for: .normal)
    }

    private let emailSendTextField = DMTextFieldView(type: .emailsend)
    private let nextButton = DMButtonView(type: .next)

    public override func attribute() {
        view.backgroundColor = UIColor.background
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        emailSendTextField.sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        nextButton.button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }

    public override func addView() {
        [
            emailSendTextField,
            nextButton
        ].forEach{ view.addSubview($0) }
    }

    public override func layout() {
        emailSendTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(30)
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
        self.navigationItem.titleView = passWordChageLabel
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

    @objc public func sendButtonTapped() {
        self.emailSendTextField.sendButton.backgroundColor = UIColor.textField
    }

    @objc public func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc public func nextButtonTapped() {
        let vc = PassWordChangeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
