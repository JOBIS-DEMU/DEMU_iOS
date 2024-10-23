import UIKit
import DesignSystem
import Core
import SnapKit
import Then

public class PostViewController: BaseViewController, UIScrollViewDelegate {
    private var images: [String] = []
    private var isHeartSelected = false
    private let scrollView = UIScrollView().then {
        $0.alwaysBounceVertical = true
        $0.alwaysBounceHorizontal = false
    }
    private let contentView = UIView()
    private let titleBackView = UIView().then {
        $0.backgroundColor = UIColor.background
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.background2.cgColor
    }
    private let topBackView = UIView().then {
        $0.backgroundColor = .background
    }
    private let beforeButton = UIButton().then {
        $0.setImage(UIImage.before, for: .normal)
    }
    private let titleLabel = UILabel().then {
        $0.text = "iOS 잘하는 법에 대해 알아봅시다 람쥐귀엽다구리까기"
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 26, weight: .semibold)
    }
    private let writerProfileImageView = UIImageView().then {
        $0.image = UIImage.profile
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
    }
    private let writerNameLabel = UILabel().then {
        $0.text = "하원"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        $0.textColor = .black
    }
    private let levelImageView = UIImageView().then {
        $0.image = UIImage.gold
    }
    private let moreButton = UIButton().then {
        $0.setImage(UIImage.more, for: .normal)
    }
    private lazy var imageScrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.delegate = self
    }
    private let imagePageControl = UIPageControl().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.currentPage = 0
        $0.currentPageIndicatorTintColor = .white
        $0.hidesForSinglePage = true
    }
    private let detailLabel = UILabel().then {
        $0.text = "iOS를 어떻게 해야 잘 할 수 있나요??\n라고 다들 많이 물어보시더라구요. 그래서 오늘 가져온 것은 바로 \niOS 잘 하는 법!!  빨리 알아봅시당\n\n냠냠\n\n\n\n냠냠\n\n\n\n냠냠\n\n\n\n냠냠\n\n\n\n냠냠\n\n\n\n냠냠\n\n\n\n냠냠\n\n\n\n냠냠\n\n\n\n냠냠"
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 15, weight: .regular)
    }
    private let bottomBackView = UIView().then {
        $0.backgroundColor = UIColor.background
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.background2.cgColor
    }
    private let heartImageView = UIImageView().then {
        $0.image = UIImage.heart
        $0.isUserInteractionEnabled = true
    }
    private let heartNumberLabel = UILabel().then {
        $0.text = "16"
        $0.textColor = UIColor.textField
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
    }
    private let commentImageView = UIImageView().then {
        $0.image = UIImage.comment
        $0.isUserInteractionEnabled = true
    }
    private let commetNumberLabel = UILabel().then {
        $0.text = "16"
        $0.textColor = UIColor.textField
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
    }
    public override func attribute() {
        view.backgroundColor = UIColor.background
        setImageSlider(images: ["DEMU_Profile", "image2", "image3"])
        let heartTapGesture = UITapGestureRecognizer(target: self, action: #selector(heartImageViewTapped))
           heartImageView.addGestureRecognizer(heartTapGesture)
        let commentTapGesture = UITapGestureRecognizer(target: self, action: #selector(commentImageViewTapped))
            commentImageView.addGestureRecognizer(commentTapGesture)
        beforeButton.addTarget(self, action: #selector(beforeButtonTapped), for: .touchUpInside)
    }
    override public func addView() {
        [
            scrollView,
            titleBackView,
            bottomBackView,
            topBackView
        ].forEach { view.addSubview($0) }
        scrollView.addSubview(contentView)
        [
            beforeButton
        ].forEach { topBackView.addSubview($0) }
        [
            imageScrollView,
            imagePageControl,
            detailLabel
        ].forEach { contentView.addSubview($0) }
        [
            titleLabel,
            writerProfileImageView,
            writerNameLabel,
            levelImageView,
            moreButton
        ].forEach { titleBackView.addSubview($0) }
        [
            heartImageView,
            heartNumberLabel,
            commentImageView,
            commetNumberLabel
        ].forEach { bottomBackView.addSubview($0) }
    }
    override public func layout() {
        topBackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(750)
            $0.width.equalTo(390)
            $0.height.equalTo(101)
        }
        beforeButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(14)
            $0.leading.equalTo(24)
        }

        titleBackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(57)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(writerProfileImageView.snp.bottom).offset(10)
        }
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        writerProfileImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(24)
            $0.height.width.equalTo(24)
        }
        writerNameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.leading.equalTo(writerProfileImageView.snp.trailing).offset(8)
        }
        levelImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(17)
            $0.leading.equalTo(writerNameLabel.snp.trailing).offset(4)
            $0.height.equalTo(15)
            $0.width.equalTo(14)
        }
        moreButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(13)
            $0.trailing.equalToSuperview().inset(24)
        }
        imageScrollView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(190)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(170)
        }
        imagePageControl.snp.makeConstraints {
            $0.bottom.equalTo(imageScrollView.snp.bottom).offset(-10)
            $0.centerX.equalToSuperview()
        }
        detailLabel.snp.makeConstraints {
            $0.top.equalTo(imageScrollView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().offset(-20)
        }
        bottomBackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(100)
        }
        heartImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
            $0.width.equalTo(18)
            $0.height.equalTo(16)
        }
        heartNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalTo(heartImageView.snp.trailing).offset(5)
        }
        commentImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalTo(heartNumberLabel.snp.trailing).offset(5)
            $0.height.width.equalTo(18)
        }
        commetNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalTo(commentImageView.snp.trailing).offset(5)
        }
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
}

extension PostViewController {
    func setImageSlider(images: [String]) {
        self.images = images
        imagePageControl.numberOfPages = images.count
        for index in 0..<images.count {
            let imageView = UIImageView()
            imageView.image = UIImage.major
            imageView.contentMode = .scaleAspectFit
            imageView.layer.cornerRadius = 5
            imageView.clipsToBounds = true
            let xPosition = self.view.frame.width * CGFloat(index)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.view.frame.width, height: self.view.frame.width)
            imageScrollView.contentSize.width = self.view.frame.width * CGFloat(index + 1)
            imageScrollView.addSubview(imageView)
        }
    }
    @objc private func heartImageViewTapped() {
        isHeartSelected.toggle()
        if isHeartSelected {
            heartImageView.image = UIImage.heartFilled
        } else {
            heartImageView.image = UIImage.heart
        }
    }
    @objc private func commentImageViewTapped() {
        let commentVC = BlogChatViewController()
        navigationController?.pushViewController(commentVC, animated: true)
    }
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(round(imageScrollView.contentOffset.x / UIScreen.main.bounds.width))
        imagePageControl.currentPage = currentPage
    }
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    @objc private func beforeButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
