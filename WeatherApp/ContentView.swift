//
//  ContentView.swift
//  WeatherApp
//
//  Created by Anthony Cifre on 6/30/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var weatherAPIClient = WeatherAPIClient()


    var body: some View {
        NavigationStack {
            if let currentWeather = weatherAPIClient.currentWeather {
                ZStack {
                    NavyBackgroundView()
                        .ignoresSafeArea()

                    VStack {
                        WeatherView(currentWeather: currentWeather)
                            .padding([.horizontal, .top])
                    }
                }
            } else {
                ContentUnavailableView("Unable to load weather", systemImage: "cloud.rain")
                Button("Refresh", action: {
                    Task {
                        await weatherAPIClient.fetchWeather()
                    }
                })
            }
        }
        .onAppear {
            Task {
                await weatherAPIClient.fetchWeather()
            }
        }
    }

}





#Preview {
    ContentView()
}
