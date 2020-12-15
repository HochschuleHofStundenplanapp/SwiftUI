//
//  ColoredNavigationHeader.swift
//  StundenplanApp
//
//  Created by Eric Münch on 15.12.20.
//

import SwiftUI

struct ColoredNavigationHeader : View {
    
    let headerText : String
    let backgroundColor = ColorConstants.primaryDark
    let textColor = ColorConstants.textLight
    
    var body: some View{
        VStack{
            HStack(alignment: .center){
                Text(headerText)
                    .font(.title)
                    .foregroundColor(textColor)
                    .bold()
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                Spacer()
            }.padding(EdgeInsets(top: 40, leading: 0, bottom: 10, trailing: 0))
        }.background(backgroundColor)
    }
}
