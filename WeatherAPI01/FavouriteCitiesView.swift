//
//  FavouriteCitiesView.swift
//  WeatherAPI01
//
//  Created by Abdullah Alnutayfi on 18/11/2021.
//

import SwiftUI

struct FavouriteCitiesView : View{
    @State var myFavWeather : [WeatherData] = []
    @StateObject var weatherAPIViewModel = WeatherAPIViewModel()
    @StateObject var favViewModel = ViewModel()
     @State var strings : [String] = []
  //  @State var set : Set<String>
   @State var index = 0
//    func getFav(){
//
//        strings = (UserDefaults.standard.object(forKey: "fav02") as? [String]) ?? []
//      //  UserDefaults.standard.set([], forKey: "fav02")
//        for index in 0..<strings.count{
//            let API_KEY = "866847902dae7817cfda96a6c8990b35"
//            let API_URL = "https://api.openweathermap.org/data/2.5/weather?q=\(strings[index])&appid=\(API_KEY)"
//
//
//        guard let url = URL(string: API_URL)else{
//            print("Invalid URL . . . ")
//            print("aaaaa\(API_URL)")
//            return
//        }
//        let request = URLRequest(url: url)
//        let decoder = JSONDecoder()
//        let dataTask = URLSession.shared.dataTask(with: request)  {  (data, _, error) in
//
//            if let data = data{
//                do{
//                    let response = try decoder.decode(WeatherData.self, from: data)
//                    DispatchQueue.main.async {
//                        if myFavWeather.count < strings.count{
//
//                        myFavWeather.append(WeatherData(name: response.name, main: response.main, weather: response.weather, coord: .init(lon: response.coord.lon, lat: response.coord.lat)))
//                        }
////                        for i in myFavWeather{
////                            print("I am waether array \(i.name)")
////                        }
////                        for i in strings{
////                            print("I am strings array \(i)")
////                        }
//                        //print(response)
//                    }
//                  //  print(response)
//                }catch{
//                   // print(error.localizedDescription)
//                }
//            }
//          //  print(error?.localizedDescription as Any)
//        }
//        dataTask.resume()
//            print("call number \(index) \(strings[index]) wase added")
//        }
//
//        print("strings\(strings)")
//    }
    var body: some View{
        NavigationView{
        List{
            ForEach(myFavWeather) { weather in
                Section(header:
                            VStack{
                            Text(weather.name)
                    Text("\(weather.coord.lat), \(weather.coord.lon)")
                                .font(.caption)
                            }
                            .font(.largeTitle)) {
                    VStack(alignment: .leading){
                            Spacer()
                        ForEach(weather.weather) { w in
                            HStack{
                            Text(w.description)
                                Spacer()
                                Image(uiImage:UIImage(data: weatherAPIViewModel.loadImage(ImageUrl: w.icon) ?? Data()) ?? UIImage())
                            }
                            HStack{
                                Text("feels like")
                                        Spacer()
                                Text("\(weather.main.feels_like - 273.15,  specifier: "%.0f")°")
                                    }.padding(5)
                                .background(LinearGradient(colors: [.gray,.gray,.blue,.gray,.gray], startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(10)
                                    Divider()
                            Group{
                                HStack{
                                Text("temp min")
                                    Spacer()
                                Text("\(weather.main.temp_min - 273.15,  specifier: "%.0f")°")
                                }.padding(5)
                                    .background(LinearGradient(colors: [.gray,.gray,.red,.gray,.gray], startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(10)
                                HStack{
                                Text("temp max")
                                    Spacer()
                                Text("\(weather.main.temp_max - 273.15,  specifier: "%.0f")°")
                                }.padding(5)
                                    .background(LinearGradient(colors: [.gray,.gray,.yellow,.gray,.gray], startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(10)
                                HStack{
                                    Text("pressure")
                                    Spacer()
                                Text(" \(weather.main.pressure)")
                                }.padding(5)
                                    .background(LinearGradient(colors: [.gray,.gray,.green,.gray,.gray], startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(10)
                                HStack{
                                    Text("humidity")
                                    Spacer()
                                Text("\(weather.main.humidity)")
                                }.padding(5)
                                    .background(LinearGradient(colors: [.gray,.gray,.orange,.gray,.gray], startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
            }
        }.listStyle(DefaultListStyle())
        .padding()
        
        }
    }
}
