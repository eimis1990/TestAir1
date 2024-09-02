//
//  WeatherViewController.swift
//  TestAir
//
//  Created by Rimvydas on 2024-08-31.
//

import UIKit

class MainWeatherViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    var weatherTableViewCell = WeatherTableViewCell()
//    var destinationVC: WeatherListViewController?
    var cityName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        searchTextField.delegate = self
    }
    
    @IBAction func historyButtonPressed(_ sender: Any) {
        navigateToSecondDestinationViewController()
    }
    
    @IBAction func goButtonPressed(_ sender: Any) {
        if let city = searchTextField.text {
            cityName = city
                    weatherManager.fetchWeather(cityName: city)
            
                }
        navigateToFirstDestinationViewController()
    }
    
    func navigateToFirstDestinationViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let destinationVC = storyboard.instantiateViewController(withIdentifier: "WeatherListViewController") as? WeatherListViewController {
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
    
    func navigateToSecondDestinationViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let destinationVC = storyboard.instantiateViewController(withIdentifier: "WeatherListViewController") as? WeatherListViewController {
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}

//MARK: - UITextFieldDelegate
extension MainWeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

//// MARK: - WeatherManagerDelegate
//extension MainWeatherViewController: WeatherManagerDelegate {
//    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
//        DispatchQueue.main.async { [weak self] in
//            guard let self = self else { return }
//            if let destinationVC = self.destinationVC {
//                destinationVC.weatherData = weather
//                self.navigationController?.pushViewController(destinationVC, animated: true)
//            }
//        }
//    }
//    
//    func didFailWithError(error: Error) {
//        print(error)
//    }
//}
