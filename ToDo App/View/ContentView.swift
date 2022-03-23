//
//  ContentView.swift
//  ToDo App
//
//  Created by mac on 23/03/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // Properties
    @State private var showingAddTodoView: Bool = false
    
    // Body
    var body: some View {
        NavigationView{
            List(0..<5){
                item in Text("Hello World")
            } // List
            .navigationBarTitle("Todo", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                //Show act todo view
                self.showingAddTodoView.toggle()
            }){
                Image(systemName: "plus")
            } // add button
            .sheet(isPresented: $showingAddTodoView){
                AddTodoView()
            }
            )
        }// Navigation
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11 Pro")
    }
}
