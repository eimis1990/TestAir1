import UIKit

class WeatherListViewController: UITableViewController, WeatherManagerDelegate {
    
    var weatherManager = WeatherManager()
    var weatherData: WeatherModel? {
            didSet {
                tableView.reloadData() // Reload data when weatherData is set
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(WeatherTableViewCell.nib, forCellReuseIdentifier: WeatherTableViewCell.identifier)
        weatherManager.delegate = self
        
        
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async { [self] in
            self.weatherData = weather
            print("Weather data updated: \(weather)")
            if weatherData != nil {
            tableView.reloadData()
        }
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        
        if let weather = weatherData {
            print("Configuring cell with weather data: \(weather)")
            cell.cityLabel.text = weather.cityName
            cell.temperatureLabel.text = "\(weather.temperature)°C"
            cell.descriptionLabel.text = weather.description
            
            if let iconUrl = URL(string: weather.icon) {
                weatherManager.downloadImage(from: iconUrl) { image in
                    DispatchQueue.main.async {
                        cell.iconImageView.image = image
                    }
                }
            }
        } else {
            print("Weather data is nil")
        }
        return cell
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}
