import UIKit
import DesignSystem
import Core
import SnapKit
import Then
import RxSwift
import RxCocoa

class SettingViewController: BaseViewController {

    private let disposeBag = DisposeBag()

    private let profileView = DMBackView(type: .profile)

    private let xButton = UIButton().then {
        $0.setImage(UIImage.cancel, for: .normal)
    }
    private let imagePicker = UIImagePickerController()
    private let profileEditImageView = UIImageView().then {
        $0.image = UIImage.profile
        $0.layer.cornerRadius = 30
        $0.layer.masksToBounds = true
    }
    private let plusButton = UIButton().then {
        $0.setImage(UIImage.plus, for: .normal)
    }
    private let nickNameLabel = UILabel().then {
        $0.text = "홍길동"
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = UIColor.text
    }
    private let majorLabel = UILabel().then {
        $0.text = "backend"
        $0.font = .systemFont(ofSize: 10, weight: .medium)
        $0.textColor = UIColor.text
    }
    private let emailLabel = UILabel().then {
        $0.text = "abcde@dsm.hs.kr"
        $0.font = .systemFont(ofSize: 10, weight: .medium)
        $0.textColor = UIColor.textField
    }

    private let nickNameView = DMBackView(type: .nickname)
    private let pwdView = DMBackView(type: .pwd)
    private let majorView = DMBackView(type: .major)
    private let logoutView = DMBackView(type: .logout)

    override func attribute() {
        view.backgroundColor = UIColor.background

        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
    }

    override func bindAction() {
        xButton.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        plusButton.rx.tap
            .bind {
                self.present(self.imagePicker, animated: true)
            }
            .disposed(by: disposeBag)

        let nickNametapGesture = UITapGestureRecognizer()
        nickNameView.addGestureRecognizer(nickNametapGesture)
        nickNametapGesture.rx.event
            .bind { _ in
                let vc = NickNameChangeViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        let pwdViewtapGesture = UITapGestureRecognizer()
        pwdView.addGestureRecognizer(pwdViewtapGesture)
        pwdViewtapGesture.rx.event
            .bind { _ in
                let vc = PwdViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        let majortapGesture = UITapGestureRecognizer()
        majorView.addGestureRecognizer(majortapGesture)
        majortapGesture.rx.event
            .bind { _ in
                let vc = MajorChangeViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        let logouttapGesture = UITapGestureRecognizer()
        logoutView.addGestureRecognizer(logouttapGesture)
        logouttapGesture.rx.event
            .bind { _ in
                print("로그아웃")
            }
            .disposed(by: disposeBag)
    }

    override func addView() {
        [
            profileView,
            nickNameView,
            pwdView,
            majorView,
            logoutView
        ].forEach{ view.addSubview($0) }
        [
            xButton,
            profileEditImageView,
            plusButton,
            nickNameLabel,
            majorLabel,
            emailLabel
        ].forEach{ profileView.addSubview($0) }
    }

    override func layout() {
        profileView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        xButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.trailing.equalToSuperview().inset(14)
        }
        profileEditImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
            $0.height.width.equalTo(60)
        }
        plusButton.snp.makeConstraints {
            $0.top.equalTo(profileEditImageView.snp.top).offset(40)
            $0.leading.equalTo(profileEditImageView.snp.leading).offset(48)
        }
        nickNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(25)
            $0.leading.equalTo(profileEditImageView.snp.trailing).offset(10)
        }
        majorLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(profileEditImageView.snp.trailing).offset(10)
        }
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(majorLabel.snp.bottom).offset(4)
            $0.leading.equalTo(profileEditImageView.snp.trailing).offset(10)
        }
        nickNameView.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(45)
        }
        pwdView.snp.makeConstraints {
            $0.top.equalTo(nickNameView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(45)
        }
        majorView.snp.makeConstraints {
            $0.top.equalTo(pwdView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(45)
        }
        logoutView.snp.makeConstraints {
            $0.top.equalTo(majorView.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(45)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

    public func presentImagePicker() {
        self.present(imagePicker, animated: true, completion: nil)
    }
}

extension SettingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            profileEditImageView.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            profileEditImageView.image = originalImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
