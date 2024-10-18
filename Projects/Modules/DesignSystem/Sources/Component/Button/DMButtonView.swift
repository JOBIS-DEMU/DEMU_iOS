import UIKit
import SnapKit
import Then

public enum BtType {
    case start
    case next
    case login
    case signup
    case finish
    var text: String {
        switch self {
        case .next:
            return "다음"
        case .start:
            return "시작하기"
        case .login:
            return "로그인"
        case .signup:
            return "회원가입"
        case .finish:
            return "완료"
        }
    }
}

public class DMButtonView: UIView {
    public let button = UIButton().then {
        $0.layer.cornerRadius = 15
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    public init(type: BtType) {
        super.init(frame: .zero)
        button.setTitle(type.text, for: .normal)
        switch type {
        case .start:
            button.backgroundColor = UIColor.main1
            button.setTitleColor(UIColor.white, for: .normal)
        default:
            button.backgroundColor = UIColor.main2
            button.setTitleColor(UIColor.text2, for: .normal)
            button.isEnabled = false
        }
        addView()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addView() {
        self.addSubview(button)
    }

    private func layout() {
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
