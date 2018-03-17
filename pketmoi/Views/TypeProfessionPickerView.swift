//
//  TypeProfessionPickerView.swift
//  pketmoi
//
//  Created by Hugo Maitre on 14/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import CoreData

class TypeProfessionPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource, NSFetchedResultsControllerDelegate {
    
    
    var selectedTypeProfession: TypeProfession?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
        self.dataSource = self
        do {
            try self.typeProfessionFetched.performFetch()
        } catch {
            print("Problem")
        }
        guard let typeProfessions = typeProfessionFetched.fetchedObjects else { return }
        if(typeProfessions.count > 0) {
            selectedTypeProfession = typeProfessions[0]
        }
    }
    
    public lazy var typeProfessionFetched: NSFetchedResultsController<TypeProfession> = {
        let request: NSFetchRequest<TypeProfession> = TypeProfession.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(TypeProfession.title), ascending: true)]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        return fetchedResultController
    }()
    
    // UIPickerViewDataSource required protocol
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let typeProfessions = typeProfessionFetched.fetchedObjects else { return 0 }
        return typeProfessions.count
    }
    
    // UIPickerViewDelegate optional protocol
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let typeProfessions = typeProfessionFetched.fetchedObjects else { return ""}
        return typeProfessions[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let typeProfessions = typeProfessionFetched.fetchedObjects else { return }
        selectedTypeProfession = typeProfessions[row]
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
