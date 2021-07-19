//
//  DatePickerViewController.swift
//  PrimeDateWeather
//
//  Created by Manab Kumar Mal on 19/07/21.
//

import UIKit

protocol datePickerProtocol: AnyObject {
    func selectedPrimeDate(date: Date)
}

class DatePickerViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    weak var datePickerDelegate: datePickerProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        //setDatePickerMinMaxDate()
        // Do any additional setup after loading the view.
    }
    
    private func setNavigationBar(){
        self.title = "Date Picker"
        let doneButton = UIBarButtonItem(image: nil, style: .done, target: self, action: #selector(done))
        doneButton.title = "Done"
        self.navigationItem.rightBarButtonItem  = doneButton
        
        let cancelButton = UIBarButtonItem(image: nil, style: .done, target: self, action: #selector(cancel))
        cancelButton.title = "Cancel"
        self.navigationItem.leftBarButtonItem  = cancelButton
    }
    
    /*private func setDatePickerMinMaxDate()
    {
        let today = Date()
        let maxDay = today.add(days: 3)
        let minDay = today.subtract(days: 7)
        datePicker.maximumDate = maxDay
        datePicker.minimumDate = minDay
    }*/
    
    @objc private func done() {
        let strOnlyDate = datePicker.date.toString(format: "dd")
        if let intDate = Int(strOnlyDate)
        {
            let today = Date()
            let maxDay = today.add(days: 3)
            let minDay = today.subtract(days: 7)
            
            if datePicker.date < minDay ?? today || datePicker.date > maxDay ?? today
            {
                showMessage(title: "Api Limitation", message: "Due to free api limitation only weather of past 7 days and upcoming 3 days can be calculated.")
            }
            else
            {
                //datePickerDelegate?.selectedPrimeDate(date: datePicker.date)
                //dismiss(animated: true, completion: nil)
                if intDate.isPrime
                {
                    datePickerDelegate?.selectedPrimeDate(date: datePicker.date)
                    dismiss(animated: true, completion: nil)
                }
                else
                {
                    showMessage(title: "Not Prime", message: "Please choose prime date to continue!")
                }
            }
        }
        else
        {
            showMessage(title: "Invaid Date", message: "Please choose valid prime date to continue!")
        }
    }
    
    @objc private func cancel() {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
