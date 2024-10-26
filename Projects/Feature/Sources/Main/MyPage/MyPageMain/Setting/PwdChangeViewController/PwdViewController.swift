import UIKit
import DesignSystem
import Core
import SnapKit
import Then
import RxSwift
import RxCocoa

class PwdViewController: BaseViewController {

    private let disposeBag = DisposeBag()

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

    override public func attribute() {
        view.backgroundColor = UIColor.background
    }

    override public func bindAction() {
        backButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        nextButton.button.rx.tap
            .subscribe(onNext: {
                let vc = PassWordChangeViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)

        pwdTextField.textField.rx.text
            .subscribe(onNext: {_ in
                let nickNameTFNil = !(self.pwdTextField.textField.text ?? "").isEmpty
                if nickNameTFNil {
                    self.nextButton.button.backgroundColor = UIColor.main1
                    self.nextButton.button.setTitleColor(UIColor.white, for: .normal)
                    self.nextButton.button.isEnabled = true
                } else {
                    self.nextButton.button.backgroundColor = UIColor.main2
                    self.nextButton.button.setTitleColor(UIColor.text2, for: .normal)
                    self.nextButton.button.isEnabled = false
                }
            })
            .disposed(by: disposeBag)
    }

    override public func addView() {
        [
            backButton,
            titleLabel,
            pwdTextField,
            nextButton
        ].forEach { view.addSubview($0) }
    }

    override public func layout() {
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(3)
            $0.leading.equalToSuperview().inset(20)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(50)
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
}
