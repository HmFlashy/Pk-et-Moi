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
        do {
            try self.professionFetched.performFetch()
        } catch {
            print("Problem")
        }
        guard let professions = professionFetched.fetchedObjects else { return }
        if(professions.count > 0){
            self.selectRow(0, inComponent: 0, animated: true)
        }
    }
    
    public lazy var professionFetched: NSFetchedResultsController<Profession> = {
        let request: NSFetchRequest<Profession> = Profession.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Profession.title), ascending: true)]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        return fetchedResultController
    }()
    
    // UIPickerViewDataSource required protocol
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let professions = professionFetched.fetchedObjects else { return 0 }
        return professions.count
    }
    
    // UIPickerViewDelegate optional protocol
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let professions = professionFetched.fetchedObjects else { return ""}
        return professions[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let professions = professionFetched.fetchedObjects else { return }
    }
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

