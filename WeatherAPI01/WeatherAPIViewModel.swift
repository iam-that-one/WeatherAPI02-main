//
//  WeatherAPIViewModel.swift
//  WeatherAPI01
//
//  Created by Abdullah Alnutayfi on 16/11/2021.
//

import Foundation
import SwiftUI

class WeatherAPIViewModel : ObservableObject{
    @Published var weather = [WeatherData]()
    @Published var cityName = ""
    @Published var cityIcon = ""
    @Published var des = ""
    @Published var temp = 0.0
    func fetchWeatherData(cityName: String,lat : Double?, log : Double?){
        var API_URL = ""
        let API_KEY = "866847902dae7817cfda96a6c8990b35"
        if lat == nil && log == nil{
         API_URL = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(API_KEY)"
        }else{
            API_URL = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat ?? 0)&lon=\(log ?? 0)&appid=\(API_KEY)"
        }
        
        guard let url = URL(string: API_URL)else{
            print("Invalid URL . . . ")
            return
        }
        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let data = data{
                do{
                    let response = try decoder.decode(WeatherData.self, from: data)
                    DispatchQueue.main.async {
                        self.weather.append(WeatherData(name: response.name, main: response.main, weather: response.weather, coord: .init(lon: response.coord.lon, lat: response.coord.lat)))
                        //if cityName == response.name{
                        self.cityName = response.name
                        self.cityIcon = response.weather.first?.icon ?? ""
                        self.des = response.weather.first?.description ?? ""
                        self.temp = response.main.temp
                   //     }
                        print(response)
                    }
                    print(response)
                }catch{
                    print(error.localizedDescription)
                }
            }
            print(error?.localizedDescription as Any)
        }
        dataTask.resume()
    }

    func loadImage(ImageUrl: String) -> Data?{
        print("----- \(ImageUrl)")
        let imURL = "https://openweathermap.org/img/wn/\(ImageUrl)@2x.png"
        print(imURL)
        guard let url = URL(string: imURL) else {return Data()}
        if let data = try? Data(contentsOf: url){
            return data
        }
        return nil
    }
}


