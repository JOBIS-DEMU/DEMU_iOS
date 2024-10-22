import UIKit
import DesignSystem
import Core
import SnapKit
import Then
import RxSwift

class BlogModalViewController: BaseViewController {
    private let titleLabel = UILabel().then {
        $0.text = "backend"
        $0.font = .systemFont(ofSize: 26, weight: .semibold)
        $0.textColor = .main1
    }
    override func attribute() {
        view.backgroundColor = .white
    }
    public override func addView() {
        [
            titleLabel
        ].forEach { view.addSubview($0) }
    }
    public override func layout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(153)
        }
    }    
}
