import UIKit
import SnapKit
import Then

public enum BtType {
    case start
    case next
    case login
    case signup
    var text: String {
        switch self {
        case .next :
            return "다음"
        case .start :
            return "시작하기"
        case .login :
            return "로그인"
        case .signup :
            return "회원가입"
        }
    }
}

public class DMButton: UIView {
    let button = UIButton().then {
        $0.backgroundColor = UIColor.main1
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 15
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    public init(type: BtType) {
        super.init(frame: .zero)
        button.setTitle(type.text, for: .normal)
        addView()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addView() {
        self.addSubview(button)
    }

    func layout() {
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
