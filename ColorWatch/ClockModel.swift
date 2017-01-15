//
//  ClockModel.swift
//  ColorWatch
//
//  Created by 太田洋司 on 2017/01/15.
//  Copyright © 2017年 yjsan. All rights reserved.
//

import Foundation

class ClockModel {
    
    static let shared = ClockModel()
    
    func postNotification() {
        let now = Date()
        let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let component = calendar?.components(
            [NSCalendar.Unit.hour,
            NSCalendar.Unit.minute,
            NSCalendar.Unit.second],
            from: now)
    }
}
