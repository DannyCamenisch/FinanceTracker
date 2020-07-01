//
//  CardView.swift
//  ManaBar
//
//  Created by Danny on 25.06.20.
//

import SwiftUI

struct CardView: View {
    @State var account: Account
    @State var isPresented: Bool = false
    @State var dragOffset: CGFloat = 0
    @State var isDraged: Bool = false
    
    @EnvironmentObject var accountStore: AccountStore
    
    var body: some View {
        VStack {
            HStack {
            BankCard(isPresented: $isPresented, isDraged: $isDraged, account: account)
                .offset(x: dragOffset)
                .gesture(DragGesture()
                            .onChanged { value in
                                if value.translation.width <= -25 {
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                                        self.dragOffset = 0
                                        self.isDraged = true
                                        self.isPresented = false
                                    }
                                }
                                if value.translation.width >= 25 {
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                                        self.dragOffset = 0
                                        self.isDraged = false
                                    }
                                }
                            }
                )
                
                if isDraged {
                    Button {
                        let index = accountStore.accounts.firstIndex(where: {$0.id == account.id})
                        withAnimation { accountStore.accounts.remove(at: index!) }
                    } label: {
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 50))
                            .foregroundColor(.red)
                            .shadow(radius: 10, x: 10, y: 10)
                    }
                    .offset(x: -20)
                }
            }
            
            if isPresented && !isDraged {
            ZStack {
                Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
                VStack (spacing: 25){
                    ForEach(account.balanceChanges) { balanceChange in
                        Expense(balanceChange: balanceChange)
                    }
                }.padding(.vertical, 20)
            }
            .cornerRadius(25.0)
            .shadow(radius: 10, x: 10, y: 10)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            .transition(AnyTransition.opacity.combined(with: .offset(y: 400)))
            }
            
            Spacer().layoutPriority(1)
        }
    }
}

struct BankCard: View {
    @Binding var isPresented: Bool
    @Binding var isDraged: Bool
    var account: Account
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [account.primaryColor, account.secondaryColor]),
                           startPoint: .bottomLeading,
                           endPoint: .topTrailing)
            VStack {
                HStack {
                    Text(account.name)
                        .foregroundColor(.white)
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                
                Spacer(minLength: 0)
                
                HStack {
                    Text("\(account.formattedBalance())")
                        .foregroundColor(.white)
                        .font(.system(size: 25, weight: .medium, design: .rounded))
                    Spacer()
                }
                .padding(.horizontal, 20)
                
            }
            .padding(.vertical, 15)
            .frame(height: isPresented ? 225 : 100)
            
        }
        .onTapGesture {
            if !isDraged {
                withAnimation {
                    isPresented.toggle()
                }
            }
        }
        .cornerRadius(25.0)
        .shadow(radius: 10, x: 10, y: 10)
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
    }
}

struct Expense: View {
    var balanceChange: BalanceChange
    
    var body: some View {
            HStack {
                balanceChange.image.font(.system(size: 25, weight: .bold, design: .rounded))
                Text(balanceChange.description).font(.system(size: 20, weight: .bold, design: .rounded))
                Spacer()
                Text(String(format: "%.2f", balanceChange.amount))
                    .font(.system(size: 20, weight: .medium, design: .rounded))
            }
            .shadow(radius: 6, x: 5, y: 5)
            .foregroundColor(.white)
            .padding(.horizontal, 20)
    }
}
