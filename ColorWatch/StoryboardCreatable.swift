//
//  StoryboardCreatable.swift
//  ColorWatch
//
//  Created by 太田洋司 on 2017/01/16.
//  Copyright © 2017年 yjsan. All rights reserved.
//

import UIKit

protocol StoryboardCreatable {
    
    var storyboardIdentifier: String { get }
    
    func create() -> Self
}

extension StoryboardCreatable where Self: UIViewController {
    
    func create() -> Self {
        return self.storyboard!.instantiateViewController(withIdentifier: String(describing: Self.self)) as! Self
    }
}
