import UIKit
import DesignSystem
import Core
import SnapKit
import Then

class MajorChangeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    private let tableView = UITableView()
    internal let major = ["backend", "frontend", "iOS", "AOS", "AI", "design", "flutter", "full stack", "game", "security", "embedded", "devops", "기타전공"]
    private var selectedIndexPath: IndexPath?
    private let backButton = UIButton().then {
        $0.setImage(UIImage.back, for: .normal)
    }
    private let majorChangeLabel = UILabel().then {
        $0.text = "전공 변경"
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    private let finishButton = DMButtonView(type: .finish)
    override public func attribute() {
        view.backgroundColor = UIColor.background

        tableView.register(MajorChangeCell.self, forCellReuseIdentifier: "MajorChangeCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = false

        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        finishButton.button.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
    }
    override public func addView() {
        [
            majorChangeLabel,
            tableView,
            finishButton
        ].forEach{ view.addSubview($0) }
    }
    override public func layout() {
        majorChangeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(15)
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

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return major.count
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MajorChangeCell", for: indexPath) as? MajorChangeCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.titleLabel.text = major[indexPath.row]
        return cell
    }

    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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

    @objc private func finishButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
