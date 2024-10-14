import UIKit
import DesignSystem
import Core
import SnapKit
import Then

public class OnboardingViewController: BaseViewController {
    let gradietView = UIView()
    let gradietLayer = CAGradientLayer()
    private let method = UILabel().then {
        $0.textColor = .white
        $0.text = "대마고에서\n살아 남는 방법"
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
    }
    private let logoImageView = UIImageView().then {
        $0.image = UIImage.logo
    }
    private let startButton = DMButtonView(type: .start)
    override public func addView() {
        view.addSubview(gradietView)
        [
            method,
            logoImageView,
            startButton
        ].forEach { gradietView.addSubview($0) }
    }
    override public func layout() {
        gradietView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        method.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.leading.equalToSuperview().inset(30)
        }
        logoImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(108)
        }
        startButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(64)
        }
    }
    override public func attribute() {
        gradietView.layer.addSublayer(gradietLayer)
        gradietLayer.colors = [
            UIColor.white.cgColor,
            UIColor.gradient.cgColor
        ]
        gradietLayer.startPoint = CGPoint(x: 0.8, y: 1)
        gradietLayer.endPoint = CGPoint(x: 1, y: 0.35)
        gradietLayer.frame = gradietView.bounds
    }
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradietLayer.frame = gradietView.bounds
    }
}
