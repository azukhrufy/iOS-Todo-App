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
    @State private var showingSettingsView: Bool = false
    
    //THEME
    @ObservedObject var theme = ThemeSettings.shared
    var themes: [Theme] = themeData
    
    
    @State var selectedTodo: Todo?
    
    // Body
    var body: some View {
        NavigationView{
            ZStack {
                List{
                    ForEach(self.todos, id: \.self){
                        todo in NavigationLink(destination: EditTodoView(newName: todo.name ?? "unknown",newPriority: todo.priority ?? "Unknown")){
                            HStack{
                                Circle()
                                    .frame(width: 12, height: 12, alignment: .center)
                                    .foregroundColor(self.colorize(priority: todo.priority ?? "Normal"))
                                Text(todo.name ?? "Unknown")
                                    .fontWeight(.semibold)
                                Spacer()
                                Text(todo.priority ?? "Unkown")
                                  .font(.footnote)
                                  .foregroundColor(Color(UIColor.systemGray2))
                                  .padding(3)
                                  .frame(minWidth: 62)
                                  .overlay(
                                    Capsule().stroke(Color(UIColor.systemGray2), lineWidth: 0.75)
                                  )
                                
                            }// HStack
                            .padding(.vertical, 5)
                        }// Navigation Link
                    }//foreach
                    .onDelete(perform: deleteTodo)
                    
                } // List
                .navigationBarTitle("Todo", displayMode: .inline)
                .navigationBarItems(
                    leading: EditButton().accentColor(themes[self.theme.themeSettings].themeColor),
                    trailing: Button(action : {
                        self.showingSettingsView.toggle()
                    }){
                        Image(systemName: "paintbrush")
                    }
                        .accentColor(themes[self.theme.themeSettings].themeColor)
                        .sheet(isPresented: $showingSettingsView){
                            SettingsView()
                        }
                        
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
                            .fill(themes[self.theme.themeSettings].themeColor)
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
                    .accentColor(themes[self.theme.themeSettings].themeColor)
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
    
    private func colorize(priority: String) -> Color{
        var color: Color = Color.gray
        if priority == "High"{
            color = Color.red
        }else if priority == "Normal"{
            color =  Color.blue
        }else if priority == "Low"{
            color =  Color.green
        }
        return color
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
