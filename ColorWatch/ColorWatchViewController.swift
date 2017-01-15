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

    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    func bind() {
        viewModel.dateComponents.asObservable().subscribe(onNext: {[weak self] (dateComponents) in
            
            self?.timeLabel.text = self?.calculateLeftSeconds(components: dateComponents).description
        }, onError: { (error) in
            print(error)
        }, onCompleted: { 
            
        }).addDisposableTo(disposeBag)
    }
    
    private func calculateLeftSeconds(components: DateComponents) -> Int {
        var ret = 0
        
        if let hour = components.hour,
            let minute = components.minute,
            let second = components.second {
            
            var amount = 0
            amount += (hour * 60 * 60)
            amount += (minute * 60)
            amount += second
            ret = (60 * 60 * 24) - amount
        }
        
        return ret
    }
}

