//
//  ContentView.swift
//  WeatherApp
//
//  Created by Anthony Cifre on 6/30/23.
//

import CoreLocation
import CoreLocationUI
import SwiftUI

struct ContentView: View {
    @StateObject var weatherAPIClient = WeatherAPIClient()


    var body: some View {
        NavigationStack {
            if let currentWeather = weatherAPIClient.currentWeather, let currentCity = weatherAPIClient.convertedCity, let currentCountry = weatherAPIClient.convertedCountry   {
                ZStack {
                    NavyBackgroundView()
                        .ignoresSafeArea()

                    VStack {
                        WeatherView(currentWeather: currentWeather, currentCity: currentCity, currentCountry: currentCountry)
                            .padding([.horizontal, .top])
                    }
                }
            } else {
                ProgressView()
                Button("Refresh", action: {
                    Task {
                        await weatherAPIClient.fetchWeather()
                    }
                })
            }
        }
        .onAppear {
            
            Task {
                
                await
                weatherAPIClient.fetchWeather()

            }
        }
    }

}

#Preview {
    ContentView()
}
