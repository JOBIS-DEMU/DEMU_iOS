import UIKit
import DesignSystem
import Core
import SnapKit
import Then
import RxSwift

protocol BlogModalViewControllerDelegate: AnyObject {
    func didSelectMajor(_ major: String)
}

class BlogModalViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    weak var delegate: BlogModalViewControllerDelegate?
    private let tableView = UITableView()
    let major = ["backend", "frontend", "iOS", "AOS", "AI", "design", "flutter", "full stack", "game", "security", "embedded", "devops", "기타 전공", "전체 글"]
    private var selectedIndexPath: IndexPath?
    private let backButton = UIButton().then {
        $0.setImage(UIImage.back, for: .normal)
    }
    private let titleLabel = UILabel().then {
        $0.text = "backend"
        $0.font = .systemFont(ofSize: 26, weight: .semibold)
        $0.textColor = .main1
    }

    public override func addView() {
        [
            titleLabel,
            tableView
        ].forEach { view.addSubview($0) }
    }

    override func attribute() {
        view.backgroundColor = UIColor.background
        tableView.register(BlogModalCell.self, forCellReuseIdentifier: "blogModalCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = false
    }

    public override func layout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(120)
            $0.leading.trailing.equalToSuperview()
        }
    }

    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return major.count
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "blogModalCell", for: indexPath) as? BlogModalCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.titleLabel.text = major[indexPath.row]
        return cell
    }

    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let previousIndexPath = selectedIndexPath {
            guard let previousCell = tableView.cellForRow(at: previousIndexPath) as? BlogModalCell else { return }
            previousCell.titleLabel.textColor = UIColor.textField
        }
        guard let cell = tableView.cellForRow(at: indexPath) as? BlogModalCell else { return }
        cell.titleLabel.textColor = UIColor.main1
        selectedIndexPath = indexPath
        let selectedMajor = major[indexPath.row]
        titleLabel.text = selectedMajor
        delegate?.didSelectMajor(selectedMajor)
        self.dismiss(animated: true, completion: nil)
    }
}
