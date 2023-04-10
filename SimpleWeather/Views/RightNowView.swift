//
//  RightNowView.swift
//  SimpleWeather
//
//  Created by vectormiller on 3/31/23.
//

import SwiftUI

struct RightNowView: View {
    @State private var pageIndex = 0
    @State private var tabViewHeight: CGFloat = 290
    private let dotAppearance = UIPageControl.appearance()
    
    @Binding var weather: ResponseBody
    
    private var timeZoneOffset: Int {
        Int(weather.city.timezone.roundDouble())!
    }

    private var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: timeZoneOffset)!
        return calendar
    }

    private var selectedDT: String {
        let hour = calendar.component(.hour, from: weather.list[0].dt)
        let minute = calendar.component(.minute, from: weather.list[0].dt)
        if hour < 10 {
            return "\(hour):\(String(format: "%02d", minute))"
        } else {
            return String(format: "%02d:%02d", hour, minute)
        }
    }
    
    private var sunriseDT: String {
        let hour = calendar.component(.hour, from: weather.city.sunrise)
        let minute = calendar.component(.minute, from: weather.city.sunrise)
        if hour < 10 {
            return "\(hour):\(String(format: "%02d", minute))"
        } else {
            return String(format: "%02d:%02d", hour, minute)
        }
    }
    
    private var sunsetDT: String {
        let hour = calendar.component(.hour, from: weather.city.sunset)
        let minute = calendar.component(.minute, from: weather.city.sunset)
        if hour < 10 {
            return "\(hour):\(String(format: "%02d", minute))"
        } else {
            return String(format: "%02d:%02d", hour, minute)
        }
    }


    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Right now")
                .font(.system(size: 30, weight: .bold))

            TabView(selection: $pageIndex) {
                VStack(alignment: .leading, spacing: 20) { // First page
                    Text("\(weather.list[0].weather[0].main) for the next three hours.\nSunrise around \(sunriseDT), Sunset \(sunsetDT)")
                        .font(.system(size: 22))
                    
                    HStack(alignment: .center, spacing: 20) {
                        ZStack {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 140, height: 140)
                            Image(weather.list[0].weather[0].weatherIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 125, maxHeight: 125)
                        }
                        VStack {
                            Text("\(weather.list[0].main.temp.roundDouble())°")
                                .font(.system(size: 60, weight: .bold))
                            Text("Feels like \(weather.list[0].main.feels_like.roundDouble())°")
                                .font(.system(size: 26, weight: .bold))
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading) // alignment для виджета
                    
                    Spacer() // Отступ для индикаторов
                }
                .tag(0)
                .tabItem {}
                .frame(maxWidth: .infinity)

                VStack(alignment: .leading, spacing: 15) { // Second page
                    HStack(alignment: .center, spacing: 20) {
                        Image(systemName: "wind.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 30)
                            .foregroundColor(.blue)
                        Text("Wind speed \(weather.list[0].wind.speed.roundDouble()) m/s.")

                    }
                    HStack(alignment: .center, spacing: 20) {
                        Image(systemName: "arrow.left.and.right.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 30)
                            .foregroundColor(.indigo)
                        Text("Visibility about \(String((weather.list[0].visibility / 1000).roundDouble())) km.")

                    }
                    HStack(alignment: .center, spacing: 20) {
                        Image(systemName: "drop.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 30)
                            .foregroundColor(.gray)
                        Text("Humidity \(weather.list[0].main.humidity.roundDouble())%.")
                    }
                    HStack(alignment: .center, spacing: 20) {
                        Image(systemName: "barometer")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 30)
                            .foregroundColor(.orange)
                        Text("Pressure \(weather.list[0].main.pressure.roundDouble()) hPa.")
                    }
                    HStack(alignment: .center, spacing: 20) {
                        Image(systemName: "sun.and.horizon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 30)
                            .foregroundColor(.yellow)
                        Text("Daytime \(sunriseDT) → \(sunsetDT).")
                    }
                    HStack(alignment: .center, spacing: 20) {
                        Image(systemName: "clock.arrow.circlepath")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 30)
                            .foregroundColor(.red)
                        Text("\(abs(weather.city.sunrise.timeIntervalSince(weather.city.sunset)/3600).roundDouble()) hours of daylight.")
                    }
                    Spacer() // Отступ для индикаторов
                }
                .font(.system(size: 20))
                .tag(1)
                .tabItem{}
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.horizontal, 5)
                .padding(.top, 10)
                
            }
            .animation(.easeInOut, value: pageIndex)
            .tabViewStyle(.page)
            .onAppear {
                dotAppearance.currentPageIndicatorTintColor = UIColor(Color.primary)
                dotAppearance.pageIndicatorTintColor = .gray
            }
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .frame(maxWidth: .infinity)
            .frame(height: tabViewHeight)
            .onChange(of: pageIndex) { _ in
                withAnimation(.easeInOut) {
                    tabViewHeight = pageIndex == 1 ? 310 : 290
                }
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        
    }
    
}

struct RightNowView_Previews: PreviewProvider {
    static var previews: some View {
        RightNowView(weather: .constant(previewWeather))
    }
}


