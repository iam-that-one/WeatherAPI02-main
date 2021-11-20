//
//  ContentView.swift
//  WeatherAPI01
//
//  Created by Abdullah Alnutayfi on 16/11/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Home()
                .tabItem {
                    Text("Home")
                    Image(systemName: "house")
                }
            CurrentLocationView()
                .tabItem {
                    Text("Map")
                    Image(systemName: "map.fill")
                }
            FavouriteCitiesView()
                .tabItem {
                    Text("Favourite")
                    Image(systemName: "star.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

