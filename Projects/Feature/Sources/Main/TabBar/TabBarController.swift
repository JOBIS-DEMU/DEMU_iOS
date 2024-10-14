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

final class TabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setAttribute()
        setTabbar()
    }
    func setTabbar() {
        let tabBar: UITabBar = self.tabBar
        tabBar.layer.borderColor = UIColor.black.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
        self.hidesBottomBarWhenPushed = true
    }
    
    
    
    func setAttribute() {
        let searchViewController = SearchViewController()
        searchViewController.tabBarItem = UITabBarItem(
            title: "유저검색",
            image: UIImage(named: "userSearch")!,
            selectedImage: UIImage(named: "userSearch")!
        )
        
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(named: "home")!,
            selectedImage: UIImage(named: "home")!
        )
        
        let blogViewController = BlogViewController()
        blogViewController.tabBarItem = UITabBarItem(
            title: "찜",
            image: UIImage(named: "heart")!,
            selectedImage: UIImage(named: "heart")!
        )
        
        let myPageViewController = MyPageViewController()
        myPageViewController.tabBarItem = UITabBarItem(
            title: "프로필",
            image: UIImage(named: "user")!,
            selectedImage: UIImage(named: "user")!
        )
        viewControllers = [searchViewController, homeViewController, blogViewController, myPageViewController]
    }
}
