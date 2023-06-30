//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Anthony Cifre on 6/30/23.
//

import CoreLocation
import Foundation
import SwiftUI



final class WeatherAPIClient: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var currentWeather: Weather?
    @Published var convertedCity: String?
    @Published var convertedCountry: String?



    let locationManager = CLLocationManager()
    private let dateFormatter = ISO8601DateFormatter()

    override init() {
        super.init()
        locationManager.delegate = self
        requestLocation()
    }

    func fetchWeather() async {
        guard let location = locationManager.location else {
            requestLocation()
            return
        }

        guard let url = URL(string: "https://api.tomorrow.io/v4/timelines?location=\(location.coordinate.latitude),\(location.coordinate.longitude)&fields=temperature&fields=temperatureApparent&fields=weatherCode&fields=humidity&fields=windSpeed&fields=precipitationProbability&units=imperial&timesteps=1h&startTime=\(dateFormatter.string(from: Date()))&endTime=\(dateFormatter.string(from: Date().addingTimeInterval(60 * 60)))&apikey=\(API.key)") else {
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let weatherResponse = try? JSONDecoder().decode(WeatherModel.self, from: data),
                let weatherValue = weatherResponse.data.timelines.first?.intervals.first?.values,
                let weatherCode = WeatherCode(rawValue: "\(weatherValue.weatherCode)") {

                DispatchQueue.main.async { [weak self] in
                    self?.currentWeather = Weather(temperature: Int(weatherValue.temperature), temperatureApparent: Int(weatherValue.temperatureApparent), humidity: Int(weatherValue.humidity), windSpeed: Int(weatherValue.windSpeed), precipitationProbability: Int(weatherValue.precipitationProbability),
                        weatherCode: weatherCode)
                    self?.convertLocation()
                }
            }
        } catch {
            // handle the error
        }
    }

    private func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

    }

    private func convertLocation() {
        guard let location = locationManager.location else {
            requestLocation()
            return
        }

        let geocoder = CLGeocoder()
        var placemark: CLPlacemark?
        var city = ""
        var country = ""


        print(location)

        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let _ = error {
                print("Error")

                return
            }

            placemark = placemarks?[0]
            city = placemark?.locality ?? "Unknown Location"
            country = placemark?.country ?? "Unknown Location"
            print(city)
            print(country)
            self.convertedCity = city
            self.convertedCountry = country
//            print(placemark?.administrativeArea ?? "Unknown Location")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Task { await fetchWeather() }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // handle the error
    }
}
