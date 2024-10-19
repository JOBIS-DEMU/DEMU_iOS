import UIKit
import DesignSystem
import Core
import SnapKit
import Then

public class HomeViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
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
    private let imageBackView = UIView().then {
        $0.backgroundColor = .background2
    }
    private let titleImageView = UIImageView().then {
        $0.backgroundColor = .main2
        $0.layer.cornerRadius = 5
    }
    private let data = [
        (imageName: "", description: "유재민"),
        (imageName: "", description: "유재민"),
        (imageName: "", description: "유재민"),
        (imageName: "", description: "유재민"),
        (imageName: "", description: "유재민"),
        (imageName: "", description: "유재민"),
        (imageName: "", description: "유재민"),
        (imageName: "", description: "유재민")
    ]
    private let tableView = UITableView().then {
        $0.register(CommunityCell.self, forCellReuseIdentifier: "ClubCell")
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 100
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        addView()
        layout()
    }

    public override func addView() {
        [
            popularLabel,
            imageBackView,
            tableView
        ].forEach { view.addSubview($0) }
        imageBackView.addSubview(titleImageView)
    }
    public override func layout() {
        popularLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(46)
            $0.leading.equalTo(15)
        }
        imageBackView.snp.makeConstraints {
            $0.top.equalTo(popularLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(160)
        }
        titleImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(334)
            $0.height.equalTo(132)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(imageBackView.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClubCell", for: indexPath) as? CommunityCell else {
            return UITableViewCell()
        }
        let club = data[indexPath.row]
        cell.configure(imageName: club.imageName, description: club.description)
        return cell
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
