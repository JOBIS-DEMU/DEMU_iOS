import UIKit
import DesignSystem
import Core
import SnapKit
import Then
import RxSwift

public class BlogChatViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    private var clubs = [
        (imageName: "", description: "이지훈", chat: ""),
        (imageName: "", description: "이지훈", chat: "어쩔팁이 저쩔팁이 안물안궁 어미ㅏㅓㅇ라ㅓㅁ아ㅓㄹ마ㅣㅓ이라ㅓ")
    ]
    private lazy var tableView = UITableView().then {
        $0.dataSource = self
        $0.delegate = self
        $0.register(BlogChatCell.self, forCellReuseIdentifier: "BlogChatCell")
    }
    private let backButton = UIButton().then {
        $0.setImage(UIImage.back, for: .normal)
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
    }
    private let registerButton = UIButton().then {
        $0.setTitle("등록", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .main1
        $0.isEnabled = true
    }
    
    public override func attribute() {
        title = "댓글"
        commentTextField.addTarget(self, action: #selector(updateRegisterButton), for: .editingChanged)
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
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

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let textFieldYValue = view.frame.height - keyboardSize.height - commentBackView.frame.height
            UIView.animate(withDuration: 0.3) {
                        self.commentBackView.frame.origin.y = textFieldYValue
            }
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.3) {
                self.commentBackView.frame.origin.y = self.view.frame.height - self.commentBackView.frame.height
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
        clubs.append((imageName: "", description: "하원", chat: text))
        tableView.reloadData()
        commentTextField.text = ""
    }
    let disposeBag = DisposeBag()
}

extension BlogChatViewController {
    public func tableView(_ tableView: UITableView, heightForRowAtindexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
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
}
