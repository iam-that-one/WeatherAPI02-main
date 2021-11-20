//
//  FavoriteViewModel.swift
//  WeatherAPI01
//
//  Created by Abdullah Alnutayfi on 19/11/2021.
//

import SwiftUI

class ViewModel : ObservableObject{
    @Published var weather : [WeatherData] = []
    @State var strings : [String] = []
   func get(){
        strings = (UserDefaults.standard.object(forKey: "fav02") as? [String]) ?? []
        for cityName in strings{
            let API_KEY = "866847902dae7817cfda96a6c8990b35"
            let API_URL = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(API_KEY)"
       
     
        guard let url = URL(string: API_URL)else{
            print("Invalid URL . . . ")
            print("aaaaa\(API_URL)")
            return
        }
        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
        let dataTask = URLSession.shared.dataTask(with: request)  {  (data, _, error) in
            
            if let data = data{
                do{
                    let response = try decoder.decode(WeatherData.self, from: data)
                 //   DispatchQueue.main.async {
                        self.weather.append(WeatherData(name: response.name, main: response.main, weather: response.weather, coord: .init(lon: response.coord.lon, lat: response.coord.lat)))
                        print("AAAAAA \(self.weather.count)")
                    print(self.weather)
                     //   print(response)
                   // }
                  //  print(response)
                }catch{
                   // print(error.localizedDescription)
                }
            }
           // print(error?.localizedDescription as Any)
        }
        dataTask.resume()
        }
    }
}
