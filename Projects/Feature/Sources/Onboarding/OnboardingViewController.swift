import UIKit
import DesignSystem
import Core
import SnapKit
import Then

public class OnboardingViewController: BaseViewController {
    private let method = UILabel().then {
        $0.textColor = .white
        $0.text = "대마고에서\n살아 남는 방법"
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
    }
    private let logoImageView = UIImageView().then {
        $0.image = UIImage.logo
    }
    private let startButton = DMButton(type: .start)
    override public func addView() {
        [
            method,
            logoImageView,
            startButton
        ].forEach { view.addSubview($0) }
    }
    override public func layout() {
        method.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.equalToSuperview().inset(29)
            $0.trailing.equalToSuperview().inset(126)
            $0.height.equalTo(96)
        }

        logoImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(108)
        }
        
        startButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(64)
        }
    }
    override public func attribute() {
        view.backgroundColor = UIColor.error
    }
}
