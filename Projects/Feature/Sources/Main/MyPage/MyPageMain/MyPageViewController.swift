import UIKit
import DesignSystem
import Core
import SnapKit
import Then

public class MyPageViewController: BaseViewController {
    private let customBackView = UIView().then {
        $0.backgroundColor = .main1
    }
    private let profileImageView = UIImageView().then {
        $0.image = UIImage.profile
        $0.isUserInteractionEnabled = true
    }
    private let nameLabel = UILabel().then {
        $0.text = "홍길동"
        $0.font = .systemFont(ofSize: 26, weight: .semibold)
    }
    private let majorLabel = UILabel().then {
        $0.text = "backend"
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = .textField
    }
    private let complexTextView = DMTextView(type: .complexintro)
    private let editButton = UIButton().then {
        $0.setImage(UIImage.edit, for: .normal)
    }
    private let remainLabel = UILabel().then {
        $0.text = "다음 등급 까지 30% 남았어요!"
    }
    private let progressView = UIProgressView().then {
        $0.layer.cornerRadius = 20
        $0.progressTintColor = .green
        $0.trackTintColor = .white
        $0.progress = 0.7
    }
    private let progressBackView = UIView().then {
        $0.backgroundColor = UIColor.background2
        $0.layer.cornerRadius = 10
    }
    private let settingLabelView = DMMyLabelView(type: .setting)
    private let settingButton = UIButton().then {
        $0.backgroundColor = UIColor.background2
        $0.layer.cornerRadius = 10
    }
    private let writeLabelView = DMMyLabelView(type: .write)
    private let writeButton = UIButton().then {
        $0.backgroundColor = UIColor.background2
        $0.layer.cornerRadius = 10
    }

    public override func attribute() {
        view.backgroundColor = UIColor.background

        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        settingButton.addTarget(self, action: #selector(settingButtonTapped), for: .touchUpInside)
        writeButton.addTarget(self, action: #selector(writeButtonTapped), for: .touchUpInside)
    }

    public override func addView() {
        [
            customBackView,
            profileImageView,
            nameLabel,
            majorLabel,
            complexTextView,
            remainLabel,
            progressBackView,
            settingButton,
            writeButton
        ].forEach { view.addSubview($0) }
        complexTextView.addSubview(editButton)
        progressBackView.addSubview(progressView)
        settingButton.addSubview(settingLabelView)
        writeButton.addSubview(writeLabelView)
    }

    public override func layout() {
        customBackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.snp.bottom).inset(744)
        }
        profileImageView.snp.makeConstraints {
            $0.bottom.equalTo(view.snp.bottom).inset(673)
            $0.leading.equalTo(20)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(9)
            $0.leading.equalTo(20)
        }
        majorLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(23)
            $0.leading.equalTo(nameLabel.snp.trailing).offset(6)
        }
        complexTextView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(56)
        }
        editButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
        remainLabel.snp.makeConstraints {
            $0.top.equalTo(complexTextView.snp.bottom).offset(6)
            $0.leading.equalTo(20)
        }
        progressBackView.snp.makeConstraints {
            $0.top.equalTo(remainLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(36)
        }
        progressView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(55)
            $0.height.equalTo(10)
        }
        settingLabelView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(52)
        }
        settingButton.snp.makeConstraints {
            $0.top.equalTo(progressBackView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(180)
            $0.height.equalTo(36)
        }
        writeLabelView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(52)
        }
        writeButton.snp.makeConstraints {
            $0.top.equalTo(progressBackView.snp.bottom).offset(10)
            $0.leading.equalTo(settingButton.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(36)
        }
    }

    @objc private func editButtonTapped() {
        self.complexTextView.textView.isEditable = true
    }

    @objc private func settingButtonTapped() {
        self.navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    @objc private func writeButtonTapped() {
        
    }
}
