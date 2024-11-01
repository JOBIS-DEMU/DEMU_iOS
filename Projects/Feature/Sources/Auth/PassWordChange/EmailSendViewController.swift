import UIKit
import DesignSystem
import Core
import SnapKit
import Then
import RxSwift
import RxCocoa

class EmailSendViewController: BaseViewController {

    private let viewModel = EmailSendViewModel()
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

    override func attribute() {
        view.backgroundColor = UIColor.background
    }

    override func bind() {
        let input = EmailSendViewModel.Input(
            email: emailSendTextField.textField.rx.text.orEmpty.asDriver(),
            doneTap: emailSendTextField.sendButton.rx.tap.asSignal()
        )
        let output = viewModel.transform(input)

        output.result.subscribe(onNext: { [weak self] bool in
            if bool {
                self?.emailSendTextField.sendButton.backgroundColor = UIColor.textField
                self?.finishButton.button.backgroundColor = UIColor.main1
                self?.finishButton.button.setTitleColor(UIColor.white, for: .normal)
                self?.finishButton.button.isEnabled = true
            } else {
                self?.emailSendTextField.errorLabel.text = "존재하지 않는 이메일 입니다."
            }
        }).disposed(by: disposeBag)
    }

    override func bindAction() {
        backButton.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        emailSendTextField.textField.rx.text.orEmpty
            .map { !$0.isEmpty }
            .subscribe(onNext: { isEnabled in
                self.emailSendTextField.sendButton.isEnabled = isEnabled
                self.emailSendTextField.sendButton.backgroundColor = isEnabled ? UIColor.main1 : UIColor.textField
            })
            .disposed(by: disposeBag)
        finishButton.button.rx.tap
            .bind {
                let vc = PassWordChangeViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }

    override func addView() {
        [
            emailSendTextField,
            finishButton
        ].forEach { view.addSubview($0) }
    }

    override func layout() {
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

    override func viewWillAppear(_ animated: Bool) {
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
