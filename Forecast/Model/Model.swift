//
//  Model.swift
//  Forecast
//
//  Created by HS on 26/03/24.
//

import Foundation
import CoreLocation

enum NetworkError: Error {
    case invalidURL
    case cityNotFound
    case unknownError
}

enum Either<A, B> {
    case left(A)
    case right(B)
}

struct WeatherData: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double? 
    let temp_min: Double?
    let temp_max: Double? 
    let pressure: Int
    let humidity: Int
}


struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct Clouds: Codable {
    let all: Int
}

struct Sys: Codable {
    let type: Int?
    let id: Int?
    let country: String
    let sunrise: Int?
    let sunset: Int?
}

func fetchWeatherData(for location: Either<CLLocationCoordinate2D, String>, completion: @escaping (Result<WeatherData, NetworkError>) -> Void) {
    var urlString: String
    let apiKey = "004911286ef1d4e6717291f8848d37d2"
    switch location {
    case .left(let coordinate):
        urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&appid=\(apiKey)"
    case .right(let cityName):
        urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)"
    }
    
    // Print request URL
    print("Request URL: \(urlString)")
    
    // Create URL object
    guard let url = URL(string: urlString) else {
        completion(.failure(.invalidURL))
        return
    }
    
    // Create URLSession data task
    URLSession.shared.dataTask(with: url) { data, response, error in
        // Check for errors and valid data
        guard let data = data, error == nil else {
            completion(.failure(.unknownError))
            return
        }
        
        // Print response data
        if let responseData = String(data: data, encoding: .utf8) {
            print("Response Data: \(responseData)")
        }
        
        // Parse JSON data
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            completion(.success(weatherData))
        } catch {
            if let decodingError = error as? DecodingError {
                switch decodingError {
                case .keyNotFound(let key, _):
                    if key.stringValue == "coord" {
                        completion(.failure(.cityNotFound))
                    } else {
                        completion(.failure(.unknownError))
                    }
                default:
                    completion(.failure(.unknownError))
                }
            } else {
                completion(.failure(.unknownError))
            }
        }
    }.resume() 
}
