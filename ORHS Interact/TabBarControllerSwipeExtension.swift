//
//  TabBarControllerSwipeExtension.swift
//  SwipeTabBar-Swift
//
//  Created by Cezar Carvalho Pereira on 23/1/15.
//  Copyright (c) 2015 Wavebits. All rights reserved.
//

import UIKit

extension UITabBarController {
    func setupSwipeGestureRecognizers(_ cycleThroughTabs: Bool = false) {
        let swipeLeftGestureRecognizer = UISwipeGestureRecognizer(target: self, action: cycleThroughTabs ? #selector(UITabBarController.handleSwipeLeftAllowingCyclingThroughTabs(_:))
            : #selector(UITabBarController.handleSwipeLeft(_:)))
        swipeLeftGestureRecognizer.direction = .left
        self.tabBar.addGestureRecognizer(swipeLeftGestureRecognizer)
        
        let swipeRightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: cycleThroughTabs ? #selector(UITabBarController.handleSwipeRightAllowingCyclingThroughTabs(_:))
            : #selector(UITabBarController.handleSwipeRight(_:)))
        swipeRightGestureRecognizer.direction = .right
        self.tabBar.addGestureRecognizer(swipeRightGestureRecognizer)
    }
    
    func handleSwipeLeft(_ swipe: UISwipeGestureRecognizer) {
        self.selectedIndex -= 1
    }
    
    func handleSwipeRight(_ swipe: UISwipeGestureRecognizer) {
        self.selectedIndex += 1
    }
    
    func handleSwipeLeftAllowingCyclingThroughTabs(_ swipe: UISwipeGestureRecognizer) {
        let maxIndex = (self.viewControllers?.count ?? 0)
        let nextIndex = self.selectedIndex - 1
        self.selectedIndex = nextIndex >= 0 ? nextIndex : maxIndex - 1
        
    }
    
    func handleSwipeRightAllowingCyclingThroughTabs(_ swipe: UISwipeGestureRecognizer) {
        let maxIndex = (self.viewControllers?.count ?? 0)
        let nextIndex = self.selectedIndex + 1
        self.selectedIndex = nextIndex < maxIndex ? nextIndex : 0
    }
}
