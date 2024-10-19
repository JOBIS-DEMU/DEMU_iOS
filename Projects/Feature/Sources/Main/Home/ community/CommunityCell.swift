import UIKit
import DesignSystem
import Core
import SnapKit
import Then

class CommunityCell: UITableViewCell {
    private let logoImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.backgroundColor = .systemGray5
    }
    private let userNameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
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
        contentView.addSubview(logoImageView)
        contentView.addSubview(userNameLabel)
    }
    private func layout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.left.equalToSuperview().offset(274)
            $0.width.height.equalTo(102)
        }
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(15)
            $0.left.equalToSuperview().offset(42)
            $0.right.equalToSuperview().offset(306)
        }
    }
    func configure(imageName: String, description: String) {
        logoImageView.image = UIImage(named: imageName)
        userNameLabel.text = description
    }
}
