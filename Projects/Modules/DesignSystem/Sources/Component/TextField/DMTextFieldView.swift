import UIKit
import SnapKit
import Then

public enum TfType {
    case email
    case emailsend
    case pwd
    case confirmpwd
    case nickname
    case authentication

    var text: String {
        switch self {
        case .email, .emailsend:
            return "이메일"
        case .pwd:
            return "비밀번호"
        case .confirmpwd:
            return "비밀번호 확인"
        case .nickname:
            return "닉네임"
        case .authentication:
            return "인증코드"
        }
    }

    var placeholder: String {
        switch self {
        case .email, .emailsend:
            return "example"
        case .pwd:
            return "8자 이상의 비밀번호를 입력해주세요"
        case .confirmpwd:
            return ""
        case .nickname:
            return "20자 이하의 닉네임을 입력해주세요"
        case .authentication:
            return "이메일로 전송된 코드를 입력해주세요"
        }
    }
}

public class DMTextFieldView: UIView {
    private var iconClick = true
    private let type: TfType

    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    public let textField = UITextField().then {
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        $0.leftViewMode = .always
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    public let line = UIView().then {
        $0.backgroundColor = .black
        $0.isUserInteractionEnabled = false
    }
    public let errorLabel = UILabel().then {
        $0.textColor = UIColor.error
        $0.font = .systemFont(ofSize: 10, weight: .semibold)
    }
    private let showPasswordButton = UIButton().then {
        $0.setImage(UIImage.eyeOff, for: .normal)
        $0.setImage(UIImage.eyeOpen, for: .selected)
        $0.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: -13, bottom: 0, right: 10)
    }
    private let emailLabel = UILabel().then {
        $0.text = "@dsm.hs.kr"
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.textColor = UIColor.textField
        $0.isHidden = true
    }
    public let sendButton = UIButton().then {
        $0.setImage(UIImage.send.withRenderingMode(.alwaysOriginal), for: .normal)
        $0.backgroundColor = UIColor.main1
        $0.layer.cornerRadius = 4
        $0.isHidden = true
    }
    public init(type: TfType) {
        self.type = type
        super.init(frame: .zero)
        textField.placeholder = type.placeholder
        titleLabel.text = type.text

        switch type {
        case .email:
            emailLabel.isHidden = false
        case .emailsend:
            emailLabel.isHidden = false
            sendButton.isHidden = false
        case .pwd, .confirmpwd:
            textField.isSecureTextEntry = true
            textField.rightView = showPasswordButton
            textField.rightViewMode = .always
            showPasswordButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        case .nickname:
            break
        case .authentication:
            textField.keyboardType = .numberPad
        }
        addView()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addView() {
        [
            titleLabel,
            textField,
            errorLabel
        ].forEach{ self.addSubview($0) }
        [
            line,
            emailLabel,
            sendButton
        ].forEach{ textField.addSubview($0) }
    }
    private func layout() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(45)
        }
        line.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        if type == .emailsend {
            emailLabel.snp.makeConstraints {
                $0.trailing.equalTo(sendButton.snp.leading).offset(-8)
                $0.centerY.equalToSuperview()
            }
            sendButton.snp.makeConstraints {
                $0.top.bottom.equalToSuperview().inset(13)
                $0.trailing.equalToSuperview().inset(5)
                $0.width.equalTo(26)
            }
        } else {
            emailLabel.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(5)
                $0.centerY.equalToSuperview()
            }
        }
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(3)
            $0.leading.equalToSuperview()
        }
    }
    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        textField.isSecureTextEntry.toggle()
        sender.isSelected.toggle()
    }
    public func currentText() -> String? {
        return textField.text
    }
}
