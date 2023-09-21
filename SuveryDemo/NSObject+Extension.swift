//
//  NSObject+Extension.swift
//  SuveryDemo
//
//  Created by long shen on 2023/8/21.
//  Copyright © 2023 Pulse Insights. All rights reserved.
//

import Foundation

extension NSObject {
    
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }

    static var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}
