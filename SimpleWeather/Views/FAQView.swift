//
//  FAQView.swift
//  SimpleWeather
//
//  Created by vectormiller on 4/10/23.
//

import SwiftUI

struct FAQView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("FAQs")
                .font(.title)
                .bold()
                .padding(.bottom, 10)
                .foregroundColor(.orange)
            
            Text("Q: How often is the weather data updated?")
                .bold()
            Text("A: The weather data is updated every 3 hours (Due to free API restrictions).")
            
            Text("Q: Can I change the temperature unit from Celsius to Fahrenheit?")
                .bold()
            Text("A: This feature is under development, we will add it soon.")
            
            Text("Q: Why is the weather information different from other sources?")
                .bold()
            Text("A: All weather information is taken from the OpenWeatherMap service according to the free API.")
            
            Text("Q: How can I report an error or suggest a new feature?")
                .bold()
            Text("A: Feel free to reach out to us via email at support@example.com or through other communication channels. We will do our best to respond promptly.")
            
            Spacer()
        }
        .padding([.leading, .trailing, .bottom], 20)
        .foregroundColor(.primary)
    }
}



struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        FAQView()
    }
}
