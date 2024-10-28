import UIKit
import DesignSystem
import Core
import SnapKit
import Then
import RxSwift
import RxCocoa

class MajorChangeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    private let disposeBag = DisposeBag()
    private let major = ["backend", "frontend", "iOS", "AOS", "AI", "design", "flutter", "full stack", "game", "security", "embedded", "devops", "기타전공"]
    private var selectedIndexPath: IndexPath?

    private lazy var tableView = UITableView().then {
        $0.register(MajorChangeCell.self, forCellReuseIdentifier: MajorChangeCell.identifier)
        $0.dataSource = self
        $0.delegate = self
        $0.allowsMultipleSelection = false
        $0.backgroundColor = UIColor.background
    }
    private let backButton = UIButton().then {
        $0.setImage(UIImage.back, for: .normal)
    }
    private let majorChangeLabel = UILabel().then {
        $0.text = "전공 변경"
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    private let finishButton = DMButtonView(type: .finish)

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    override func attribute() {
        view.backgroundColor = UIColor.background
    }

    override func bindAction() {
        backButton.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        finishButton.button.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }

    override func addView() {
        [
            majorChangeLabel,
            tableView,
            finishButton
        ].forEach{ view.addSubview($0) }
    }

    override func layout() {
        majorChangeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.equalToSuperview().inset(24)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(majorChangeLabel.snp.bottom).offset(15)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(120)
            $0.leading.trailing.equalToSuperview()
        }
        finishButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(64)
        }
    }
}

extension MajorChangeViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return major.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MajorChangeCell.identifier, for: indexPath) as? MajorChangeCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.titleLabel.text = major[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let previousIndexPath = selectedIndexPath {
            guard let previousCell = tableView.cellForRow(at: previousIndexPath) as? MajorChangeCell else { return }
            previousCell.titleLabel.textColor = UIColor.textField
        }
        guard let cell = tableView.cellForRow(at: indexPath) as? MajorChangeCell else { return }
        cell.titleLabel.textColor = UIColor.main1
        self.finishButton.button.isEnabled = true
        self.finishButton.button.backgroundColor = UIColor.main1
        self.finishButton.button.setTitleColor(UIColor.white, for: .normal)
        selectedIndexPath = indexPath
    }
}
