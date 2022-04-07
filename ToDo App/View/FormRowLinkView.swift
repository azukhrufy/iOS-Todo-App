//
//  FormRowLinkView.swift
//  ToDo App
//
//  Created by mac on 08/04/22.
//

import SwiftUI

struct FormRowLinkView: View {
    //MARK: - PROPERTIES
    
    var icon: String
    var color: Color
    var text: String
    var link: String
    
    
    //MARK: - BODY
    var body: some View {
        HStack {
            ZStack{
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundColor(Color.white)
            }//: ZStack
            .frame(width: 36, height: 36, alignment: .center)
            Text(text).foregroundColor(Color.gray)
            Spacer()
            Button(action: {
                // Open the link
                guard let url = URL(string: self.link), UIApplication.shared.canOpenURL(url) else{
                    return
                }
                UIApplication.shared.open(url as URL)
                
            }){
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
            }
            .accentColor(Color(.systemGray2))
        }//: HStack
    }
}


//MARK: - PREVIEW
struct FormRowLinkView_Previews: PreviewProvider {
    static var previews: some View {
        FormRowLinkView(icon: "globe", color: Color.pink, text: "website", link: "https://azukhrufy-portfolio.vercel.app")
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}
