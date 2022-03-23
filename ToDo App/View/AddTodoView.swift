//
//  AddTodoView.swift
//  ToDo App
//
//  Created by mac on 23/03/22.
//

import SwiftUI

struct AddTodoView: View {
    // Properties
    
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    let priorities = ["High","Normal","Low"]
    
    //Body
    var body: some View {
        NavigationView{
            VStack{
                Form {
                    //Todo Name
                    TextField("Todo", text: $name)
                    
                    //Todo Priority
                    Picker("Priority", selection: $priority){
                        ForEach(priorities, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    // Save Button
                    Button(action: {
                        print("Save a new Todo Item")
                    }) {
                        Text("Save")
                    } // Save Button
                } //Form
                
                Spacer()
            } //Stack
            .navigationBarTitle("New Todo", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            })
                {
                    Image(systemName: "xmark")
                }
            )
        }//Navigation
    }
}


// Preview
struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
            .previewDevice("iPhone 11 Pro")
    }
}
