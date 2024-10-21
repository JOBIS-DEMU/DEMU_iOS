import UIKit
import DesignSystem
import Core
import SnapKit
import Then

public class BlogChatViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    private var clubs = [
        (imageName: "", description: "이지훈", chat: ""),
        (imageName: "", description: "이지훈", chat: "어쩔팁이 저쩔팁이 안물안궁 어미ㅏㅓㅇ라ㅓㅁ아ㅓㄹ마ㅣㅓ이라ㅓ")
    ]
    private let tableView = UITableView().then {
        $0.register(BlogChatCell.self, forCellReuseIdentifier: "BlogChatCell")
    }
    private let commentBackView = UIView().then {
        $0.backgroundColor = .red
    }
    private let commentTextField = UITextField().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.textField.cgColor
        $0.placeholder = "댓글 입력"
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        $0.leftViewMode = .always
        $0.becomeFirstResponder()
    }
    private let registerButton = UIButton().then {
        $0.setTitle("등록", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .main1
        $0.isEnabled = true
    }

    public override func attribute() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        title = "댓글"
        commentTextField.addTarget(self, action: #selector(updateRegisterButton), for: .editingChanged)
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)

    }
    public override func addView() {
        [
            tableView,
            commentBackView
        ].forEach { view.addSubview($0) }
        commentBackView.addSubview(commentTextField)
        commentBackView.addSubview(registerButton)
    }
    public override func layout() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(101)
            $0.edges.equalToSuperview()
        }
        commentBackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(18)
            $0.height.equalTo(50)
        }
        commentTextField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        registerButton.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.leading.equalTo(commentTextField.snp.trailing)
            $0.width.equalTo(80)
        }
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clubs.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BlogChatCell", for: indexPath) as? BlogChatCell else {
            return UITableViewCell()
        }
        let club = clubs[indexPath.row]
        cell.configure(profileImage: club.imageName, description: club.description, chat: club.chat)
        return cell
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    @objc private func updateRegisterButton() {
        let commentTFNil = !(commentTextField.text ?? "").isEmpty
        if commentTFNil {
            registerButton.isEnabled = true
        } else {
            registerButton.isEnabled = false
        }
    }
    @objc private func didTapRegister() {
        guard let text = commentTextField.text, !text.isEmpty else {
            registerButton.isEnabled = false
            return
        }
        clubs.append((imageName: "", description: "이지훈", chat: text))
        tableView.reloadData()
        commentTextField.text = ""
    }
}
