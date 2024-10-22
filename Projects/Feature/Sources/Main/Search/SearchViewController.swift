import UIKit
import DesignSystem
import Core
import SnapKit
import Then

public class SearchViewController: BaseViewController {
    public let searchBar = UISearchBar().then {
        $0.searchBarStyle = .prominent
        $0.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        $0.setImage(UIImage(named: "search"), for: UISearchBar.Icon.search, state: .normal)
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
    public override func attribute() {
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
    public override func addView() {
        [
            searchBar,
            curiousLabel,
            moreLabel
        ].forEach {view.addSubview($0)}
    }
    public override func layout() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(55)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        curiousLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(243)
            $0.leading.trailing.equalToSuperview().inset(86)
        }
        moreLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(268)
            $0.leading.trailing.equalToSuperview().inset(122)
        }
    }
}
