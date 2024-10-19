import UIKit
import DesignSystem
import Core
import SnapKit
import Then

class HomeViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    private let data = [
        (imageName: "", description: "이지훈"),
        (imageName: "", description: "이지훈"),
        (imageName: "", description: "이지훈"),
        (imageName: "", description: "이지훈"),
        (imageName: "", description: "이지훈"),
        (imageName: "", description: "이지훈"),
        (imageName: "", description: "이지훈"),
        (imageName: "", description: "이지훈")
    ]

    private let tableView = UITableView().then {
        $0.register(CommunityCell.self, forCellReuseIdentifier: "ClubCell")
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 100
    }

    private let majorSelectButton = UIButton().then {
        $0.setTitle("backend", for: .normal)
        $0.tintColor = .main1
        $0.titleLabel?.font = .boldSystemFont(ofSize: .init(24))
    }
    private let popularLabel = UILabel().then {
        $0.text = "대뮤니티, 이 달의 인기글🔥"
        $0.font = .boldSystemFont(ofSize: .init(18))
        $0.textColor = .black
    }
    private let titleImageView = UIImageView().then {
        $0.backgroundColor = .main2
        $0.layer.cornerRadius = 5
    }
    private let titleProfileImageView = UIImageView().then {
        $0.image = UIImage.profile
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
    }
    private let titleNickNameLabel = UILabel().then {
        $0.text = "이지훈"
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
    }
    private let imageBackView = UIView().then {
        $0.backgroundColor = .background2
    }

    override public func attribute() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    override public func addView() {
        [
            popularLabel,
            imageBackView,
            tableView
        ].forEach { view.addSubview($0) }
        imageBackView.addSubview(titleImageView)
        [
            titleProfileImageView,
            titleNickNameLabel
        ].forEach{ titleImageView.addSubview($0) }
    }
    override public func layout() {
        popularLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(15)
        }
        imageBackView.snp.makeConstraints {
            $0.top.equalTo(popularLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(160)
        }
        titleImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(132)
        }
        titleProfileImageView.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(12)
            $0.height.width.equalTo(24)
        }
        titleNickNameLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.equalTo(titleProfileImageView.snp.trailing).offset(4)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(imageBackView.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClubCell", for: indexPath) as? CommunityCell else {
            return UITableViewCell()
        }
        let club = data[indexPath.row]
        cell.configure(imageName: club.imageName, description: club.description)
        return cell
    }
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
