//
//  ContentView.swift
//  WeatherApp
//
//  Created by Anthony Cifre on 6/30/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            NavyBackgroundView()
                .ignoresSafeArea()

            VStack {
                WeatherView()
                    .padding([.horizontal, .top])
            }
        }
    }
}





#Preview {
    ContentView()
}
