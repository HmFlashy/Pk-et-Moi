//
//  ProfessionPickerView.swift
//  pketmoi
//
//  Created by Hugo Maitre on 15/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import CoreData

class ProfessionPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource, NSFetchedResultsControllerDelegate {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
        self.dataSource = self
    }
    
    public var professionsFetched: [Profession]?
    
    // UIPickerViewDataSource required protocol
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let professions = professionsFetched else { return 0 }
        print(professions.count)
        return professions.count
    }
    
    // UIPickerViewDelegate optional protocol
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let professions = professionsFetched else { return "" }
        return professions[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
    
    public func set(forProfessions: [Profession]?){
        self.professionsFetched = forProfessions
        self.reloadAllComponents()
        self.selectedRow(inComponent: 0)
        
    }
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

