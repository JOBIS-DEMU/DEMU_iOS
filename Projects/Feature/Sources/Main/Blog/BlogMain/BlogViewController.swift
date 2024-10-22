import UIKit
import DesignSystem
import Core
import SnapKit
import Then

class BlogViewController: BaseViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, BlogModalViewControllerDelegate {

    private let maxImageCount = 5
    private var selectedImages = [UIImage]()

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
        $0.isUserInteractionEnabled = true
    }
    private let numberCountLabel = UILabel().then {
        $0.text = "0/5"
        $0.font = .systemFont(ofSize: 8, weight: .medium)
        $0.textColor = .gray
    }
    private let imageSquareView = UIView().then {
        $0.layer.cornerRadius = 5
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.gray.cgColor
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    public override func attribute() {
        view.backgroundColor = .background
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.navigationItem.hidesBackButton = true

        downButton.addTarget(self, action: #selector(presentBlogModal), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        profileEditImageView.addGestureRecognizer(tapGestureRecognizer)
    }

    public override func addView() {
        [
            cancelButton,
            checkButton,
            dropDownLabel,
            downButton,
            imageSquareView
        ].forEach { view.addSubview($0) }

        [
            numberCountLabel,
            profileEditImageView
        ].forEach { imageSquareView.addSubview($0) }
    }

    public override func layout() {
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(14)
            $0.leading.equalTo(24)
        }
        checkButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(14)
            $0.leading.equalTo(332)
        }
        dropDownLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(14)
            $0.leading.equalTo(130)
        }
        downButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(26)
            $0.leading.equalTo(dropDownLabel.snp.trailing).offset(12)
            $0.width.equalTo(16)
            $0.height.equalTo(8)
        }
        imageSquareView.snp.makeConstraints {
            $0.top.equalTo(cancelButton.snp.bottom).offset(29)
            $0.leading.equalTo(24)
            $0.width.height.equalTo(50)
        }
        numberCountLabel.snp.makeConstraints {
            $0.top.equalTo(32)
            $0.leading.trailing.equalTo(18)
        }
        profileEditImageView.snp.makeConstraints {
            $0.top.equalTo(12)
            $0.leading.equalTo(16)
            $0.width.height.equalTo(18)
        }
    }

    @objc func presentBlogModal() {
        let modalVC = BlogModalViewController()
        modalVC.modalPresentationStyle = .formSheet
        modalVC.modalTransitionStyle = .coverVertical
        modalVC.delegate = self
        self.present(modalVC, animated: true, completion: nil)
    }

    func didSelectMajor(_ major: String) {
        dropDownLabel.text = major
    }

    @objc func cancelButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func pickImage() {
        if selectedImages.count >= maxImageCount {
            let alert = UIAlertController(title: "알림", message: "최대 5장까지 선택할 수 있습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            self.present(self.imagePicker, animated: true)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImages.append(editedImage)
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImages.append(originalImage)
        }
        picker.dismiss(animated: true, completion: nil)
        updateImage()
    }

    private func updateImage() {
        if let lastImage = selectedImages.last {
            profileEditImageView.image = lastImage
        }
        numberCountLabel.text = "\(selectedImages.count)/\(maxImageCount)"
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
