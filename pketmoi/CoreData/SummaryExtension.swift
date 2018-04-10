//
//  SummaryExtension.swift
//  pketmoi
//
//  Created by Loris Zirah on 27/03/2018.
//  Copyright © 2018 Hugo Maitre. All rights reserved.
//

import Foundation
import CoreData

extension Summary{
    
    /// Create a sumamry
    ///
    /// - Parameters:
    ///   - askingInterval: the interval between two ask of the state
    ///   - endDate: the date where the summary should end
    ///   - startDate: the date where the summary should start
    ///   - appointment: the appointement linked to this summary
    /// - Returns: an instance of the class Summary with the given parameters
    static func createSummary(askingInterval: String?, endDate: Date, startDate: Date, appointment: Appointment) -> Summary {
        guard let newSummary = NSEntityDescription.insertNewObject(forEntityName: "Summary", into: CoreDataManager.context) as? Summary else{
            print("Summary does not exists in the database")
            fatalError()
        }
        newSummary.askingInterval = askingInterval
        newSummary.endDate = endDate
        newSummary.startDate = startDate
        newSummary.appointment = appointment
        
        CoreDataManager.save()
        return newSummary
    }
    
    static func fillDatabase(appointment: Appointment){
        let date = appointment.date!
        let startDate = Calendar.current.date(byAdding: .day, value: -5, to: date)
        fillSummary(summary: Summary.createSummary(askingInterval: "1", endDate: date, startDate: startDate!, appointment: appointment))
    }
    
    static private func fillSummary(summary: Summary){
        let date = summary.appointment?.date!
        var startDate = Calendar.current.date(byAdding: .day, value: -5, to: date!)
        
        let state1 = State.getState(forName: "ON")
        let state2 = State.getState(forName: "OFF")
        let state3 = State.getState(forName: "DYSKINESIES")
        
        let answer1 = Answer.getAnswer(forName: "Toutes les prises")
        let answer2 = Answer.getAnswer(forName: "J'ai oublié x prise(s)")
        let answer3 = Answer.getAnswer(forName: "Quelques prises")
        // Creating BeStates for all the days and rigorousAnswers
        for j in 1...5 {
            let gregorian = Calendar(identifier: .gregorian)
            var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute], from: startDate!)
            components.hour = 7
            components.minute = 0
            var startDateState = gregorian.date(from: components)!
            var beState: BeState?
            var notif: Bool = false
            for i in 1...14 {
                if i % 3 == 0 {
                    beState = BeState.createBeState(date: startDateState, state: state1, summary: summary)
                }
                else if i % 3 == 1 {
                    beState = BeState.createBeState(date: startDateState, state: state2, summary: summary)
                }
                else{
                    beState = BeState.createBeState(date: startDateState, state: state3, summary: summary)
                }
                startDateState = Calendar.current.date(byAdding: .hour, value: 1, to: startDateState)!
                if !notif {
                    NotificationManager.addSummaryNotifications(forBeState: beState!)
                    notif = true
                }
            }
            if j % 3 == 0 {
                _ = RigorousAnswer.createRigorousAnswer(date: startDate!, nbOversight: nil, summary: summary, answer: answer1)
            }
            else if j % 3 == 1 {
                _ = RigorousAnswer.createRigorousAnswer(date: startDate!, nbOversight: "3", summary: summary, answer: answer2)
            }
            else{
                _ = RigorousAnswer.createRigorousAnswer(date: startDate!, nbOversight: nil, summary: summary, answer: answer3)
            }
            startDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate!)
        }
    }
}
