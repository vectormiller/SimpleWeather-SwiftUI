//
//  EmailView.swift
//  SimpleWeather
//
//  Created by vectormiller on 4/10/23.
//

import SwiftUI

struct EmailView: View {
    @State private var recipient: String = ""
    @State private var subject: String = ""
    @State private var message: String = ""
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text("Email Support")
                .font(.largeTitle)
                .bold()
            
            Text("If you have any questions or suggestions, please feel free to send us an email at:")
                .font(.headline)
            
            Form {
                Section(header: Text("Recipient").foregroundColor(.primary)) {
                    TextField("Email Address", text: $recipient)
                        .keyboardType(.emailAddress)
                }
                
                Section(header: Text("Subject").foregroundColor(.primary)) {
                    TextField("Subject", text: $subject)
                }
                
                Section(header: Text("Message").foregroundColor(.primary)) {
                    TextEditor(text: $message)
                }
                
                Button(action: {
                    // Send email logic here
                }) {
                    Text("Send Us Email →")
                }
                .disabled(recipient.isEmpty || subject.isEmpty || message.isEmpty)
            }
            .scrollContentBackground(.hidden)
            Spacer()
        }
        .padding([.leading, .trailing, .bottom], 20)
        //.background(Color(UIColor.systemGray5))
    }
}

struct EmailView_Previews: PreviewProvider {
    static var previews: some View {
        EmailView()
    }
}
