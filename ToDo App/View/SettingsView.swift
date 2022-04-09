//
//  SettingsView.swift
//  ToDo App
//
//  Created by mac on 06/04/22.
//

import SwiftUI

struct SettingsView: View {
    //MARK: - Properties
    @Environment(\.presentationMode) var presentationMode
    
    //Themes
    
    let themes: [Theme] = themeData
    @ObservedObject var theme = ThemeSettings.shared
    @State private var isThemeChanged: Bool = false
    
    //MARK: - Body
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: 0) {
                //MARK: - Form
                Form{
                    //MARK: SECTION THEME
                    Section(header: HStack {
                        Text("Choose the Theme Setting")
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(themes[self.theme.themeSettings].themeColor)
                    }){
                        List{
                            ForEach(themes,id: \.id) { item in
                                Button(action: {
                                    self.theme.themeSettings = item.id
                                    UserDefaults.standard.set(self.theme.themeSettings, forKey: "Theme")
                                    self.isThemeChanged.toggle()
                                }) {
                                    HStack{
                                        Image(systemName: "circle.fill")
                                            .resizable()
                                            .frame(width: 10, height: 10, alignment: .center)
                                            .foregroundColor(item.themeColor)
                                        Text(item.themeName)
                                            .accentColor(Color.gray)
                                    }//: HStack
                                }//: button
                                .accentColor(Color.primary)
                            }
                            
                        }//: List
                        
                    }//: Section Theme
                    .padding(.vertical, 3)
                    .alert(isPresented: $isThemeChanged){
                        Alert(
                            title: Text("Success"),
                            message: Text("The App Has Changed theme to \(themes[self.theme.themeSettings].themeName)!"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    
                    //MARK: SECTION LINK
                    Section(header: Text("About Me")){
                        FormRowLinkView(icon: "globe", color: Color.pink, text: "website", link: "https://azukhrufy-portfolio.vercel.app")
                        FormRowLinkView(icon: "users", color: Color.green, text: "github", link: "https://github/azukhrufy")
                    }//: Section Link
                    .padding(.vertical, 3)
                    
                    //MARK: SECTION About
                    Section(header: Text("About Application")){
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone, iPad")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Azukhrufy")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                    }//: Section 4
                    .padding(.vertical, 3)
                    
                }//: FORM
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                
                //MARK: - FOOTER
                Text("Copyright All Rights Reserved")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(Color.secondary)
            }//: Stack
            .navigationBarTitle("Settings",displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            })
                {
                    Image(systemName: "xmark")
                }
            )
            .background(Color("ColorBackground").edgesIgnoringSafeArea(.all))
        }//: Navigation
    }
}
//MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
