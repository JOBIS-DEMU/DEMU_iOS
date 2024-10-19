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
    private let writerProfileImageView = UIImageView().then {
        $0.image = UIImage.profile
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
    }
    private let writerNameLabel = UILabel().then {
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
        [
            writerProfileImageView,
            writerNameLabel,
            logoImageView
        ].forEach { contentView.addSubview($0) }
    }
    private func layout() {
        writerProfileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().offset(14)
            $0.height.width.equalTo(24)
        }
        writerNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalTo(writerProfileImageView.snp.trailing).offset(4)
        }
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(14)
            $0.width.height.equalTo(102)
        }
    }
    func configure(imageName: String, description: String) {
        logoImageView.image = UIImage(named: imageName)
        writerNameLabel.text = description
    }
}
