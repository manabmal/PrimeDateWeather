//
//  ViewController.swift
//  PrimeDateWeather
//
//  Created by Manab Kumar Mal on 18/07/21.
//

import UIKit
class ViewController: UIViewController {
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblCurrentTemp: UILabel!
    @IBOutlet weak var lblCurrentTempValue: UILabel!
    @IBOutlet weak var lblMaxTemp: UILabel!
    @IBOutlet weak var lblMinTemp: UILabel!
    @IBOutlet weak var lblMaxTempValue: UILabel!
    @IBOutlet weak var lblMinTempValue: UILabel!
    
    lazy private var currentCity = LocationFetcher()
    lazy private var weather = Weather()
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        getCityCountryLatLon(date: Date())
        // Do any additional setup after loading the view.
    }
    
    private func setNavigationBar(){
        self.title = "Prime Date Weather"
        let changeDateButton = UIBarButtonItem(image: nil, style: .done, target: self, action: #selector(showDatePicker))
        changeDateButton.title = "Choose"
        self.navigationItem.rightBarButtonItem  = changeDateButton
    }
    @objc private func showDatePicker() {
        openDatePickerViewController()
    }
    
    private func openDatePickerViewController()
    {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let datePickerController = storyBoard.instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
        datePickerController.datePickerDelegate = self
        let navController = UINavigationController(rootViewController: datePickerController)
        navController.modalPresentationStyle = .overCurrentContext
        present(navController, animated: true, completion: nil)
    }
    
    private func updateUI(weatherData: Day, date: String)
    {
        DispatchQueue.main.async {
            self.lblDate.text = date
            self.lblCurrentTempValue.text = weatherData.avgtempC?.toCString
            self.lblMaxTempValue.text = weatherData.maxtempC?.toCString
            self.lblMinTempValue.text = weatherData.mintempC?.toCString
        }
    }
    
    private func getCityCountryLatLon(date: Date)
    {
        currentCity.fetchCity { city, country, latLon in
            
            DispatchQueue.main.async {
                self.title = "\(city), \(country)"
            }
            
            let dateFormat = "EEEE, dd MMM, yyyy"
            if date <= Date()
            {
                self.weather.getHistoryWeather(latLon: latLon, date: date) { result in
                    dump(result)
                    self.updateUI(weatherData: result, date: date.toString(format: dateFormat))
                }
            }
            else
            {
                self.weather.getForeCastWeather(latLon: latLon, date: date) { result in
                    dump(result)
                    //self.updateUI(weatherData: result, date: date.toString(format: dateFormat))
                }
            }
        }
    }
}

extension ViewController: datePickerProtocol
{
    func selectedPrimeDate(date: Date)
    {
        getCityCountryLatLon(date: date)
    }
}

