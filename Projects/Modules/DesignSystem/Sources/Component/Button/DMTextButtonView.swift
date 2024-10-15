import UIKit
import SnapKit
import Then

public enum TbType {
    case login
    case singup
    var text: String {
        switch self {
        case .login: return "계정이 있다면?"
        case .singup: return "계정이 없다면?"
        }
    }
    var buttontext: String {
        switch self {
        case .login: return "로그인"
        case .singup: return "회원가입"
        }
    }
}

public class DMTextButtonView: UIView {
    private let questionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
    }
    public let textButton = UIButton().then {
        $0.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.setTitleColor(UIColor.main1, for: .normal)
    }

    public init(type: TbType) {
        super.init(frame: .zero)
        questionLabel.text = type.text
        textButton.setTitle(type.buttontext, for: .normal)

        addView()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addView() {
        [
            questionLabel,
            textButton
        ].forEach{ self.addSubview($0) }
    }

    private func layout() {
        questionLabel.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
        }
        textButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(questionLabel.snp.trailing)
        }
    }
}
