//
//  ViewController.swift
//  DemoCustomizableDatePicker
//
//  Created by Hyder Hussaini on 21/05/2019.
//  Copyright © 2019 Jay Hussaini. All rights reserved.
//

import UIKit
import CDatePicker

class ViewController: UIViewController {
    
    @IBOutlet weak var picker: CustomizableDataPicker!
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        picker.textColor = UIColor.magenta
        
        NotificationCenter.default.addObserver(self, selector: #selector(dateChanged(_:)), name: Notification.Name.CDatePickerValueChanged, object: picker)
    }

    @objc func dateChanged(_ notification:Notification) {
        let calendar = Calendar(identifier: .gregorian)
        let comps = calendar.dateComponents([.year, .month, .day], from: picker.date)
        label.text = "Y: \(comps.year ?? 0) M: \(comps.month ?? 0) D: \(comps.day ?? 0)"
    }
}

extension Notification.Name {
    static let CDatePickerValueChanged = Notification.Name("CDatePickerValueChanged")
}
