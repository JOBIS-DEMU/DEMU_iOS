import UIKit
import DesignSystem
import Core
import SnapKit
import Then

class MajorChangeCell: UITableViewCell {
    public let identifier: String = "MajorChangeCell"

    public let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.textColor = UIColor.textField
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        attribute()
        addView()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func attribute() {
        self.backgroundColor = UIColor.background
    }
    private func addView() {
        self.addSubview(titleLabel)
    }
    private func layout() {
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
        }
    }
}
