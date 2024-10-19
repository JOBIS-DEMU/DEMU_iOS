import UIKit
import SnapKit
import Then

public enum MlType {
    case setting
    case write
    var text: String {
        switch self {
        case .setting:
            return "설정"
        case .write:
            return "글쓰기"
        }
    }
}

public class DMMyLabelView: UIView {
    private let label = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .medium)
    }
    private let icon = UIImageView()

    public init(type: MlType) {
        super.init(frame: .zero)

        self.label.text = type.text
        switch type {
        case .setting:
            self.icon.image = UIImage.setting
        case .write:
            self.icon.image = UIImage.edit.withRenderingMode(.alwaysTemplate)
            self.icon.tintColor = UIColor.text
        }

        addView()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addView() {
        [
            label,
            icon
        ].forEach{ self.addSubview($0) }
    }
    private func layout() {
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        icon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(label.snp.leading).offset(-12)
        }
    }
}

