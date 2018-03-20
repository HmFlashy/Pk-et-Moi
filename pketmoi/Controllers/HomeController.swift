//
//  HomeController.swift
//  pketmoi
//
//  Created by Hugo Maitre on 21/02/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import CoreData

class HomeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var buttonTriggerEvent: UIButton!
    @IBOutlet weak var buttonProgramActivity: UIButton!
    @IBOutlet weak var buttonSynthesis: UIButton!
    @IBOutlet weak var buttonProgramDrugs: UIButton!
    @IBOutlet weak var currentDate: UILabel!
    
    @IBOutlet weak var timeEventCollectionView: UICollectionView!
    
    private let timeItemPresenter = TimeItemPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC+1")
        formatter.dateFormat = "dd/MM"
        currentDate.text = formatter.string(from: date)
        buttonTriggerEvent.layer.borderColor = UIColor.black.cgColor
        buttonTriggerEvent.layer.borderWidth = 2
        buttonTriggerEvent.titleLabel?.textAlignment = NSTextAlignment.center
        
        buttonProgramActivity.layer.borderColor = UIColor.black.cgColor
        buttonProgramActivity.layer.borderWidth = 2
        buttonProgramActivity.titleLabel?.textAlignment = NSTextAlignment.center
        
        buttonSynthesis.layer.borderColor = UIColor.black.cgColor
        buttonSynthesis.layer.borderWidth = 2
        buttonSynthesis.titleLabel?.textAlignment = NSTextAlignment.center
        
        buttonProgramDrugs.layer.borderColor = UIColor.black.cgColor
        buttonProgramDrugs.layer.borderWidth = 2
        buttonProgramDrugs.titleLabel?.textAlignment = NSTextAlignment.center
        
        
        do {
            try self.timeEventFetched.performFetch()
        } catch {
            print("Unable to perform fetch on TimeEvent")
            fatalError()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private lazy var timeEventFetched: NSFetchedResultsController<TimeItem> = {
        let request: NSFetchRequest<TimeItem> = TimeItem.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(TimeItem.date), ascending: false)]
        request.predicate = predicateForDayFromDate(date: NSDate())
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        return fetchedResultController
    }()
    
    func predicateForDayFromDate(date: NSDate) -> NSPredicate {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var components = calendar!.components([.year, .month, .day, .hour, .minute, .second], from: date as Date)
        let startDate = calendar!.date(from: components)
        components.hour = 23
        components.minute = 59
        components.second = 59
        let endDate = calendar!.date(from: components)
        
        return NSPredicate(format: "date >= %@ AND date =< %@", argumentArray: [startDate!, endDate!])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let timeEvents = self.timeEventFetched.fetchedObjects else {
            return 0
        }
        print(timeEvents.count)
        return timeEvents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = timeEventCollectionView.dequeueReusableCell(withReuseIdentifier: "timeItemCell", for: indexPath) as! TimeItemCollectionViewCell
        timeItemPresenter.configureCell(forCell: cell, timeItem: timeEventFetched.object(at: indexPath))
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    // MARK: - NSFetchResultController delegate protocol
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                self.timeEventCollectionView.insertItems(at: [indexPath])
            }
            break
        case .delete:
            if let indexPath = indexPath {
                self.timeEventCollectionView.deleteItems(at: [indexPath])
            }
        default:
            break
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.timeEventCollectionView.performBatchUpdates(nil)
    }
    
    
}


