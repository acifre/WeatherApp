//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Anthony Cifre on 6/30/23.
//

import SwiftUI

struct WeatherView: View {
    var currentWeather: Weather

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

                    Text("Houston, TX")
                        .font(.largeTitle)
                }
                    .foregroundStyle(.white)

                currentWeather.weatherCode.image
                    .font(.system(size: 150))
                    .foregroundStyle(.yellow)
                VStack {
                    Text("\(currentWeather.temperature)°")
                        .font(.system(size: 100))

                    Text(currentWeather.weatherCode.description)
                        .font(.title)

                    Text(Date.now, style: .date)
                        .font(.title3)

                }
                    .foregroundStyle(.white)
                Divider()
                    .foregroundStyle(.secondary)
                HStack(spacing: 30) {
                    VStack {
                        Image(systemName: "wind")
                        Text("12 mph")
                            .font(.title3)
                        Text("Wind")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    VStack {
                        Image(systemName: "drop")
                        Text("24%")
                            .font(.title3)
                        Text("Humidity")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    VStack {
                        Image(systemName: "umbrella")
                        Text("67%")
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
