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
    
    @IBOutlet var addAppointmentView: UIView!
    
    @IBOutlet weak var doctorTableView: UITableView!
    
    let doctorPresenter: DoctorPresenter = DoctorPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doctorTableView.delegate = self
        doctorTableView.dataSource = self
        do {
            try doctorFetched.performFetch()
        } catch {
            print("Unable to perform Doctor fetch")
        }
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
        return doctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = doctorTableView.dequeueReusableCell(withIdentifier: "DoctorCell", for: indexPath) as! DoctorTableViewCell
        let doctor: Doctor = doctorFetched.object(at: indexPath)
        cell.doctor = doctor
        self.doctorPresenter.configureCell(forCell: cell, doctor: doctor)
        cell.appointmentButton.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let event = doctorFetched.object(at: indexPath)
            CoreDataManager.context.delete(event)
            do {
                try CoreDataManager.context.save()
            } catch let error as NSError {
                print("Error saving context after delete: \(error.localizedDescription)")
            }
            break
        default:break
        }
    }
    
    // MARK: - NSFetchResultController delegate protocol
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                self.doctorTableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .delete:
            if let indexPath = indexPath {
                self.doctorTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.doctorTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.doctorTableView.endUpdates()
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "addAppointmentSegue"){
            let button = sender as! UIButton
            guard let addAppointment: AddDoctorAppointmentViewController = segue.destination as? AddDoctorAppointmentViewController else { return }
            addAppointment.set(forDoctor: self.doctorFetched.object(at: IndexPath(row: button.tag, section: 0)))
        } else if (segue.identifier == "infoDoctorSegue") {
            guard let modifyDoctor: ModifyDoctorViewController = segue.destination as? ModifyDoctorViewController else {
                return
            }
            guard let indexPath = doctorTableView.indexPathForSelectedRow else {
                return
            }
            let doctor: Doctor = doctorFetched.object(at: indexPath)
            modifyDoctor.set(forDoctor: doctor)
        }
    }
    
    
    @IBAction func addAppointment(_ sender: Any) {
        self.view.addSubview(self.addAppointmentView)
        addAppointmentView.center = self.view.center
    }
}
