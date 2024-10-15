//
//  TabBarVIewController.swift
//  Feature
//
//  Created by 이지훈 on 10/14/24.
//  Copyright © 2024 com.team.demu. All rights reserved.
//

import UIKit
import SnapKit
import Then
import Core
import DesignSystem

public final class TabBarController: UITabBarController {
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTabbar()
        setAttribute()
    }
    func setTabbar() {
        let tabBar: UITabBar = self.tabBar
        tabBar.layer.borderColor = UIColor.black.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
    }
    func setAttribute() {
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage.homeFalse,
            selectedImage: UIImage.homeTrue
        )
        let searchViewController = SearchViewController()
        searchViewController.tabBarItem = UITabBarItem(
            title: "검색",
            image: UIImage.search,
            selectedImage: UIImage.search
        )
        let blogViewController = BlogViewController()
        blogViewController.tabBarItem = UITabBarItem(
            title: "블로그",
            image: UIImage.vlogFalse,
            selectedImage: UIImage.vlogTrue
        )
        let myPageViewController = MyPageViewController()
        myPageViewController.tabBarItem = UITabBarItem(
            title: "마이페이지",
            image: UIImage.myFalse,
            selectedImage: UIImage.myTrue
        )
        viewControllers = [homeViewController, searchViewController, blogViewController, myPageViewController]
    }
}
