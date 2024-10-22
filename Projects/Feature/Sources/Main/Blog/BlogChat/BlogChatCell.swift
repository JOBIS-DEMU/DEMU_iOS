import UIKit
import DesignSystem
import Core
import SnapKit
import Then

class BlogChatCell: UITableViewCell {
    private let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 12
        $0.image = UIImage.profile
    }
    private let nameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .black
    }
    private let chatLabel = UILabel().then {
        $0.textColor = UIColor.text
        $0.numberOfLines = 0
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addView() {
        [
            profileImageView,
            nameLabel,
            chatLabel
        ].forEach{ contentView.addSubview($0) }
    }
    private func layout() {
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(24)
            $0.width.height.equalTo(24)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(11)
            $0.leading.equalToSuperview().inset(56)
        }
        chatLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(14)
        }
    }
    public func configure(profileImage: String, description: String, chat: String) {
        if profileImage != "" {
            profileImageView.image = UIImage(named: profileImage)
        }
        nameLabel.text = description
        chatLabel.text = chat
    }
}
