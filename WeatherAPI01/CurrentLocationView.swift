//
//  CurrentLocationView.swift
//  WeatherAPI01
//
//  Created by Abdullah Alnutayfi on 18/11/2021.
//

import SwiftUI
import MapKit
struct CurrentLocationView : View{
    @State var latitude : CLLocationDegrees?
    @State var longitude : CLLocationDegrees?
    @StateObject var coreLocationManager = CoreLocationManagerViewModel()
    @StateObject var weatherAPIViewModel = WeatherAPIViewModel()
    var userLatitude: Double {
          return coreLocationManager.lastLocation?.coordinate.latitude ?? 0
      }
      
      var userLongitude: Double {
          return coreLocationManager.lastLocation?.coordinate.longitude ?? 0
      }
    @State var region =  MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 0.0,
            longitude: 0.0
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 10,
            longitudeDelta: 10
        )
    )
    var body: some View{
        ZStack{
        Map(coordinateRegion: $region)
                .ignoresSafeArea()
                .overlay(
                    VStack{
                   // ForEach(weatherAPIViewModel.weather){ weathrt in
                       // if weathrt.coord.lat == userLatitude{
                            Text(weatherAPIViewModel.cityName)
                            Image(uiImage: UIImage(data: weatherAPIViewModel.loadImage(ImageUrl: weatherAPIViewModel.cityIcon) ?? Data()) ?? UIImage())
                        Text(weatherAPIViewModel.des)
                        Text("Temperature: \(weatherAPIViewModel.temp - 272.15  ,specifier: "%0.2f")")
                      //  }
                    //}
                    }
                        .shadow(color: .white, radius: 5)
                        .frame(width: 300, height: 400)
                        .background(Color.black.opacity(0.70))
                        .cornerRadius(7)
                )
            
       
        } .onAppear{
            weatherAPIViewModel.fetchWeatherData(cityName: "", lat: userLatitude, log: userLongitude)
            region =  MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: userLatitude,
                    longitude: userLongitude
                ),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.5,
                    longitudeDelta: 0.5
                )
            )
        }
    }
}
