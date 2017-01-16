//
//  CountDownViewModel.swift
//  ColorWatch
//
//  Created by 太田洋司 on 2017/01/16.
//  Copyright © 2017年 yjsan. All rights reserved.
//

import UIKit
import RxSwift

class CountDownViewModel {
    
    var dateComponents: Variable<DateComponents> = {
        let now = Date()
        let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let component = calendar?.components(
            [NSCalendar.Unit.hour,
             NSCalendar.Unit.minute,
             NSCalendar.Unit.second],
            from: now)
        return Variable(component!)
    }()
    
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
    }}
