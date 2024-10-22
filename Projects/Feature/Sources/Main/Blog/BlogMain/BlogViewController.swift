import UIKit
import DesignSystem
import Core
import SnapKit
import Then

class BlogViewController: BaseViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    private let cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    private let checkButton = UIButton().then {
        $0.setTitle("등록", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }

    private let dropDownLabel = UILabel().then {
        $0.text = "backend"
        $0.font = .systemFont(ofSize: 24, weight: .semibold)
        $0.textColor = .main1
    }
    private let downButton = UIButton().then {
        $0.setImage(UIImage.down, for: .normal)
    }
    private let imagePicker = UIImagePickerController()
    private let profileEditImageView = UIImageView().then {
        $0.image = UIImage.image
        $0.layer.masksToBounds = true
    }
    private let numberCountLabel = UILabel().then {
        $0.text = "4/5"
        $0.font = .systemFont(ofSize: 8, weight: .medium)
        $0.textColor = .gray
    }
    public override func attribute() {
        view.backgroundColor = .background
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.navigationItem.hidesBackButton = true

    }
    public override func addView() {
        [
            cancelButton,
            checkButton,
            profileEditImageView,
            dropDownLabel,
            downButton,
            numberCountLabel
        ].forEach { view.addSubview($0) }
    }
    public override func layout() {
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(62)
            $0.leading.equalTo(24)
        }
        checkButton.snp.makeConstraints {
            $0.top.equalTo(62)
            $0.trailing.equalTo(-24)
        }
        profileEditImageView.snp.makeConstraints {
            $0.top.equalTo(cancelButton.snp.bottom).offset(29)
            $0.leading.equalTo(40)
            $0.width.height.equalTo(18)
        }
        dropDownLabel.snp.makeConstraints {
            $0.top.equalTo(58)
            $0.leading.equalTo(132)
        }
        downButton.snp.makeConstraints {
            $0.top.equalTo(65)
            $0.leading.equalTo(242)
        }
        numberCountLabel.snp.makeConstraints {
            $0.top.equalTo(145)
            $0.leading.equalTo(42)
        }
    }
    @objc func pickImage() {
        self.present(self.imagePicker, animated: true)
    }
    public func presentImagePicker() {
        self.present(imagePicker, animated: true, completion: nil)
    }
}
