import UIKit
import DesignSystem
import Core
import SnapKit
import Then

public class MyPageViewController: BaseViewController {
    private let customBackView = UIView().then {
        $0.backgroundColor = .main1
    }
    private let imagePicker = UIImagePickerController()
    private let imageView = UIImageView().then {
        $0.image = UIImage.imagePicker
        $0.isUserInteractionEnabled = true
    }
    private let nameLabel = UILabel().then {
        $0.text = "홍길동"
        $0.font = .systemFont(ofSize: 26, weight: .semibold)
    }
    private let majorLabel = UILabel().then {
        $0.text = "backend"
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = .textField
    }
    public override func addView() {
        [
            customBackView,
            imageView,
            nameLabel,
            majorLabel
        ].forEach { view.addSubview($0) }
    }

    public override func layout() {
        customBackView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.snp.bottom).inset(744)
            $0.width.equalTo(390)
            $0.height.equalTo(100)
        }
        imageView.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide).inset(27)
            $0.bottom.equalTo(view.snp.bottom).inset(673)
            $0.leading.equalTo(20)
            $0.width.equalTo(106)
            $0.height.equalTo(100)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(9)
            $0.leading.equalTo(20)
            $0.trailing.equalTo(296)
        }
        majorLabel.snp.makeConstraints {
            $0.top.equalTo(customBackView.snp.bottom).offset(94)
            $0.leading.equalTo(100)
            $0.trailing.equalTo(240)
        }
    }
    @objc func pickImage() {
        self.present(self.imagePicker, animated: true)
    }

    public override func attribute() {
        self.navigationItem.title = "마이페이지"
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        imageView.addGestureRecognizer(tapGesture)
    }

    public func presentImagePicker() {
        self.present(imagePicker, animated: true, completion: nil)
    }
}

extension MyPageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            imageView.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            imageView.image = originalImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
