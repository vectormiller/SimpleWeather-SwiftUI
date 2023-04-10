//
//  RateAppView.swift
//  SimpleWeather
//
//  Created by vectormiller on 4/10/23.
//

import SwiftUI

struct RateAppView: View {
    let supportEmail = "support@myapp.com"
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text("Thank you for using our app! ♡")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .bold()
                
                Text("We're sorry, but our app is not currently available on the App Store. We're working hard to make it available as soon as possible.")
                    .font(.headline)
                
                Text("In the meantime, we would love to hear your feedback about our app. Please send your comments, suggestions, and bug reports to:")
                    .font(.headline)
                
                Text(supportEmail)
                    .font(.headline)
                    .foregroundColor(.blue)
                    .underline()
                    .onTapGesture {
                        guard let url = URL(string: "mailto:\(supportEmail)") else { return }
                        UIApplication.shared.open(url)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding([.leading, .trailing, .bottom], 20)
            
        }
}

struct RateAppView_Previews: PreviewProvider {
    static var previews: some View {
        RateAppView()
    }
}
