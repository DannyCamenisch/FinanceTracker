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
    
    @State var showCreateAccount = false
    @State var showNewTransaction = false
    @State var showUpdateBalance = false
    @State var selectedAccount: Account?
    
    enum SheetDestination {
        case none
        case createAccount
        case newTransaction
        case updateBalance
    }
    
    var body: some View {
        ZStack {
            Color(colorScheme == ColorScheme.dark ? #colorLiteral(red: 0.082153745, green: 0.1134554222, blue: 0.2190876603, alpha: 1) : #colorLiteral(red: 0.8834986091, green: 0.9078560472, blue: 0.9523162246, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                HStack {
                    (
                        Text("Total Balance:")
                            .font(.system(size: 25, weight: .bold, design: .rounded))
                            + Text("\n\(accountStore.totalBalance)")
                            .font(.system(size: 25, weight: .medium, design: .rounded))
                    )
                    .padding(.horizontal, 25)
                    .padding(.top, 15)
                    .layoutPriority(1)
                    
                    Button {
                        showCreateAccount.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 40))
                    }
                    .padding(.top, 17)
                    .padding(.horizontal, 25)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .sheet(isPresented: $showCreateAccount, content: {
                        CreateAccountView(isPresented: $showCreateAccount).environmentObject(accountStore)
                    })
                }
                
                ScrollView {
                    VStack {
                        ForEach(accountStore.accounts) { account in
                            CardView(account: account)
                                .contextMenu {
                                    Button {
                                        showNewTransaction.toggle()
                                        selectedAccount = account
                                    } label: {
                                        Label("New Transaction", systemImage: "plus")
                                    }
                                    
                                    Button {
                                        showUpdateBalance.toggle()
                                        selectedAccount = account
                                    } label: {
                                        Label("Update Balance", systemImage: "arrow.clockwise")
                                    }
                                    
                                    Button {
                                        accountStore.delete(account: account)
                                    } label: {
                                        Label("Remove Account", systemImage: "trash")
                                    }
                                }
                                .background(EmptyView().sheet(isPresented: $showNewTransaction, content: {
                                    CreateTransactionView(account: $selectedAccount, isPresented: $showNewTransaction).environmentObject(accountStore)
                                })
                                .background(EmptyView().sheet(isPresented: $showUpdateBalance, content: {
                                    UpdateBalanceView(account: $selectedAccount, isPresented: $showUpdateBalance).environmentObject(accountStore)
                                })
                                )
                                )
                            
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}
