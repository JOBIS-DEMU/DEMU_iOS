import UIKit
import SnapKit
import Then

enum TvType {
    case complexintro
    var text: String {
        switch self {
        case .complexintro:
            return "20자 이하의 자기소개를 작성해주세요"
        }
    }
}

class DMTextView: UIView {
    let textView = UITextView().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.contentInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        $0.layer.cornerRadius = 8.35
        $0.backgroundColor = .white
        $0.textAlignment = .center
        $0.layer.borderColor = UIColor.background2.cgColor
        $0.layer.borderWidth = 1
        $0.isEditable = false
    }
    let placeholderText = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .textField
        $0.isHidden = false
        $0.textAlignment = .center
    }
    var onTextChange: ((String) -> Void)?
    init(type: TvType) {
        self.placeholderText.text = type.text
        super.init(frame: .zero)
        self.textView.delegate = self
        addView()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addView() {
        self.addSubview(textView)
        self.addSubview(placeholderText)
    }
    func layout() {
        textView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        placeholderText.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension DMTextView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderText.isHidden = true
    }
    func textViewDidChange(_ textView: UITextView) {
        placeholderText.isHidden = !textView.text.isEmpty
        onTextChange?(textView.text)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        placeholderText.isHidden = !textView.text.isEmpty
    }
}
