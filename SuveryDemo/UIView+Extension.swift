//
//  UIView+Extention.swift
//  SuveryDemo
//
//  Created by long shen on 2023/8/21.
//  Copyright © 2019 Pulse Insights. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func loadViewFromNib() {
        if let view = Bundle.main.loadNibNamed(self.className, owner: self, options: nil)?.first as? UIView {
            addSubview(view)
            view.frame = self.bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
}
