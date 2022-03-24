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
    
    @Environment(\.managedObjectContext) var manageObjectContext //for access internal storage for save todo item
    
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos: FetchedResults<Todo>
    @State private var showingAddTodoView: Bool = false
    @State private var showingEditTodoView: Bool = false
    
    @State var selectedTodo: Todo?
    
    // Body
    var body: some View {
        NavigationView{
            List{
                ForEach(self.todos, id: \.self){
                    todo in NavigationLink(destination: EditTodoView(newName: todo.name ?? "unknown",newPriority: todo.priority ?? "Unknown")){
                        HStack{
                            Text(todo.name ?? "Unknown")
                            Spacer()
                            Text(todo.priority ?? "Unknown")
                        }
                    }
                    
                    
                    
                }//foreach
                .onDelete(perform: deleteTodo)
//                .onTapGesture {
//                    self.showingEditTodoView.toggle()
//                }
                
            } // List
            .navigationBarTitle("Todo", displayMode: .inline)
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: {
                //Show act todo view
                self.showingAddTodoView.toggle()
            }){
                Image(systemName: "plus")
            } // add button
            .sheet(isPresented: $showingAddTodoView){
                AddTodoView().environment(\.managedObjectContext,self.manageObjectContext)
            }
            )
//            .sheet(isPresented: $showingEditTodoView){
//                EditTodoView()
//            }
        }// Navigation
        
    }
    //functions
    private func deleteTodo(at offsets: IndexSet) {
        for index in offsets{
            let todo = todos[index]
            manageObjectContext.delete(todo)
            
            do{
                try manageObjectContext.save()
            }catch{
                print(error)
            }
        }
    }
}



// Preview
struct ContentView_Previews: PreviewProvider {
    @UIApplicationDelegateAdaptor(MyAppDelegate.self) var appDelegate
    static var previews: some View {
//        let context = (UIApplication.shared.delegate as! MyAppDelegate).persistentContainer.viewContext
        ContentView()
            .previewDevice("iPhone 11 Pro")
.previewInterfaceOrientation(.portrait)
    }
}
