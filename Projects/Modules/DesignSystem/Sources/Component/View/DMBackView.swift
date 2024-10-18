import UIKit
import DesignSystem
import Core
import SnapKit
import Then

public enum BvType {
    case profile
    case nickname
    case pwd
    case major
    case logout
    var text: String {
        switch self {
        case .nickname:
            return "닉네임 변경"
        case .pwd:
            return "비밀번호 변경"
        case .major:
            return "전공 변경"
        case .logout:
            return "로그아웃"
        default:
            return ""
        }
    }
}

public class DMBackView: UIView {
    
    private let backView = UIView().then {
        $0.backgroundColor = .white
    }
    private let iconImageView = UIImageView()
    private let title = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }

    public init(type: BvType){
        super.init(frame: .zero)
        self.title.text = type.text

        switch type {
        case .profile:
            self.title.isHidden = true
        case .nickname:
            self.iconImageView.image = UIImage.nickname
        case .pwd:
            self.iconImageView.image = UIImage.pwd
        case .major:
            self.iconImageView.image = UIImage.major
        case .logout:
            self.iconImageView.image = UIImage.logout
        }

        addView()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addView() {
        self.addSubview(backView)
        [
            title,
            iconImageView
        ].forEach{ backView.addSubview($0) }
    }
    private func layout() {
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        iconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(28)
        }
        title.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(iconImageView.snp.trailing).offset(12)
        }
    }
}
