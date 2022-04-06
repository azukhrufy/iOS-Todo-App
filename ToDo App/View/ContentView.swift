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
    @State private var animatingButton: Bool = false
    
    
    @State var selectedTodo: Todo?
    
    // Body
    var body: some View {
        NavigationView{
            ZStack {
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
                    
                } // List
                .navigationBarTitle("Todo", displayMode: .inline)
                .navigationBarItems(
                    leading: EditButton()
                )
                
                //No Todo Item
                if todos.count == 0{
                    EmptyListView()
                }
            }// Zstack
            .sheet(isPresented: $showingAddTodoView){
                AddTodoView().environment(\.managedObjectContext,self.manageObjectContext)
            }
            .overlay(
                ZStack {
                    Group{
                        Circle()
                            .fill(Color.blue)
                            .opacity(self.animatingButton ? 0.2 : 0)
//                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
//                        Circle()
//                            .fill(Color.blue)
//                            .opacity(self.animatingButton ? 0.15 : 0)
////                            .scaleEffect(self.animatingButton ? 1 : 0)
//                            .frame(width: 88, height: 88, alignment: .center)
                    }
                    Button(action: {
                        self.showingAddTodoView.toggle()
                    }){
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(Color.white))
                            .frame(width: 48, height: 48, alignment: .center)
                    }//button
                    .onAppear(perform: {
                        self.animatingButton.toggle()
                    })
                }// ZStack
                    .padding(.bottom, 15)
                    .padding(.trailing, 15)
                , alignment: .bottomTrailing
            )
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
