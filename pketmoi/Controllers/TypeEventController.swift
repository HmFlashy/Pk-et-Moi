//
//  TypeEventController.swift
//  pketmoi
//
//  Created by Hugo Maitre on 21/02/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import SQLite3

class TypeEventController: UIViewController {
    
    
    @IBOutlet weak var typeEventTextArea: UITextField!
    @IBOutlet weak var typeEventtest: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addTypeEvent(_ sender: Any) {
        let db = databaseFactory.db
        var stmt: OpaquePointer?
        let typeEventName = typeEventTextArea.text
        let query = "INSERT INTO Event (name) VALUES (?)"
        if(sqlite3_prepare(db, query, -1, &stmt, nil) != SQLITE_OK){
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        if(sqlite3_bind_text(stmt, 1, typeEventName, -1, nil) != SQLITE_OK) {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding type event name: \(errmsg)")
            return
        }
        if(sqlite3_step(stmt) != SQLITE_DONE){
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting type event: \(errmsg)")
            return
        }
        typeEventTextArea.text = ""
        typeEventtest.text = "inserted !"
    }
}

