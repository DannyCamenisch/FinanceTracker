//
//  CreateAccountView.swift
//  FinanceTracker
//
//  Created by Danny on 01.07.20.
//

import SwiftUI

struct CreateAccountView: View {
    @State var accountName: String = ""
    @State var amount: Float = 0
    @State var primaryColor: Color = Color.random()
    @State var secondaryColor: Color = Color.random()
    @Binding var isPresented: Bool
    
    @EnvironmentObject var accountStore: AccountStore
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    
    var body: some View {
        
        ZStack {
            Color(colorScheme == ColorScheme.dark ? #colorLiteral(red: 0.082153745, green: 0.1134554222, blue: 0.2190876603, alpha: 1) : #colorLiteral(red: 0.8834986091, green: 0.9078560472, blue: 0.9523162246, alpha: 1)).edgesIgnoringSafeArea(.all)
            VStack {
                TextField("Enter Account Name", text: $accountName)
                    .keyboardType(.default)
                TextField("Enter Initial Amount", text: Binding(
                    get: { String(self.amount) },
                    set: { self.amount = ($0 as NSString).floatValue}
                ))
                .keyboardType(.decimalPad)
                HStack{
                    ColorPicker("Primary Color", selection: $primaryColor)
                    ColorPicker("Secondary Color", selection: $secondaryColor)
                }
                .frame(height: 200)
                
                Button {
                    accountStore.addNewAccountWith(name: accountName, balance: amount, primaryColor: primaryColor, secondaryColor: secondaryColor) {
                        isPresented = false
                    }
                } label: {
                    Text("Save Account")
                        .font(.system(size: 25, weight: .medium, design: .rounded))
                        .padding(8)
                }
                .foregroundColor(.white)
                .background(Color(#colorLiteral(red: 0, green: 0.7183558551, blue: 1, alpha: 1)))
                .cornerRadius(35)
            }
        }
    }
}
