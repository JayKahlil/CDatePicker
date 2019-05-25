//
//  CustomizableDataPicker.swift
//  CustomizableDatePicker
//
//  Created by Jay Hussaini on 20/05/2019.
//  Copyright © 2019 Jay Hussaini. All rights reserved.
//

import Foundation
import UIKit

public class CustomizableDataPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        dataSource = self
        delegate = self
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        dataSource = self
        delegate = self
        setup()
    }
    
    private func setup() {
        data = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"],
                      ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
                      getYears()]
    
        selectRow(201 * data[0].count, inComponent: 0, animated: false)
        selectRow(201 * data[1].count, inComponent: 1, animated: false)
        selectRow(201 * data[2].count + (initialSelectedYear - startYear), inComponent: 2, animated: false)
    }
    
    public var startYear: Int = 1900 {
        didSet {
            setup()
        }
    }
    
    public var endYear: Int = 2100 {
        didSet {
            setup()
        }
    }
    
    public var initialSelectedYear: Int = 2000 {
        didSet {
            setup()
        }
    }
    
    var data: [[String]] = [[String]]()
    
    var day: Int = 1
    var month: Int = 1
    var year: Int = 2000
    
    public var fontSize: CGFloat = 22
    
    public var textColor: UIColor = UIColor.black
    
    public var date: Date = Date()
    
    private func getYears() -> [String]{
        var years: [String] = [String]()
        
        for y in startYear...endYear {
            years.append(String(y))
        }
        
        return years
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data[component].count * 401
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let actualRow = row % data[component].count
        switch component {
        case 0:
            day = actualRow + 1
        case 1:
            month = actualRow + 1
        case 2:
            year = actualRow + startYear
        default:
            return
        }
        
        let calendar = Calendar(identifier: .gregorian)
        let components = DateComponents(year: year, month: month, day: day)
        date = calendar.date(from: components) ?? Date()
        
        NotificationCenter.default.post(name: .CDatePickerValueChanged, object: self)
        //let comps = calendar.dateComponents([.year, .month, .day], from: date)
        //print("Y: \(comps.year ?? 0) M: \(comps.month ?? 0) D: \(comps.day ?? 0)")
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        var size: CGSize = CGSize()
        
        switch component {
        case 0:
            size = String("30").size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)])
            return size.width + 20
        case 1:
            size = String("September").size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)])
            return size.width + 20
        case 2:
            size = String("2000").size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)])
            return size.width + 20
        default:
            return 200
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? CustomLabel
        
        if (pickerLabel == nil) {
            pickerLabel = CustomLabel()
        }
        
        let font: UIFont = UIFont(name: ".SFUIText", size: fontSize)!

        let titleData = data[component][row % data[component].count]
        let style = NSMutableParagraphStyle()
        
        
        switch component {
        case 0:
            style.alignment = NSTextAlignment.right
        case 1:
            style.alignment = NSTextAlignment.left
        case 2:
            style.alignment = NSTextAlignment.center
        default:
            style.alignment = NSTextAlignment.left
        }

        
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.paragraphStyle: style,
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.backgroundColor: UIColor.clear]) //Clear color for weird thing where end of long months gets cut off without a background color. The background is also cut off when shown but the text spans outside the bg. Will make a better fix later if I can be bothered.
        
        pickerLabel?.attributedText = myTitle
        
        return pickerLabel!
    }
}

extension Notification.Name {
    static let CDatePickerValueChanged = Notification.Name("CDatePickerValueChanged")
}
