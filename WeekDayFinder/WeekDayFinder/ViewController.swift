//
//  ViewController.swift
//  WeekDayFinder
//
//  Created by Артем Соловьев on 26.01.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var DateTF: UITextField!
    @IBOutlet weak var MonthTF: UITextField!
    @IBOutlet weak var YearTF: UITextField!
    
    @IBOutlet weak var ResultLabel: UILabel!
    
    @IBAction func findDay(){
        let calenadar = Calendar.current
        
        var dateComponents = DateComponents()
        guard let day = DateTF.text, let month = MonthTF.text, let year = YearTF.text else { return }//если передается пустое значение, то метод не выполнится
        dateComponents.day = Int(day)
        dateComponents.month = Int(month)
        dateComponents.year = Int(year)
        
        guard let date = calenadar.date(from: dateComponents) else {return}
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        let weekday = dateFormatter.string(from: date)
        ResultLabel.text = weekday
    }
}

