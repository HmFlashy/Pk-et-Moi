//
//  TriggerEventPickerViewController.swift
//  pketmoi
//
//  Created by Hugo Maitre on 24/02/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class TypeEventPickerViewController: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var typeEvents: [String]!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
        self.dataSource = self
    }
    
    
    // UIPickerViewDataSource required protocol
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeEvents.count
    }
    
    // UIPickerViewDelegate optional protocol
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeEvents[row]
    }
    
    
}
