//
//  ClockModel.swift
//  ColorWatch
//
//  Created by 太田洋司 on 2017/01/15.
//  Copyright © 2017年 yjsan. All rights reserved.
//

import Foundation

let TimeGoesNotification = NSNotification.Name("ClockGoesNotification")

class ClockModel {
    
    static let shared = ClockModel()
    
    var timer: Timer?
    
    func start() {
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            self.postNotification()
        })
        self.timer = timer
    }
    
    func stop() {
        timer?.invalidate()
    }
    
    func postNotification() {
        let now = Date()
        let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let component = calendar?.components(
            [NSCalendar.Unit.hour,
             NSCalendar.Unit.minute,
             NSCalendar.Unit.second],
            from: now)
        
        let nc = NotificationCenter.default
        nc.post(name: TimeGoesNotification, object: component)
    }
}
