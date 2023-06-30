//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Anthony Cifre on 6/30/23.
//

import CoreLocation
import CoreLocationUI
import SwiftUI

struct WeatherView: View {
    var currentWeather: Weather
    var currentCity: String
    var currentCountry: String


    var body: some View {
        ZStack {
            Rectangle()

                .foregroundStyle(LinearGradient(colors: [.cyan, .blue], startPoint: .top, endPoint: .bottom))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .cornerRadius(50)
                .shadow(color: .gray, radius: 5)


            VStack(alignment: .center, spacing: 20) {
                HStack(alignment: .center) {
//                    Image(systemName: "mappin.circle")
//                        .font(.title2)
//                        .foregroundStyle(.indigo)
                    Text("\(currentCity), \(currentCountry)")
                        .font(.title2)
                        .bold()
                }
                    .foregroundStyle(.white)

                currentWeather.weatherCode.image
                    .font(.system(size: 150))
                    .foregroundStyle(currentWeather.weatherCode.color)
                VStack(spacing: 10) {
                    Text("\(currentWeather.temperature)°")
                        .font(.system(size: 100))
                    Text("Feels like \(currentWeather.temperatureApparent)º")
                        .font(.title3)
                        .foregroundStyle(.secondary)
//                        .padding(.bottom, 20)

                    Text(currentWeather.weatherCode.description)
                        .multilineTextAlignment(.center)
                        .font(.title)

                    Text(Date.now, style: .date)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
                    .foregroundStyle(.white)
//                Divider()
//                    .foregroundStyle(.secondary)
                HStack(spacing: 30) {
                    VStack(alignment: .center) {
                        Image(systemName: "wind")
                        Text("\(currentWeather.windSpeed) m/s")
                            .font(.title3)
                        Text("Wind")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    VStack(alignment: .center) {
                        Image(systemName: "drop")
                        Text("\(currentWeather.humidity)%")
                            .font(.title3)
                        Text("Humidity")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    VStack(alignment: .center) {
                        Image(systemName: "umbrella")
                        Text("\(currentWeather.precipitationProbability)%")
                            .font(.title3)
                        Text("Precipitation")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                }
                    .foregroundStyle(.white)
            }
        }

    }


}

//#Preview {
//    WeatherView()
//}
