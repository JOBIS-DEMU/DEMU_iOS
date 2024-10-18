import UIKit
import DesignSystem
import Core
import SnapKit
import Then

class SettingViewController: BaseViewController {
    private let profileView = DMBackView(type: .profile)
    private let nickNameView = DMBackView(type: .nickname)
    private let pwdView = DMBackView(type: .pwd)
    private let majorView = DMBackView(type: .major)
    private let logoutView = DMBackView(type: .logout)

    override public func attribute() {
        view.backgroundColor = UIColor.background

        nickNameView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nickNameTapped)))
        pwdView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pwdTapped)))
        majorView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(majorTapped)))
        logoutView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logoutTapped)))
    }
    override public func addView() {
        [
            profileView,
            nickNameView,
            pwdView,
            majorView,
            logoutView
        ].forEach{ view.addSubview($0) }
    }
    override public func layout() {
        profileView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        nickNameView.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(45)
        }
        pwdView.snp.makeConstraints {
            $0.top.equalTo(nickNameView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(45)
        }
        majorView.snp.makeConstraints {
            $0.top.equalTo(pwdView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(45)
        }
        logoutView.snp.makeConstraints {
            $0.top.equalTo(majorView.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(45)
        }
    }
    @objc private func nickNameTapped() {
        print("nick")
    }
    @objc private func pwdTapped() {
        print("pwd")
    }
    @objc private func majorTapped() {
        print("major")
    }
    @objc private func logoutTapped() {
        print("logout")
    }
}
