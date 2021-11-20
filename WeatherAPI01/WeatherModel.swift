//
//  WeatherModel.swift
//  WeatherAPI01
//
//  Created by Abdullah Alnutayfi on 16/11/2021.
//

import Foundation




struct WeatherData : Codable, Identifiable{
    let name :String
    let main : Main
    let weather : [Weather]
    let coord: Coord
    var id : String{
        name
    }
}
struct Coord: Codable {
    let lon, lat: Double
}
struct Main :Codable{
    let temp : Double
    let humidity : Int
    let feels_like : Double
    let temp_min : Double
    let temp_max : Double
    let pressure : Int
}


struct Weather: Codable, Identifiable {
    let id : Int
    let icon : String
    let description : String
    
}



