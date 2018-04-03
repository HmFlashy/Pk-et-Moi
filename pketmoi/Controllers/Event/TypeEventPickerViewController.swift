//
//  TriggerEventPickerViewController.swift
//  pketmoi
//
//  Created by Hugo Maitre on 24/02/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import CoreData

class TypeEventPickerViewController: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource, NSFetchedResultsControllerDelegate {
    
    var selectedTypeEvent: TypeEvent?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
        self.dataSource = self
        do {
            try self.typeEventFetched.performFetch()
        } catch {
            print("Problem")
        }
        let typeEvents = typeEventFetched.fetchedObjects
        selectedTypeEvent = typeEvents?[0]
    }
    
    fileprivate lazy var typeEventFetched: NSFetchedResultsController<TypeEvent> = {
        let request: NSFetchRequest<TypeEvent> = TypeEvent.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(TypeEvent.name), ascending: true)]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        return fetchedResultController
    }()
    
    // UIPickerView DataSource required protocol -
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let typeEvents = typeEventFetched.fetchedObjects else { return 0 }
        return typeEvents.count
    }
    
    // UIPickerView Delegate optional protocol -
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let typeEvents = typeEventFetched.fetchedObjects else { return ""}
        return typeEvents[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let typeEvents = typeEventFetched.fetchedObjects else { return }
        selectedTypeEvent = typeEvents[row]
    }
}
