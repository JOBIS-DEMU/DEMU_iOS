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
            $0.top.equalTo(62)
            $0.leading.equalTo(24)
        }
        checkButton.snp.makeConstraints {
            $0.top.equalTo(62)
            $0.trailing.equalTo(-24)
        }
        dropDownLabel.snp.makeConstraints {
            $0.top.equalTo(58)
            $0.leading.equalTo(132)
        }
        downButton.snp.makeConstraints {
            $0.top.equalTo(65)
            $0.leading.equalTo(242)
        }
        imageSquareView.snp.makeConstraints {
            $0.top.equalTo(113)
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
        self.present(modalVC, animated: true, completion: nil)
    }
    @objc func cancelButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func pickImage() {
        self.present(self.imagePicker, animated: true)
    }
    public func presentImagePicker() {
        self.present(imagePicker, animated: true, completion: nil)
    }
}
