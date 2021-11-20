//
//  Home.swift
//  WeatherAPI01
//
//  Created by Abdullah Alnutayfi on 18/11/2021.
//

import Foundation
import SwiftUI
struct Home : View{
    @State var nameToSave = ""
    @State var cities : [String] = []
    @State var showLocation = false
    @State var city = ""
    @StateObject var weatherAPIViewModel = WeatherAPIViewModel()
    @StateObject var coreLocationManager = CoreLocationManagerViewModel()
    init(){
    //   UserDefaults.standard.set([], forKey: "fav02")
        print((UserDefaults.standard.object(forKey: "fav02") as? [String]) ?? [nameToSave])
    }
    var userLatitude: Double {
          return coreLocationManager.lastLocation?.coordinate.latitude ?? 0
      }
      
      var userLongitude: Double {
          return coreLocationManager.lastLocation?.coordinate.longitude ?? 0
      }
    var body: some View{
        VStack{
        HStack{
            Button {
                showLocation.toggle()
            } label: {
                Button(
                    action: {
                            weatherAPIViewModel.fetchWeatherData(cityName: city, lat: userLatitude, log: userLongitude)
                                }, label: {
                                    Image(systemName: "location.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .padding(.leading)
                                })
                
            }
            
        TextField("", text: $city)
            .padding(5)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke())
            .padding()
            Button {
                
            } label: {
                Button(
                    action: {
                            weatherAPIViewModel.fetchWeatherData(cityName: city, lat: nil, log: nil)
                                }, label: {
                                    Image(systemName: "magnifyingglass")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .padding(.trailing)
                                })
            }
        }
    List{
        ForEach(weatherAPIViewModel.weather){ weather in
           // VStack{
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
            .padding()   .onTapGesture{
                nameToSave = weather.name
              //  if (UserDefaults.standard.object(forKey: "fav02") as? [String])!.contains(nameToSave){
                    cities.append(contentsOf: (UserDefaults.standard.object(forKey: "fav02") as! [String]) )
               // }
              //  if !cities.contains(nameToSave){
               cities.append(nameToSave)
          //      }
                UserDefaults.standard.set(cities, forKey: "fav02")
                print((UserDefaults.standard.object(forKey: "fav02") as? [String]) ?? [nameToSave])
            }
           
          //  }//.swipeActions(edge:.leading){
              //  Label("", systemImage: "star")
            //}
        }.onDelete { indexPath in
            weatherAPIViewModel.weather.remove(atOffsets: indexPath)
        
        }
           // .listRowBackground(Color.purple)
    }//.listStyle(DefaultListStyle())
    }
    }
}
