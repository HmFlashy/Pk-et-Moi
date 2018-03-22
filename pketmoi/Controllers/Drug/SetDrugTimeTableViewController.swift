//
//  SetDrugTimeTableViewController.swift
//  pketmoi
//
//  Created by Loris Zirah on 20/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit

class SetDrugTimeTableViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var startHourDatePicker: UIDatePicker!
    @IBOutlet weak var frequencyPickerView: UIPickerView!
    @IBOutlet weak var intervalDatePicker: UIDatePicker!
    
    var startDate: Date?
    var endDate: Date?
    var typeDrug: TypeDrug!
    var drugDescription: String?
    var drugDose: String!
    var frequencySelected: String?
    var frequencyTab: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 1...10{
            frequencyTab.append(i)
        }
        frequencyPickerView.delegate = self
        frequencyPickerView.dataSource = self
    }

    // MARK: - UIPickerViewDataSource required protocol -
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return frequencyTab.count
    }
    
    // MARK : - UIPickerViewDelegate optional protocol -
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(frequencyTab[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        frequencySelected = String(frequencyTab[row])
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectDays"{
            let selectDaysDrugViewController = segue.destination as! SelectDaysDrugViewController
            selectDaysDrugViewController.startDate = self.startDate
            selectDaysDrugViewController.endDate = self.endDate
            selectDaysDrugViewController.typeDrug = self.typeDrug
            selectDaysDrugViewController.drugDescription = self.drugDescription
            selectDaysDrugViewController.drugDose = self.drugDose
            selectDaysDrugViewController.startHour = self.startHourDatePicker.date
            selectDaysDrugViewController.frequency = self.frequencySelected
            selectDaysDrugViewController.interval = self.intervalDatePicker.date
        }
    }
}
