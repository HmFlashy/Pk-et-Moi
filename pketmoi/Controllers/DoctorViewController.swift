//
//  DoctorViewController.swift
//  pketmoi
//
//  Created by Hugo Maitre on 12/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import UIKit
import CoreData

class DoctorViewController: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var doctorTableView: UITableView!
    
    let doctorPresenter: DoctorPresenter = DoctorPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate lazy var doctorFetched: NSFetchedResultsController<Doctor> = {
        let request: NSFetchRequest<Doctor> = Doctor.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Doctor.lastname), ascending: true)]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        return fetchedResultController
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let doctors = doctorFetched.fetchedObjects else { return 0 }
        print(doctors.count)
        return doctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = doctorTableView.dequeueReusableCell(withIdentifier: "DoctorCell", for: indexPath) as! DoctorTableViewCell
        let doctor: Doctor = doctorFetched.object(at: indexPath)
        self.doctorPresenter.configureCell(forCell: cell, doctor: doctor)
        return cell
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
