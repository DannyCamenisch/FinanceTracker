//
//  MainView.swift
//  FinanceTracker
//
//  Created by Danny on 01.07.20.
//

import SwiftUI

struct MainView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var accountStore: AccountStore
    @State var isPresented = false
    
    var body: some View {
        ZStack {
            Color(colorScheme == ColorScheme.dark ? #colorLiteral(red: 0.082153745, green: 0.1134554222, blue: 0.2190876603, alpha: 1) : #colorLiteral(red: 0.8834986091, green: 0.9078560472, blue: 0.9523162246, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                HStack {
                    (
                        Text("Current Balance:")
                            .font(.system(size: 25, weight: .bold, design: .rounded))
                            + Text("\n\(accountStore.totalBalance)")
                            .font(.system(size: 25, weight: .medium, design: .rounded))
                    )
                    .padding(.horizontal, 25)
                    .padding(.top, 15)
                    .layoutPriority(1)
                    
                    Button {
                        isPresented = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 40))
                    }
                    .padding(.top, 17)
                    .padding(.horizontal, 25)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                }
                ScrollView {
                    VStack {
                        ForEach(accountStore.accounts) { account in
                            CardView(account: account)
                                .contextMenu {
                                Button {
                                    print("Context 1")
                                } label: {
                                    Label("New transaction", systemImage: "plus")
                                }
                                Button {
                                    accountStore.delete(account: account)
                                } label: {
                                    Label("Remove Account", systemImage: "trash")
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }.sheet(isPresented: $isPresented, content: {
                CreateAccountView(isPresented: $isPresented).environmentObject(accountStore)
            })
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
