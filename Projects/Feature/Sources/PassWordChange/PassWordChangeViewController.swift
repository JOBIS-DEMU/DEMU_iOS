import UIKit
import DesignSystem
import Core
import SnapKit
import Then

public class PassWordChangeViewController: BaseViewController {
    private let passWorldChageLabel = UILabel().then {
        $0.text = "비밀번호 변경"
        $0.font = .boldSystemFont(ofSize: 22)
    }

    private let backButton = UIButton().then {
        $0.setImage(UIImage.back, for: .normal)
    }

    private let passWordTextField = DMTextFieldView(type: .pwd)
    private let confirmPassWordTextField = DMTextFieldView(type: .confirmpwd)
    private let finishButton = DMButtonView(type: .finish)

    public override func attribute() {
        view.backgroundColor = UIColor.background
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    public override func addView() {
        [
            passWordTextField,
            confirmPassWordTextField,
            finishButton
        ].forEach{view.addSubview($0)}
    }
    public override func layout() {
        passWordTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(83)
        }
        confirmPassWordTextField.snp.makeConstraints {
            $0.top.equalTo(passWordTextField.snp.bottom).offset(20)
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
        self.navigationItem.titleView = passWorldChageLabel
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    @objc public func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

