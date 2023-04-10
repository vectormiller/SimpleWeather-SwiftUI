//
//  TonightView.swift
//  SimpleWeather
//
//  Created by vectormiller on 4/1/23.
//

import SwiftUI

struct TonightView: View {
    //@State private var bars = Bar.sampleBars
    @Binding var weather: ResponseBody
    
    private var bars: [Bar] {
        var tempBars = [Bar]()
        
        for i in 0..<7 {
            let value = Double(weather.list[i].main.temp.roundDouble())!
            var barColor: Color = .green
            var barIcon: String = "moon.stars.circle"
            
            let timeZoneOffset = Int(weather.city.timezone.roundDouble())!
            var calendar = Calendar(identifier: .gregorian)
            calendar.timeZone = TimeZone(secondsFromGMT: timeZoneOffset)!

            let selectedDT = calendar.component(.hour, from: weather.list[i].dt)
            let sunriseDT = calendar.component(.hour, from: weather.city.sunrise)
            let sunsetDT = calendar.component(.hour, from: weather.city.sunset)

            if selectedDT >= sunsetDT - 2 && selectedDT <= sunriseDT + 2 {
                barIcon = "moon.stars.circle"
            } else if selectedDT >= sunriseDT - 2 && selectedDT <= sunriseDT + 2 {
                barIcon = "sunrise.circle"
            } else if selectedDT >= sunriseDT + 2 && selectedDT <= sunsetDT - 2 {
                barIcon = "sun.max.circle"
            } else if selectedDT >= sunsetDT - 2 && selectedDT <= sunsetDT + 2 {
                barIcon = "sunset.circle"
            }
            
            
            switch value { // Меняем цвет в зависимости от температуры
            case ..<(-5):
                barColor = .blue
            case (-5)..<30:
                barColor = .green
            case 30...:
                barColor = .orange
            default:
                barColor = .green
            }


            
            let bar = Bar(
                name: "\(i)",
                hour: String("\(selectedDT):00"),
                value: value,
                color: barColor,
                //icon: weather.list[0].weather[0].weatherIcon // Выводить иконку погоды
                icon: barIcon // Выводить иконку времени суток
            )
            tempBars.append(bar)
        }
        
        return tempBars
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Tonight and tomorrow")
                .font(.system(size: 30, weight: .bold))
            Text("\(weather.list[0].weather[0].description.capitalized) tonight. Here are more detailed weather data for the next few hours.")
                .font(.system(size: 22))
            Spacer().frame(height: 10)
            HStack(alignment: .bottom) {
                ForEach(bars) {bar in
                    VStack {
                        ZStack {
                            Rectangle()
                                .foregroundColor(bar.color)
                                .frame(width: 40, height: bar.value+50, alignment: .bottom)
                                .cornerRadius(6)
                            Text("\(Int(bar.value))°")
                                .foregroundColor(.white)
                                .bold()
                        }
                        Text(bar.hour)
                        Image(systemName: bar.icon)
                            .resizable()
                            .scaledToFit()
                            .padding(4)
                            .frame(width: 42, height: 42)
                            .foregroundColor({
                                switch bar.icon {
                                case "moon.stars.circle":
                                    return .blue
                                case "sunrise.circle":
                                    return .orange
                                case "sun.max.circle":
                                    return .yellow
                                case "sunset.circle":
                                    return .orange
                                default:
                                    return Color.indigo
                                }
                            }())
                    }
                }
            }
            //.padding(.bottom)
            .frame(height: 180, alignment: .bottom)
            .frame(maxWidth: .infinity)
            //.padding(5)
            //.background(.thinMaterial)
            .cornerRadius(6)
        }
        .frame(maxWidth: .infinity)
//        .frame(width: 370)
        
    }
}

struct TonightView_Previews: PreviewProvider {
    static var previews: some View {
        TonightView(weather: .constant(previewWeather))
    }
}
