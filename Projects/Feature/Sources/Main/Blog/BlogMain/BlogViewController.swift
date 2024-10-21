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
//    private let imagePickerBackView = UIView().then {
//        $0.backgroundColor = .white
//        $0.
//    }
    private let dropDownLabel = UILabel().then {
        $0.text = "backend"
        $0.font = .systemFont(ofSize: 24, weight: .semibold)
        $0.textColor = .main1
    }
    private let imagePicker = UIImagePickerController()
    private let profileEditImageView = UIImageView().then {
        $0.image = UIImage.image
        $0.layer.cornerRadius = 30
        $0.layer.masksToBounds = true
    }
    public override func attribute() {
        view.backgroundColor = .background
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
    }
    public override func addView() {
        [
            cancelButton,
            checkButton,
            profileEditImageView,
            dropDownLabel
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
            $0.leading.equalTo(24)
            $0.width.height.equalTo(50)
        }
        dropDownLabel.snp.makeConstraints {
            $0.top.equalTo(58)
            $0.leading.equalTo(132)
            $0.trailing.equalTo(156)
        }
    }
    @objc func pickImage() {
        self.present(self.imagePicker, animated: true)
    }
    public func presentImagePicker() {
        self.present(imagePicker, animated: true, completion: nil)
    }
}
