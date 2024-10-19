import UIKit
import DesignSystem
import Core
import SnapKit
import Then

public class BlogCharViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView().then {
        $0.register(BlogChatCell.self, forCellReuseIdentifier: "BlogChatCell")
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 100
    }
    private let clubs = [
        (imageName: "Pick", description: "이지훈"),
        (imageName: "Dms", description: "이지훈"),
    ]
    public override func attribute() {
        tableView.dataSource = self
        tableView.delegate = self
        title = "댓글"
    }
    public override func layout() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(57)
            $0.leading.trailing.edges.equalTo(view)
        }
    }
    public override func addView() {
        [
            tableView
        ].forEach {view.addSubview($0)}
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clubs.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BlogChatCell", for: indexPath) as? BlogChatCell else {
            return UITableViewCell()
        }
        let club = clubs[indexPath.row]
        cell.configure(imageName: club.imageName, description: club.description)
        return cell
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
