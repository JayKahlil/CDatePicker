//
//  CustomLabel.swift
//  CDatePicker
//
//  Created by Jay Hussaini on 21/05/2019.
//  Copyright © 2019 Jay Hussaini. All rights reserved.
//

import Foundation

class CustomLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    var topInset: CGFloat = 0
    var leftInset: CGFloat = 10
    var bottomInset: CGFloat = 0
    var rightInset: CGFloat = 10
}
