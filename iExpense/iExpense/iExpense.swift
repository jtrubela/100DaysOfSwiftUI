//
//  ContentView.swift
//  iExpense
//
//  Created by Justin Trubela on 1/5/22.
//


import SwiftUI

struct iExpenseView: View {
    
    @StateObject var expenses = Expenses()
    @StateObject var businessExpenses = Expenses()
    
    @State private var addViewIsShowing = false
    
    var body: some View {
        NavigationView{
            List {
                Section{
                ForEach(expenses.items) { item in
                    HStack{
                        VStack(alignment:.leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            .foregroundColor(item.amount >= 100.0 ? .green : item.amount < 10.0 ? .red : .black)
                    }
                }
                .onDelete(perform: removePersonalItems)
                } header: {
                    Text("Personal")
                }
                
                
                Section{
                ForEach(businessExpenses.items) { item in
                    HStack{
                        VStack(alignment:.leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            .foregroundColor(item.amount >= 100.0 ? .green : item.amount < 10.0 ? .red : .black)
                    }
                }
                .onDelete(perform: removeBusinessItem)
                } header: {
                    Text("Buisness")
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    addViewIsShowing = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }.sheet(isPresented: $addViewIsShowing) {
            AddView(expenses: expenses, businessExpenses: businessExpenses)
        }
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    func removeBusinessItem(at offsets: IndexSet){
        businessExpenses.items.remove(atOffsets: offsets)

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        iExpenseView()
    }
}
