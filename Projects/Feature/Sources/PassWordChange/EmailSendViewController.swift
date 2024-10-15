import UIKit
import DesignSystem
import Core
import SnapKit
import Then

public class EmailSendViewController: BaseViewController {
    private let passWorldChageLabel = UILabel().then {
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
        self.navigationItem.titleView = passWorldChageLabel
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
}
