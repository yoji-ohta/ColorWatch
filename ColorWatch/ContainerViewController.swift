//
//  ContainerViewController.swift
//  ColorWatch
//
//  Created by 太田洋司 on 2017/01/16.
//  Copyright © 2017年 yjsan. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    var currentIndex: Int = 0
    
    let vcCount: Int = 2
    
    var viewControllers: [UIViewController] = []
    
    lazy var colorViewController: ColorWatchViewController = {
        let id = String(describing: ColorWatchViewController.self)
        let vc = self.storyboard!.instantiateViewController(withIdentifier: id) as! ColorWatchViewController
        self.viewControllers.insert(vc, at: 0)
        return vc
    }()
    
    lazy var countDownViewController: CountDownViewController = {
        let id = String(describing: CountDownViewController.self)
        let vc = self.storyboard!.instantiateViewController(withIdentifier: id) as! CountDownViewController
        self.viewControllers.insert(vc, at: 1)
        return vc
    }()
    
    // MARK: ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeLeft(sender:)))
        swipeLeftGesture.direction = UISwipeGestureRecognizerDirection.left
        view.addGestureRecognizer(swipeLeftGesture)
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeRight(sender:)))
        swipeRightGesture.direction = UISwipeGestureRecognizerDirection.right
        view.addGestureRecognizer(swipeRightGesture)
        
        transitionToViewControllerWith(index: currentIndex)
    }
    
    // MARK: Gesture
    
    func onSwipeLeft(sender: UISwipeGestureRecognizer) {
        currentIndex += 1
        if currentIndex >= vcCount {
            currentIndex = 0
        }
        transitionToViewControllerWith(index: currentIndex)
    }
    
    func onSwipeRight(sender: UISwipeGestureRecognizer) {
        currentIndex -= 1
        if currentIndex < 0 {
            currentIndex = vcCount - 1
        }
        transitionToViewControllerWith(index: currentIndex)
    }
    
    // MARK: Transition
    
    func transitionToViewControllerWith(index: Int) {
        let vc: UIViewController
        switch index {
        case 0:
            vc = colorViewController
        case 1:
            vc = countDownViewController
        default:
            fatalError()
        }
        
        transitionTo(viewController: vc)
    }
    
    func transitionTo(viewController: UIViewController) {
        if let currentViewController = childViewControllers.first {
            
            currentViewController.willMove(toParentViewController: nil)
            addChildViewController(viewController)
            
            currentViewController.view.removeFromSuperview()
            viewController.view.frame = view.bounds
            view.addSubview(viewController.view)
            
            currentViewController.removeFromParentViewController()
            viewController.didMove(toParentViewController: self)
        } else {
            addChildViewController(viewController)
            viewController.view.frame = view.bounds
            view.addSubview(viewController.view)
            viewController.didMove(toParentViewController: self)
        }
    }
    
    // MARK: Misc
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
