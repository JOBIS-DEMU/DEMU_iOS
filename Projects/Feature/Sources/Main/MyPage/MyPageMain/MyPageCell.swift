import UIKit
import DesignSystem
import Core
import SnapKit
import Then

class MyPageCell: UITableViewCell {
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
    private let levelImageView = UIImageView()
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
    }
    private let detailLabel = UILabel().then {
        $0.numberOfLines = 4
        $0.textColor = UIColor.textField
        $0.font = .systemFont(ofSize: 10)
    }
    private let heartButton = UIButton().then {
        $0.setImage(UIImage.heart, for: .normal)
    }
    private let heartNumberLabel = UILabel().then {
        $0.text = "16"
        $0.textColor = UIColor.textField
        $0.font = .systemFont(ofSize: 9, weight: .semibold)
    }
    private let commentButton = UIButton().then {
        $0.setImage(UIImage.comment, for: .normal)
    }
    private let commetNumberLabel = UILabel().then {
        $0.text = "16"
        $0.textColor = UIColor.textField
        $0.font = .systemFont(ofSize: 9, weight: .semibold)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = UIColor.white
        self.backgroundColor = .background
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
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
            levelImageView,
            logoImageView,
            titleLabel,
            detailLabel,
            heartButton,
            heartNumberLabel,
            commentButton,
            commetNumberLabel
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
        levelImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalTo(writerNameLabel.snp.trailing).offset(4)
            $0.height.equalTo(16)
            $0.width.equalTo(15)
        }
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(14)
            $0.width.height.equalTo(102)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(writerNameLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(14)
            $0.width.equalTo(220)
        }
        detailLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(14)
            $0.width.equalTo(220)
        }
        heartButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(14)
            $0.height.equalTo(11)
        }
        heartNumberLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(13)
            $0.leading.equalTo(heartButton.snp.trailing).offset(4)
        }
        commentButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.equalTo(heartNumberLabel.snp.trailing).offset(8)
            $0.height.equalTo(11)
        }
        commetNumberLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(13)
            $0.leading.equalTo(commentButton.snp.trailing).offset(4)
        }
    }
    func configure(imageName: String, description: String, level: String, title: String, detail: String) {
        logoImageView.image = UIImage(named: imageName)
        writerNameLabel.text = description
        levelImageView.image = UIImage.bronze
        titleLabel.text = title
        detailLabel.text = detail
    }
}
