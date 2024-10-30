import UIKit
import DesignSystem
import Core
import SnapKit
import Then
import RxSwift
import RxCocoa

class MoreViewController: BaseViewController {
   private let tableView = UITableView(frame: .zero, style: .grouped).then {
       $0.backgroundColor = .systemGray6
       $0.separatorStyle = .none
       $0.register(MoreTableViewCell.self, forCellReuseIdentifier: MoreTableViewCell.identifier)
   }
   private let section = ["수정하기", "게시물 삭제"]
   
   override func viewDidLoad() {
       super.viewDidLoad()
       view.backgroundColor = .systemGray6
       
       setupUI()
       setupConstraints()
       setupTableView()
   }
   
   private func setupUI() {
       view.addSubview(tableView)
   }
   
   private func setupConstraints() {
       tableView.snp.makeConstraints {
           $0.edges.equalToSuperview()
       }
   }
   
   private func setupTableView() {
       tableView.delegate = self
       tableView.dataSource = self
   }
   
   private func showAlert(for section: Int) {
       let title = section == 0 ? "수정하기" : "게시물 삭제"
       let message = section == 0 ? "게시물을 수정하시겠습니까?" : "게시물을 삭제하시겠습니까?"
       let alertStyle: UIAlertController.Style = .alert
       
       let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
       
       let confirmTitle = section == 0 ? "수정" : "삭제"
       let confirmAction = UIAlertAction(title: confirmTitle, style: section == 0 ? .default : .destructive) { [weak self] _ in
           // 수정 또는 삭제 동작 구현
           if section == 0 {
               // 수정 로직
           } else {
               // 삭제 로직
           }
       }
       
       let cancelAction = UIAlertAction(title: "취소", style: .cancel)
       
       alert.addAction(cancelAction)
       alert.addAction(confirmAction)
       
       present(alert, animated: true)
   }
}

extension MoreViewController: UITableViewDataSource, UITableViewDelegate {
   func numberOfSections(in tableView: UITableView) -> Int {
       return section.count
   }
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
   }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: MoreTableViewCell.identifier, for: indexPath) as? MoreTableViewCell else {
           return UITableViewCell()
       }
       let title = section[indexPath.section]
       cell.configure(with: title)
       return cell
   }
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 50
   }
   
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       return UIView()
   }
   
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return section == 0 ? 0 : 1
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: true)
       showAlert(for: indexPath.section)
   }
}
