//
//  CreateAccountView.swift
//  FinanceTracker
//
//  Created by Danny on 01.07.20.
//

import SwiftUI

struct CreateAccountView: View {
    @State var accountName: String = ""
    @ObservedObject var amount = NumbersOnly()
    @State var primaryColor: Color = Color.random()
    @State var secondaryColor: Color = Color.random()
    
    @Binding var isPresented: Bool
    
    @EnvironmentObject var accountStore: AccountStore
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        
        ZStack {
            Color(colorScheme == ColorScheme.dark ? #colorLiteral(red: 0.082153745, green: 0.1134554222, blue: 0.2190876603, alpha: 1) : #colorLiteral(red: 0.8834986091, green: 0.9078560472, blue: 0.9523162246, alpha: 1)).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                TextField("Account Name", text: $accountName)
                    .keyboardType(.default)
                    .padding()
                    .cornerRadius(5.0)
                    .shadow(radius: 10, x: 10, y: 10)
                
                TextField("Initial Amount", text: $amount.value)
                    .keyboardType(.decimalPad)
                    .padding()
                    .padding(.top, 10)
                    .cornerRadius(5.0)
                    .shadow(radius: 10, x: 10, y: 10)
                
                VStack{
                    ColorPicker(selection: $primaryColor) {
                        Text("Primary Color").font(.system(size: 22))
                    }
                    ColorPicker(selection: $secondaryColor) {
                        Text("Secondary Color").font(.system(size: 22))
                    }
                }
                .padding()
                .padding(.top, 20)
                Spacer()
                
                Button {
                    accountStore.addNewAccountWith(name: accountName, balance: Float(amount.value) ?? 0.0, primaryColor: primaryColor, secondaryColor: secondaryColor) {
                        isPresented = false
                    }
                } label: {
                    Text("Save Account")
                        .font(.system(size: 25, weight: .medium, design: .rounded))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                }
                .foregroundColor(.white)
                .background(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                .cornerRadius(35)
            }
            .padding()
        }
    }
}
