//
//  ViewController.swift
//  ColorWatch
//
//  Created by 太田洋司 on 2017/01/15.
//  Copyright © 2017年 yjsan. All rights reserved.
//

import UIKit
import RxSwift

class ColorWatchViewController: UIViewController {

    let viewModel = ColorWatchViewModel()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    func bind() {
        viewModel.dateComponents.asObservable()
            .subscribe(onNext: {[weak self] (dateComponents) in
                self?.view.backgroundColor = self?.calculateColor(components: dateComponents)
            }).addDisposableTo(disposeBag)
    }
    
    func calculateColor(components: DateComponents) -> UIColor {
        
        var color = UIColor(white: 0, alpha: 1.0)
        if let hour = components.hour,
            let minute = components.minute,
            let second = components.second {
            
            color = UIColor(red: CGFloat(hour) / 24,
                            green: CGFloat(minute) / 60,
                            blue: CGFloat(second) / 60,
                            alpha: 1.0)
        }
        return color
    }
}

