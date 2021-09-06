//
//  RoundedButtonView.swift
//  SwiftUI Basics
//
//  Created by Mac mini on 2021/08/28.
//

import SwiftUI

struct FormLabelView: View {
    
    var color: Color
    
    var title: String = "default"
    
    var iconSystemName: String = "keyboard"
    
    var body: some View {
        
        Label {
            Text(title) //
        } icon: {
            Image(systemName: iconSystemName) //
                .padding(4)
                .background(color) //
                .cornerRadius(7)
                .foregroundColor(.white)
        }
    }
}

struct RoundedButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FormLabelView(color: Color.blue, title: "default", iconSystemName: "calendar")
            .previewLayout(.sizeThatFits)
    }
}
