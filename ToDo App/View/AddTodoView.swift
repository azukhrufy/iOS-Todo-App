//
//  AddTodoView.swift
//  ToDo App
//
//  Created by mac on 23/03/22.
//

import SwiftUI

struct AddTodoView: View {
    // Properties
    @Environment(\.managedObjectContext) var manageObjectContext // connecting to another view
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    let priorities = ["High","Normal","Low"]
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
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
                        if self.name != ""{
                            let todo = Todo(context: self.manageObjectContext)
                            todo.name = self.name
                            todo.priority = self.priority
                            
                            do{
                                try self.manageObjectContext.save()
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
            .alert(isPresented: $errorShowing){
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }//Navigation
    }
}


// Preview
struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
            .previewDevice("iPhone 11 Pro")
.previewInterfaceOrientation(.portrait)
    }
}
