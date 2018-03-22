//
//  ShowEventViewController.swift
//  pketmoi
//
//  Created by Hugo Maitre on 09/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import CoreData
import UIKit

class ShowEventViewController: UIViewController {
    
    var event : Event? = nil
    
    @IBOutlet weak var dateEvent: UILabel!
    @IBOutlet weak var typeEvent: UILabel!
    @IBOutlet weak var descriptionEvent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // If an event has been set, then display it
        if let aevent = self.event{
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "fr_FR")
            dateFormatter.dateFormat = "dd/MM/YYYY hh:mm"
            dateEvent.text = dateFormatter.string(from: aevent.date!)
            typeEvent.text = aevent.typeEvent?.name
            descriptionEvent.text = aevent.itemDescription
        }
    }
}
