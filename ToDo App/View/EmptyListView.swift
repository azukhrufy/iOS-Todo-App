//
//  EmptyListView.swift
//  ToDo App
//
//  Created by mac on 27/03/22.
//

import SwiftUI

struct EmptyListView: View {
    // Properties
    @State private var isAnimated: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                Image("undraw_searching_re_3ra9")
                    .resizable()
                    .scaledToFit()
                    .frame(alignment: .center)
                    .layoutPriority(1)
                Text("Use your time wisely")
                    .layoutPriority(0.5)
                    .font(.system(.headline, design: .rounded))
            }// vstack
            .padding(.horizontal)
            .opacity(isAnimated ? 1 : 0)
            .offset(y: isAnimated ? 0 : -50)
            .animation(.easeOut(duration: 1.0))
            .onAppear(perform: {
                self.isAnimated.toggle()
            })
        }//ZStack
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color("Color"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
    }
}
