import UIKit
import DesignSystem
import Core
import SnapKit
import Then

public class MyPageViewController: BaseViewController {
    private let imagePicker = UIImagePickerController()
    private let imageView = UIImageView().then {
        $0.image = UIImage.imagePicker
        $0.isUserInteractionEnabled = true
    }

    public override func addView() {
        view.addSubview(imageView)
    }

    public override func layout() {
        imageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(27)
            $0.leading.equalTo(20)
            $0.width.equalTo(106)
            $0.height.equalTo(100)
        }
    }
    @objc func pickImage() {
        self.present(self.imagePicker, animated: true)
    }

    public override func attribute() {
        self.navigationController?.navigationBar.backgroundColor = .blue
        self.navigationItem.title = "마이페이지"
        self.navigationController?.navigationBar.isTranslucent = false
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
