import UIKit
import DesignSystem
import Core
import SnapKit
import Then
import RxSwift
import RxCocoa

public class BlogChatViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    private let disposeBag = DisposeBag()
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
    }

    override public func bindAction() {
        commentTextField.rx.text
            .subscribe(onNext: { _ in
                let commentTFNil = !(self.commentTextField.text ?? "").isEmpty
                if commentTFNil {
                    self.registerButton.isEnabled = true
                } else {
                    self.registerButton.isEnabled = false
                }
            })
            .disposed(by: disposeBag)
        registerButton.rx.tap
            .subscribe(onNext: { _ in
                guard let text = self.commentTextField.text, !text.isEmpty else {
                    self.registerButton.isEnabled = false
                    return
                }
                self.clubs.append((imageName: "", description: "하원", chat: text))
                self.tableView.reloadData()
                self.commentTextField.text = ""
            })
            .disposed(by: disposeBag)

        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .subscribe(onNext: { notification in
                if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                    let textFieldYValue = self.view.frame.height - keyboardSize.height - self.commentBackView.frame.height
                    UIView.animate(withDuration: 0.3) {
                                self.commentBackView.frame.origin.y = textFieldYValue
                    }
                }
            })
            .disposed(by: disposeBag)
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .subscribe(onNext: { _ in
                UIView.animate(withDuration: 0.3) {
                        self.commentBackView.frame.origin.y = self.view.frame.height - self.commentBackView.frame.height
                }
            })
            .disposed(by: disposeBag)
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

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
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
