import UIKit
import DesignSystem
import Core
import SnapKit
import Then

class SearchViewController: BaseViewController {
    static let identifier: String = "SearchCell"

    private let searchBar = UISearchBar().then {
        $0.searchBarStyle = .prominent
        $0.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        $0.setImage(UIImage(named: "search"), for: UISearchBar.Icon.search, state: .normal)
    }

    private let tableView = UITableView().then {
        $0.backgroundColor = .background
        $0.separatorStyle = .none
        $0.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        $0.rowHeight = 150
    }

    private let curiousLabel = UILabel().then {
        $0.text = "궁금한 글을 찾아보세요"
        $0.font = .systemFont(ofSize: 22, weight: .medium)
        $0.textColor = .black
    }
    private let moreLabel = UILabel().then {
        $0.text = "더 많은 지식을 찾아봐요!"
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = .lightGray
    }
    private var allSearchResults: [SearchResult] = [
        SearchResult(imageName: "image", description: "작성자1", level: "bronze", title: "테스트 게시글1"),
        SearchResult(imageName: "image", description: "작성자2", level: "bronze", title: "테스트 게시글2"),
        SearchResult(imageName: "image", description: "작성자3", level: "bronze", title: "다른 게시글3")
    ]

    private var searchResult: [SearchResult] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }

    override func attribute() {
        view.backgroundColor = .white

        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor.background2
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.background.cgColor
            textField.layer.cornerRadius = 5
            textField.placeholder = "검색"
            self.navigationItem.hidesBackButton = true
        }
    }
    override func addView() {
        [
            searchBar,
            tableView,
            curiousLabel,
            moreLabel
        ].forEach { view.addSubview($0) }
    }
    override func layout() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        curiousLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(243)
            $0.centerX.equalToSuperview()
        }

        moreLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(268)
            $0.centerX.equalToSuperview()
        }
    }
    private func updateLabel() {
        curiousLabel.isHidden = !searchResult.isEmpty
        moreLabel.isHidden = !searchResult.isEmpty
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else {
            return UITableViewCell()
        }
        let result = searchResult[indexPath.row]
        cell.configure(imageName: result.imageName,
                      description: result.description,
                      level: result.level,
                      title: result.title)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(PostViewController(), animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            searchResult = allSearchResults.filter { result in
                return result.title.lowercased().contains(searchText.lowercased()) ||
                       result.description.lowercased().contains(searchText.lowercased())
            }
        } else {
            searchResult = []
        }
        updateLabel()
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
