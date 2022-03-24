//
//  EditTodoView.swift
//  ToDo App
//
//  Created by mac on 24/03/22.
//

import SwiftUI

struct EditTodoView: View {
    //Properties
    @Environment(\.managedObjectContext) private var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @State var newName: String = ""
    @State var newPriority: String = ""
    
    let priorities = ["High","Normal","Low"]
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    //name
                    TextField("Todo", text: $newName)
                    //priority
                    Picker("Priority", selection: $newPriority){
                        ForEach(priorities, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    // Save Button
                    Button(action: {
                        if self.newName != ""{
                            let todo = Todo(context: self.managedObjectContext)
                            todo.name = self.newName
                            todo.priority = self.newPriority
                            
                            do{
                                try self.managedObjectContext.save()
                                print("New Todo: \(todo.name ?? String())", "Prioriy: \(todo.priority ?? String())")
                            }catch{
                                print(error)
                            }
                        }else{
                            self.errorShowing = true
                            self.errorTitle = "Invalid Name"
                            self.errorMessage = "Make sure you fill the todo item"
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }) {
                        Text("Save")
                    } // Save Button
                    
                }
            }// stack
            .navigationBarTitle("Edit Todo", displayMode: .inline)
        }//navigation
    }
}

struct EditTodoView_Previews: PreviewProvider {
    static var previews: some View {
        EditTodoView()
            .previewDevice("iPhone 11 Pro")
    }
}
