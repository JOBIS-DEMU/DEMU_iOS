import UIKit
import DesignSystem
import Core
import SnapKit
import Then
import RxSwift
import RxCocoa

class MoreTableViewCell: UITableViewCell {
   static let identifier = "MoreTableViewCell"
   private let titleLabel = UILabel().then {
       $0.font = .systemFont(ofSize: 16)
       $0.textColor = .black
   }
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       setupUI()
       setupConstraints()
   }
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   private func setupUI() {
       backgroundColor = .white
       selectionStyle = .default
       contentView.addSubview(titleLabel)
   }
   private func setupConstraints() {
       titleLabel.snp.makeConstraints {
           $0.centerY.equalToSuperview()
           $0.leading.equalToSuperview().offset(10)
       }
       contentView.snp.makeConstraints {
           $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
       }
   }
   func configure(with title: String) {
       titleLabel.text = title
       titleLabel.textColor = title == "게시물 삭제" ? .red : .black
   }
}

class MoreTableViewController: UITableViewController {
   override func viewDidLoad() {
       super.viewDidLoad()
       tableView.register(MoreTableViewCell.self, forCellReuseIdentifier: MoreTableViewCell.identifier)
       tableView.rowHeight = 44
   }
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
   }
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if let cell = tableView.dequeueReusableCell(withIdentifier: MoreTableViewCell.identifier, for: indexPath) as? MoreTableViewCell {
           cell.configure(with: "Sample Title \(indexPath.row + 1)")
           return cell
       } else {
           return UITableViewCell()
       }
   }
}
