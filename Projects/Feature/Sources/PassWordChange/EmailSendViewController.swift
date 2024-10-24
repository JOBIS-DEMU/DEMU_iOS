import UIKit
import DesignSystem
import Core
import SnapKit
import Then
import RxSwift
import RxCocoa

public class EmailSendViewController: BaseViewController {
    private let disposeBag = DisposeBag()
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
        backButton.rx.tap
            .bind { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        emailSendTextField.textField.rx.text.orEmpty
            .map { !$0.isEmpty }
            .subscribe(onNext: { [weak self] isEnabled in
                self?.emailSendTextField.sendButton.isEnabled = isEnabled
                self?.emailSendTextField.sendButton.backgroundColor = isEnabled ? UIColor.main1 : UIColor.gray
            })
            .disposed(by: disposeBag)
        emailSendTextField.sendButton.rx.tap
            .bind { [weak self] in
                self?.onButton()
            }
            .disposed(by: disposeBag)

        finishButton.button.rx.tap
            .bind { [weak self] in
                self?.navigationController?.pushViewController(PassWordChangeViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }

    public override func addView() {
        [
            emailSendTextField,
            finishButton
        ].forEach { view.addSubview($0) }
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

    private func onButton() {
        emailSendTextField.sendButton.backgroundColor = UIColor.textField
        finishButton.button.backgroundColor = UIColor.main1
        finishButton.button.setTitleColor(UIColor.white, for: .normal)
        finishButton.button.isEnabled = true
    }
}
