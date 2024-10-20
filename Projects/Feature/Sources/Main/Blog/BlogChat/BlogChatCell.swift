import UIKit
import DesignSystem
import Core
import SnapKit
import Then

class BlogChatCell: UITableViewCell {
    private let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.backgroundColor = .lightGray
    }
    private let nameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .black
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
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
    }
    private func layout() {
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(8)
            $0.leading.equalTo(24)
            $0.width.height.equalTo(24)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(12)
            $0.leading.equalTo(56)
        }
    }
    func configure(profileImage: String, description: String) {
        profileImageView.image = UIImage(named: profileImage)
        nameLabel.text = description
    }
}
