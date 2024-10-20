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
    private let commentBackView = UIView().then {
        $0.backgroundColor = .red
    }
    private let commentTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.placeholder = "댓글 입력"
    }
    private let registerButton = UIButton().then {
        $0.setTitle("등록", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .main1
    }
    private var clubs = [
        (imageName: "Pick", description: "이지훈"),
        (imageName: "Dms", description: "이지훈")
    ]
    public override func attribute() {
        tableView.dataSource = self
        tableView.delegate = self
        title = "댓글"
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)

    }
    public override func layout() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(101)
            $0.edges.equalToSuperview()
//            $0.bottom.equalTo(commentBackView.snp.top)
        }
        commentBackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.snp.bottom)
            $0.width.equalTo(390)
            $0.height.equalTo(60)
        }
        commentTextField.snp.makeConstraints {
            $0.top.equalTo(commentBackView).offset(10)
            $0.leading.equalTo(commentBackView).offset(16)
            $0.bottom.equalTo(commentBackView).offset(-10)
        }
        registerButton.snp.makeConstraints {
            $0.leading.equalTo(commentTextField.snp.trailing).offset(8)
            $0.trailing.equalTo(commentBackView).offset(-16)
            $0.centerY.equalTo(commentTextField)
            $0.width.equalTo(50)
        }
    }
    public override func addView() {
        [
            tableView,
            commentBackView
        ].forEach { view.addSubview($0) }
        commentBackView.addSubview(commentTextField)
        commentBackView.addSubview(registerButton)
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clubs.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BlogChatCell", for: indexPath) as? BlogChatCell else {
            return UITableViewCell()
        }
        let club = clubs[indexPath.row]
        cell.configure(profileImage: club.imageName, description: club.description)
        return cell
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    @objc private func didTapRegister() {
        guard let text = commentTextField.text, !text.isEmpty else {
            return
        }
        clubs.append((imageName: "Pick", description: text))
        tableView.reloadData()
        commentTextField.text = ""
    }
}
