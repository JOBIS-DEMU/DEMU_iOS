import UIKit
import DesignSystem
import Core
import SnapKit
import Then
import RxSwift
import RxCocoa

public class OnboardingViewController: BaseViewController {
    let disposeBag = DisposeBag()
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

    public override func attribute() {
        gradietView.layer.addSublayer(gradietLayer)
        gradietLayer.colors = [
            UIColor.white.cgColor,
            UIColor.gradient.cgColor
        ]
        gradietLayer.startPoint = CGPoint(x: 0.8, y: 1)
        gradietLayer.endPoint = CGPoint(x: 1, y: 0.35)
        gradietLayer.frame = gradietView.bounds
    }

    public override func bindAction() {
        startButton.button.rx.tap
            .bind {
                let vc = LoginViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }

    public override func addView() {
        view.addSubview(gradietView)
        [
            method,
            logoImageView,
            startButton
        ].forEach { gradietView.addSubview($0) }
    }

    public override func layout() {
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

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        gradietLayer.frame = gradietView.bounds
    }
}
