//
//  ColorWatchViewModel.swift
//  ColorWatch
//
//  Created by 太田洋司 on 2017/01/15.
//  Copyright © 2017年 yjsan. All rights reserved.
//

import Foundation
import RxSwift

class ColorWatchViewModel {
    
    var dateComponents = Variable(DateComponents())
    
    init() {
        
        let nc = NotificationCenter.default
        nc.addObserver(self,
                       selector: #selector(ColorWatchViewModel.onTimeGoes(notification:)),
                       name: TimeGoesNotification,
                       object: nil)
    }
    
    deinit {
        let nc = NotificationCenter.default
        nc.removeObserver(self)
    }
    
    @objc func onTimeGoes(notification: Notification) {
        if let dateComponents = notification.object as? DateComponents {
            self.dateComponents.value = dateComponents
        }
    }
}
