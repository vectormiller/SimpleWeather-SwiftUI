//
//  InDevelopmentView.swift
//  SimpleWeather
//
//  Created by vectormiller on 4/1/23.
//

import SwiftUI

struct InDevelopmentView: View {
    var body: some View {
        VStack {
            Spacer().frame(height: 130)
            Image(systemName: "gear")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
            Text("We're still working on this feature.")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
            Spacer().frame(height: 30)
            VStack(alignment: .leading, spacing: 16) {
                Text("If you have any questions or suggestions, please contact us:")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                HStack {
                                    Image(systemName: "envelope")
                                        .foregroundColor(.blue)
                                    Text("support@example.com")
                                }
                                HStack {
                                    Image(systemName: "phone")
                                        .foregroundColor(.green)
                                    Text("+1 (555) 123-4567")
                                }
                                HStack {
                                    Image(systemName: "mappin.and.ellipse")
                                        .foregroundColor(.orange)
                                    Text("123 Main Street, Anytown USA")
                                }
            }
            Spacer()
        }
    }
}



struct InDevelopmentView_Previews: PreviewProvider {
    static var previews: some View {
        InDevelopmentView()
    }
}
