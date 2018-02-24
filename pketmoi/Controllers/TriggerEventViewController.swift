//
//  TriggerEventViewController.swift
//  pketmoi
//
//  Created by Hugo Maitre on 24/02/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import SQLite3

class TriggerEventViewController: UIViewController {
    
    @IBOutlet weak var typeEventPickerView: TypeEventPickerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var names : [String] = []
        let query = "SELECT name FROM Event"
        var stmt: OpaquePointer?
        if(sqlite3_prepare(databaseFactory.db, query, -1, &stmt, nil) != SQLITE_OK){
            let errmsg = String(cString: sqlite3_errmsg(databaseFactory.db)!)
            print("error preparing select: \(errmsg)")
            return
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            names.append(String(cString: sqlite3_column_text(stmt, 0)))
        }
        typeEventPickerView.typeEvents = names
    }
}
