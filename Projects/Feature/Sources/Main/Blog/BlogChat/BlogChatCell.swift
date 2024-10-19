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
    }
    private let descriptionLabel = UILabel().then {
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
        contentView.addSubview(descriptionLabel)
    }
    private func layout() {
        profileImageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(60)
        }
        descriptionLabel.snp.makeConstraints {
            $0.left.equalTo(profileImageView.snp.right).offset(16)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-16)
        }
    }
    
    func configure(imageName: String, description: String) {
        profileImageView.image = UIImage(named: imageName)
        descriptionLabel.text = description
    }
}
