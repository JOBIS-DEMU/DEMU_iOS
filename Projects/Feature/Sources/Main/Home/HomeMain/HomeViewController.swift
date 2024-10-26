import UIKit
import DesignSystem
import Core
import SnapKit
import Then
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, HomeModalViewControllerDelegate {
    private let disposeBag = DisposeBag()
    private let data = [
        (imageName: "", description: "하원", level: "",title: "내가 최고 동아리 은하와 자비스에 합격했던 비결"),
        (imageName: "", description: "히원", level: "", title: "내가 1학년 iOS 짱인 이유"),
        (imageName: "", description: "하원", level: "", title: "먼작귀가 너무 귀여워요"),
        (imageName: "", description: "하원", level: "", title: "컨플릭트 해결"),
        (imageName: "", description: "이지훈", level: "", title: ""),
        (imageName: "", description: "이지훈", level: "", title: ""),
        (imageName: "", description: "이지훈", level: "", title: ""),
        (imageName: "", description: "이지훈", level: "", title: "")
    ]
    private let dropDownLabel = UILabel().then {
        $0.text = "backend"
        $0.font = .systemFont(ofSize: 24, weight: .semibold)
        $0.textColor = .main1
    }
    private let downButton = UIButton().then {
        $0.setImage(UIImage.down, for: .normal)
    }

    private lazy var tableView = UITableView().then {
        $0.backgroundColor = UIColor.background
        $0.separatorStyle = .none
        $0.register(CommunityCell.self, forCellReuseIdentifier: "ClubCell")
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 100
        $0.dataSource = self
        $0.delegate = self
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
        view.backgroundColor = UIColor.background
    }

    override public func bindAction() {
        downButton.rx.tap
            .subscribe(onNext: { [weak self] in
                let modalVC = HomeModalViewController()
                self?.present(modalVC, animated: true, completion: nil)
                modalVC.modalPresentationStyle = .formSheet
                modalVC.modalTransitionStyle = .coverVertical
                modalVC.delegate = self
            })
            .disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = true
    }

    override public func addView() {
        [
            dropDownLabel,
            popularLabel,
            imageBackView,
            tableView,
            downButton
        ].forEach { view.addSubview($0) }
        imageBackView.addSubview(titleImageView)
        [
            titleProfileImageView,
            titleNickNameLabel
        ].forEach {titleImageView.addSubview($0)}
    }
    override public func layout() {
        dropDownLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(0)
            $0.leading.equalTo(24)
        }
        popularLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(46)
            $0.leading.equalTo(16)
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
        downButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            $0.leading.equalTo(dropDownLabel.snp.trailing).offset(12)
            $0.width.equalTo(16)
            $0.height.equalTo(8)
        }
    }

    func didSelectMajor(_ major: String) {
        dropDownLabel.text = major
    }
}

extension HomeViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClubCell", for: indexPath) as? CommunityCell else {
            return UITableViewCell()
        }
        let club = data[indexPath.row]
        cell.configure(imageName: club.imageName, description: club.description, level: club.level, title: club.title)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(PostViewController(), animated: true)
    }
}
