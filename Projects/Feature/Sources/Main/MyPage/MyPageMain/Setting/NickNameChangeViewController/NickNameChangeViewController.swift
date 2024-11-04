import UIKit
import DesignSystem
import Core
import SnapKit
import Then
import RxSwift
import RxCocoa

class NickNameChangeViewController: BaseViewController {

    private let viewModel = NickNameViewModel()
    private let disposeBag = DisposeBag()

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    override func attribute() {
        view.backgroundColor = UIColor.background
        tabBarController?.tabBar.isHidden = true
    }

    override func bind() {
        let input = NickNameViewModel.Input(
            nickname: nickNameTextField.textField.rx.text.orEmpty.asDriver(),
            doneTap: finishButton.button.rx.tap.asSignal()
        )
        let output = viewModel.transform(input)

        input.doneTap
            .withLatestFrom(input.nickname)
            .asObservable()
            .flatMap { nickname -> Observable<Void> in
                if nickname.count < 3 || nickname.count > 10 {
                    self.nickNameTextField.errorLabel.text = "닉네임은 3~10자여야 합니다."
                    return Observable.empty()
                } else {
                    self.nickNameTextField.errorLabel.text = ""
                    return Observable.just(())
                }
            }
            .flatMapLatest { _ in
                output.result.asObservable()
                    .do(onNext: { bool in
                        print("API Result: \(bool)")
                    })
            }
            .subscribe(onNext: { bool in
                if bool {
                    self.navigationController?.popViewController(animated: true)
                    self.tabBarController?.tabBar.isHidden = false
                    print("성공")
                } else {
                    self.nickNameTextField.errorLabel.text = "이미 있는 닉네임 입니다."
                    print("실패")
                }
            }).disposed(by: disposeBag)
    }

    override func bindAction() {
        backButton.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
                self.tabBarController?.tabBar.isHidden = false
            }
            .disposed(by: disposeBag)

        nickNameTextField.textField.rx.text
            .subscribe(onNext: { _ in
                let nickNameTFNil = !(self.nickNameTextField.textField.text ?? "").isEmpty
                if nickNameTFNil {
                    self.finishButton.button.backgroundColor = UIColor.main1
                    self.finishButton.button.setTitleColor(UIColor.white, for: .normal)
                    self.finishButton.button.isEnabled = true
                } else {
                    self.finishButton.button.backgroundColor = UIColor.main2
                    self.finishButton.button.setTitleColor(UIColor.text2, for: .normal)
                    self.finishButton.button.isEnabled = false
                }
            })
            .disposed(by: disposeBag)
    }

    override func addView() {
        [
            titleLabel,
            nickNameTextField,
            finishButton
        ].forEach{ view.addSubview($0) }
    }

    override func layout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
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
}
