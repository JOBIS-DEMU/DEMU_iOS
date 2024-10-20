import UIKit
import DesignSystem
import Core
import SnapKit
import Then

public class MyPageViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    private let customBackView = UIView().then {
        $0.backgroundColor = .main1
    }
    private let profileImageView = UIImageView().then {
        $0.image = UIImage.profile
        $0.isUserInteractionEnabled = true
    }
    private let nameLabel = UILabel().then {
        $0.text = "홍길동"
        $0.font = .systemFont(ofSize: 26, weight: .semibold)
    }
    private let majorLabel = UILabel().then {
        $0.text = "backend"
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = .textField
    }
    private let complexTextView = DMTextView(type: .complexintro)
    private let editButton = UIButton().then {
        $0.setImage(UIImage.edit, for: .normal)
    }
    private let remainLabel = UILabel().then {
        $0.text = "다음 등급 까지 30% 남았어요!"
    }
    private let progressView = UIProgressView().then {
        $0.layer.cornerRadius = 20
        $0.progressTintColor = .green
        $0.trackTintColor = .white
        $0.progress = 0.7
    }
    private let progressBackView = UIView().then {
        $0.backgroundColor = UIColor.background2
        $0.layer.cornerRadius = 10
    }
    private let settingLabelView = DMMyLabelView(type: .setting)
    private let settingButton = UIButton().then {
        $0.backgroundColor = UIColor.background2
        $0.layer.cornerRadius = 10
    }
    private let writeLabelView = DMMyLabelView(type: .write)
    private let writeButton = UIButton().then {
        $0.backgroundColor = UIColor.background2
        $0.layer.cornerRadius = 10
    }
    private let tableView = UITableView().then {
        $0.backgroundColor = UIColor.background
        $0.separatorStyle = .none
        $0.register(MyPageCell.self, forCellReuseIdentifier: "ClubCell")
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 100
    }
    
    private let data = [
        (imageName: "", description: "하원", level: "",title: "내가 최고 동아리 은하와 자비스에 합격했던 비결", detail: "이번 글에서는 제가 동아리에 합격할 수 있었던 이유를 소개해 보려고 합니다. 네 저는 -1살 때부터 코딩을 시작했는데요. 네.. 코딩을 너무 늦게 시작했죠."),
        (imageName: "", description: "히원", level: "", title: "내가 1학년 iOS 짱인 이유", detail: "그냥 내가 짱이니까"),
        (imageName: "", description: "하원", level: "", title: "먼작귀가 너무 귀여워요", detail: "모두 치이카와 보구 가세용~"),
        (imageName: "", description: "하원", level: "", title: "컨플릭트 해결", detail: "누가 컨플릭트 좀 해결해주세요 ㅜㅜ 이런 경우 어떻게 해결하나요 ㅜ"),
        (imageName: "", description: "이지훈", level: "", title: "", detail: ""),
        (imageName: "", description: "이지훈", level: "", title: "", detail: ""),
        (imageName: "", description: "이지훈", level: "", title: "", detail: ""),
        (imageName: "", description: "이지훈", level: "", title: "", detail: "")
    ]

    public override func attribute() {
        view.backgroundColor = UIColor.background

        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        settingButton.addTarget(self, action: #selector(settingButtonTapped), for: .touchUpInside)
        writeButton.addTarget(self, action: #selector(writeButtonTapped), for: .touchUpInside)
        tableView.dataSource = self
        tableView.delegate = self

    }

    public override func addView() {
        [
            customBackView,
            profileImageView,
            nameLabel,
            majorLabel,
            complexTextView,
            remainLabel,
            progressBackView,
            settingButton,
            writeButton,
            tableView
        ].forEach { view.addSubview($0) }
        complexTextView.addSubview(editButton)
        progressBackView.addSubview(progressView)
        settingButton.addSubview(settingLabelView)
        writeButton.addSubview(writeLabelView)
    }

    public override func layout() {
        customBackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.snp.bottom).inset(744)
        }
        profileImageView.snp.makeConstraints {
            $0.bottom.equalTo(view.snp.bottom).inset(673)
            $0.leading.equalTo(20)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(9)
            $0.leading.equalTo(20)
        }
        majorLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(23)
            $0.leading.equalTo(nameLabel.snp.trailing).offset(6)
        }
        complexTextView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(56)
        }
        editButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
        remainLabel.snp.makeConstraints {
            $0.top.equalTo(complexTextView.snp.bottom).offset(6)
            $0.leading.equalTo(20)
        }
        progressBackView.snp.makeConstraints {
            $0.top.equalTo(remainLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(36)
        }
        progressView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(55)
            $0.height.equalTo(10)
        }
        settingLabelView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(52)
        }
        settingButton.snp.makeConstraints {
            $0.top.equalTo(progressBackView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(180)
            $0.height.equalTo(36)
        }
        writeLabelView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(52)
        }
        writeButton.snp.makeConstraints {
            $0.top.equalTo(progressBackView.snp.bottom).offset(10)
            $0.leading.equalTo(settingButton.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(36)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(settingButton.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    @objc private func editButtonTapped() {
        self.complexTextView.textView.isEditable = true
    }

    @objc private func settingButtonTapped() {
        self.navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    @objc private func writeButtonTapped() {
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClubCell", for: indexPath) as? CommunityCell else {
            return UITableViewCell()
        }
        let club = data[indexPath.row]
        cell.configure(imageName: club.imageName, description: club.description, level: club.level, title: club.title, detail: club.detail)
        cell.selectionStyle = .none
        return cell
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
