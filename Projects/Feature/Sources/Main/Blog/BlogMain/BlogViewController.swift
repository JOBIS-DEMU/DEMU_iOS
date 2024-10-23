import UIKit
import DesignSystem
import Core
import SnapKit
import Then
import RxSwift

class BlogViewController: BaseViewController, BlogModalViewControllerDelegate {

    private let maxImageCount = 5
    private var selectedImages = [UIImageView]()

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
        $0.textColor = UIColor.textField
    }
    private let imageSquareView = UIView().then {
        $0.layer.cornerRadius = 5
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.textField.cgColor
    }
    private var removeButton = UIButton()
    private let titlePlaceholderText = UILabel().then {
        $0.text = "제목 (25자 이하)"
        $0.font = .systemFont(ofSize: 26, weight: .semibold)
        $0.textColor = UIColor.textField
        $0.isHidden = false
    }
    private let titleTextView = UITextView().then {
        $0.font = .systemFont(ofSize: 26, weight: .semibold)
        $0.textColor = UIColor.text
        $0.backgroundColor = UIColor.background
        $0.isScrollEnabled = false
    }
    private let lineView = UIView().then {
        $0.backgroundColor = UIColor.background2
    }
    private let detailPlaceholderText = UILabel().then {
        $0.text = "(3000자 이하) 본문에 내용을 추가해 주세요"
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textColor = UIColor.textField
        $0.isHidden = false
    }
    private let detailTextView = UITextView().then {
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textColor = UIColor.text
        $0.backgroundColor = UIColor.background
        $0.isScrollEnabled = false
    }

    public override func attribute() {
        view.backgroundColor = .background
        imagePicker.delegate = self
        detailTextView.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.navigationItem.hidesBackButton = true

        titleTextView.delegate = self
        titlePlaceholderText.isHidden = !titleTextView.text.isEmpty
        detailPlaceholderText.isHidden = !detailTextView.text.isEmpty

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
            imageSquareView,
            titleTextView,
            lineView,
            detailTextView
        ].forEach { view.addSubview($0) }

        titleTextView.addSubview(titlePlaceholderText)
        detailTextView.addSubview(detailPlaceholderText)

        [
            numberCountLabel,
            profileEditImageView
        ].forEach { imageSquareView.addSubview($0) }
    }

    public override func layout() {
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(14)
            $0.leading.equalToSuperview().inset(24)
        }
        checkButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(14)
            $0.trailing.equalToSuperview().inset(24)
        }
        dropDownLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(14)
            $0.centerX.equalToSuperview()
        }
        downButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(18)
            $0.leading.equalTo(dropDownLabel.snp.trailing).offset(12)
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
        titleTextView.snp.makeConstraints {
            $0.top.equalTo(imageSquareView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.greaterThanOrEqualTo(40)
        }
        titlePlaceholderText.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(5)
        }
        lineView.snp.makeConstraints {
            $0.top.equalTo(titleTextView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }
        detailTextView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.greaterThanOrEqualTo(16)
        }
        detailPlaceholderText.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(5)
        }
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
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
}

extension BlogViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == titleTextView {
            titlePlaceholderText.isHidden = true
        } else if textView == detailTextView {
            detailPlaceholderText.isHidden = true
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        if textView == titleTextView {
            if titleTextView.text.count > 25 {
                titleTextView.text = String(titleTextView.text.prefix(25))
            }
            titlePlaceholderText.isHidden = !titleTextView.text.isEmpty
        } else if textView == detailTextView {
            if detailTextView.text.count > 3000 {
                detailTextView.text = String(detailTextView.text.prefix(3000))
            }
            detailPlaceholderText.isHidden = !detailTextView.text.isEmpty
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == titleTextView {
            titlePlaceholderText.isHidden = !titleTextView.text.isEmpty
        } else if textView == detailTextView {
            detailPlaceholderText.isHidden = !detailTextView.text.isEmpty
        }
    }
}

extension BlogViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        if let selectedImage = info[.originalImage] as? UIImage {
            addImageView(with: selectedImage)
        }
        dismiss(animated: true, completion: nil)
        updateImageDisplay()
    }
    private func updateImageDisplay() {
        numberCountLabel.text = "\(selectedImages.count)/\(maxImageCount)"
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    private func addImageView(with image: UIImage) {
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.textField.cgColor

        view.addSubview(imageView)
        selectedImages.append(imageView)

        let index = selectedImages.count - 1

        imageView.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.leading.equalTo(imageSquareView.snp.trailing).offset(10 + (index * 60))
            $0.centerY.equalTo(imageSquareView)
        }

        addRemoveButton(to: imageView)
    }
    private func addRemoveButton(to imageView: UIImageView) {
        removeButton.removeFromSuperview()

        removeButton = UIButton()
        removeButton.setImage(UIImage.imagex, for: .normal)
        removeButton.addTarget(self, action: #selector(removeImage), for: .touchUpInside)

        view.addSubview(removeButton)

        removeButton.snp.makeConstraints {
            $0.bottom.equalTo(imageView.snp.bottom)
            $0.leading.equalTo(imageView.snp.trailing).offset(2)
            $0.width.height.equalTo(25)
        }
    }
    @objc private func removeImage() {
        guard let lastImageView = selectedImages.last else { return }

        lastImageView.removeFromSuperview()
        removeButton.removeFromSuperview()

        selectedImages.removeLast()

        if let newLastImageView = selectedImages.last {
            addRemoveButton(to: newLastImageView)
        } else {
            removeButton.isHidden = true
        }
        updateImageDisplay()
    }
}
