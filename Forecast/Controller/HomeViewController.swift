//
//  HomeViewController.swift
//  Forecast
//
//  Created by HS on 25/03/24.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    var cityLabel: UILabel!
    var countryLabel: UILabel!
    var temperatureLabel: UILabel!
    var conditionLabel: UILabel!
    var citySearch: UITextField!
    var backgroundImageView: UIImageView!
    var borderLabel: UILabel!
    var humidityLabel: UILabel!
    var windLabel: UILabel!
    var pressureLabel: UILabel!
    var weatherIconImageView: UIImageView!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        // Request location permission
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    func setupUI(){
        let backgroundImage = UIImage(named: "BackgrounImage")
        backgroundImageView = UIImageView(frame: self.view.bounds)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = backgroundImage
        self.view.addSubview(backgroundImageView)
        
        borderLabel = UILabel(frame: CGRect(x: 20, y: 300, width: view.frame.width - 40, height: 300))
        borderLabel.backgroundColor = .clear
        borderLabel.layer.cornerRadius = 5
        borderLabel.layer.opacity = 0.5
        borderLabel.backgroundColor = .black
        borderLabel.layer.borderWidth = 10
        borderLabel.layer.masksToBounds = true
        borderLabel.layer.borderColor = UIColor.white.cgColor
        view.addSubview(borderLabel)
        
        
        // Create temperature label
        temperatureLabel = UILabel(frame: CGRect(x: 0, y: 180, width: view.frame.width - 60, height: 100))
        temperatureLabel.textAlignment = .right
        temperatureLabel.textColor = .white
        temperatureLabel.shadowColor = .black
        temperatureLabel.font = UIFont.boldSystemFont(ofSize: 100)
        borderLabel.addSubview(temperatureLabel)
        
        // Create condition label
        conditionLabel = UILabel(frame: CGRect(x: 0, y: 150, width: view.frame.width - 60, height: 30))
        conditionLabel.textAlignment = .right
        conditionLabel.textColor = .white
        conditionLabel.shadowColor = .black
        conditionLabel.font = UIFont.systemFont(ofSize: 30)
        borderLabel.addSubview(conditionLabel)
        
        cityLabel = UILabel(frame: CGRect(x: 0, y: 50, width: view.frame.width - 60, height: 30))
        cityLabel.textAlignment = .right
        cityLabel.textColor = .white
        cityLabel.shadowColor = .black
        cityLabel.font = UIFont.systemFont(ofSize: 30)
        borderLabel.addSubview(cityLabel)
        
        countryLabel = UILabel(frame: CGRect(x: 0, y: 100, width: view.frame.width - 60, height: 30))
        countryLabel.textAlignment = .right
        countryLabel.textColor = .white
        countryLabel.shadowColor = .black
        countryLabel.font = UIFont.systemFont(ofSize: 20)
        borderLabel.addSubview(countryLabel)
        
        // Create the UIImageView
        weatherIconImageView = UIImageView(frame: CGRect(x: 0, y: 20, width: 150, height: 150))
        weatherIconImageView.tintColor = .white
        borderLabel.addSubview(weatherIconImageView)
        
        // Create city search text field
        citySearch = UITextField(frame: CGRect(x: 20, y: 100, width: view.frame.width - 40, height: 50))
        citySearch.placeholder = "Enter City Name"
        citySearch.borderStyle = .roundedRect
        citySearch.layer.cornerRadius = 25
        citySearch.layer.masksToBounds = true
        view.addSubview(citySearch)
        
        // Create search button
        let searchButton = UIButton(type: .system)
        searchButton.setTitle("SEARCH", for: .normal)
        searchButton.setTitleColor(UIColor(hex: "#00A4CC"), for: .normal)
        searchButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        searchButton.backgroundColor = .white
        searchButton.layer.cornerRadius = 25
        searchButton.frame = CGRect(x: 100, y: 180, width: view.frame.width - 200, height: 50)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        view.addSubview(searchButton)
        
        humidityLabel = UILabel(frame: CGRect(x: 20, y: 650, width: view.frame.width - 40, height: 40))
        humidityLabel.textAlignment = .center
        humidityLabel.textColor = .white
        humidityLabel.shadowColor = .black
        humidityLabel.layer.opacity = 0.7
        humidityLabel.layer.masksToBounds = true
        humidityLabel.backgroundColor = .black
        humidityLabel.layer.borderColor = UIColor.white.cgColor
        humidityLabel.layer.borderWidth = 5
        humidityLabel.layer.cornerRadius = 5
        humidityLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(humidityLabel)
        
        windLabel = UILabel(frame: CGRect(x: 20, y: 700, width: view.frame.width - 40, height: 40))
        windLabel.textAlignment = .center
        windLabel.textColor = .white
        windLabel.shadowColor = .black
        windLabel.layer.opacity = 0.7
        windLabel.layer.masksToBounds = true
        windLabel.backgroundColor = .black
        windLabel.layer.borderColor = UIColor.white.cgColor
        windLabel.layer.borderWidth = 5
        windLabel.layer.cornerRadius = 5
        windLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(windLabel)
        
        pressureLabel = UILabel(frame: CGRect(x: 20, y: 750, width: view.frame.width - 40, height: 40))
        pressureLabel.textAlignment = .center
        pressureLabel.textColor = .white
        pressureLabel.shadowColor = .black
        pressureLabel.layer.opacity = 0.7
        pressureLabel.layer.masksToBounds = true
        pressureLabel.backgroundColor = .black
        pressureLabel.layer.borderColor = UIColor.white.cgColor
        pressureLabel.layer.borderWidth = 5
        pressureLabel.layer.cornerRadius = 5
        pressureLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(pressureLabel)
        
        let currentLocationButton = UIButton(type: .system)
        currentLocationButton.addTarget(self, action: #selector(showCurrentLocationWeather), for: .touchUpInside)
        currentLocationButton.setImage(UIImage(named: "CurrentLocationIcon"), for: .normal)
        currentLocationButton.tintColor = UIColor.white
        currentLocationButton.frame = CGRect(x: 20, y: 50, width: 30, height: 30)
        view.addSubview(currentLocationButton)
        
    }
    
    @objc func searchButtonTapped() {
        guard let cityName = citySearch.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            getLocationAndFetchWeatherData()
            return
        }
        
        fetchWeatherData(for: .right(cityName)) { result in
            switch result {
            case .success(let weatherData):
                // Update UI with weather data
                DispatchQueue.main.async {
                    self.updateUI(with: weatherData)
                    
                    self.setImageFromURL(weatherData: weatherData)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    if error == .cityNotFound {
                        // Show an alert for city not found
                        let alert = UIAlertController(title: "City Not Found", message: "The specified city could not be found.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        // Show a generic error alert
                        let alert = UIAlertController(title: "Error", message: "An error occurred while fetching weather data.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    
    func updateUI(with weatherData: WeatherData) {
        // Example: Update temperature label
        let temperatureInCelsius = weatherData.main.temp - 273.15
        temperatureLabel.text = "\(Int(round(temperatureInCelsius)))°C"
        
        cityLabel.text = weatherData.name
        
        countryLabel.text = weatherData.sys.country
        
        // Example: Update condition label
        conditionLabel.text = weatherData.weather.first?.description.capitalized ?? ""
        
        
        let humidity = weatherData.main.humidity
        let humidityString = String(humidity)
        
        humidityLabel.text = "Humidity: \(humidityString)"
        
        windLabel.text = ("Wind Speed: \(weatherData.wind.speed)")
        
        let pressure = weatherData.main.pressure
        
        pressureLabel.text = "Pressure: \(String(pressure))"
        
        if let weatherDescription = weatherData.weather.first?.main {
            var backgroundImageName: String
            
            switch weatherDescription {
            case _ where weatherDescription.contains("Thunderstorm"):
                backgroundImageName = "Thunderstorm"
            case _ where weatherDescription.contains("Drizzle"):
                backgroundImageName = "Drizzle"
            case _ where weatherDescription.contains("Rain"):
                backgroundImageName = "Rain"
            case _ where weatherDescription.contains("Snow"):
                backgroundImageName = "Snow"
            case _ where weatherDescription.contains("Atmosphere"):
                backgroundImageName = "Atmosphere"
            case _ where weatherDescription.contains("Clear"):
                backgroundImageName = "Clear"
            case _ where weatherDescription.contains("Clouds"):
                backgroundImageName = "Clouds"
            default:
                backgroundImageName = "BackgrounImage"
            }
            
            if let backgroundImage = UIImage(named: backgroundImageName) {
                backgroundImageView.image = backgroundImage
                backgroundImageView.contentMode = .scaleAspectFill
                backgroundImageView.isHidden = false // Show background image
            }
        }
    }
    
    func setImageFromURL(weatherData: WeatherData) {
        let iconimage = weatherData.weather.first?.icon ?? ""
        // URL of the image you want to download
        let imageURLString = "https://openweathermap.org/img/wn/\(iconimage)@2x.png"
        
        // Create URL object from the string
        guard let imageURL = URL(string: imageURLString) else {
            print("Invalid image URL")
            return
        }
        
        // Create a URLSession data task to download the image
        let task = URLSession.shared.dataTask(with: imageURL) { [weak self] (data, response, error) in
            // Check for errors and valid data
            guard let data = data, error == nil else {
                print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Create UIImage object from the downloaded data
            if let image = UIImage(data: data) {
                // Update the image view on the main thread
                DispatchQueue.main.async {
                    self?.weatherIconImageView.image = image
                }
            } else {
                print("Error creating UIImage from data")
            }
        }
        
        // Start the data task to initiate the download
        task.resume()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            // Permission granted, get current location
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            print("Failed to get location")
            return
        }
        
        // Fetch weather data for current location
        fetchWeatherData(for: .left(location.coordinate)) { result in
            switch result {
            case .success(let weatherData):
                // Update UI with weather data
                DispatchQueue.main.async {
                    self.updateUI(with: weatherData)
                    self.setImageFromURL(weatherData: weatherData)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.handleWeatherFetchError(error)
                }
            }
        }
        
        // Stop updating location to conserve battery
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error.localizedDescription)")
    }
    
    func getLocationAndFetchWeatherData() {
        // Create a CLLocationManager instance
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    @objc func showCurrentLocationWeather() {
        citySearch.text = ""
        
        // Check authorization status asynchronously
        DispatchQueue.global().async {
            let status: CLAuthorizationStatus
            if #available(iOS 14, *) {
                status = self.locationManager.authorizationStatus
            } else {
                status = CLLocationManager.authorizationStatus()
            }
            
            // Check if location services are enabled asynchronously
            DispatchQueue.main.async {
                self.handleAuthorizationStatus(status)
            }
        }
    }
    
    func handleAuthorizationStatus(_ status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            // Location services are authorized, proceed with location request
            
            // Check if location services are enabled
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.requestLocation()
            } else {
                print("Location services are not enabled.")
            }
        case .notDetermined:
            // Location authorization status not determined, request authorization
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            print("Location services are denied or restricted.")
        @unknown default:
            print("Unhandled authorization status.")
        }
    }
    
    func handleWeatherFetchError(_ error: NetworkError) {
        if error == .cityNotFound {
            // Show alert for city not found
            let alert = UIAlertController(title: "City Not Found", message: "The specified city could not be found.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            // Show generic error alert
            let alert = UIAlertController(title: "Error", message: "An error occurred while fetching weather data.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
}

extension UIColor {
    convenience init?(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexString = hexString.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        guard Scanner(string: hexString).scanHexInt64(&rgb) else {
            return nil
        }
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
