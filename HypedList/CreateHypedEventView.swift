//
//  HypedEventView.swift
//  HypedList
//
//  Created by Mac mini on 2021/08/29.
//

import SwiftUI

struct CreateHypedEventView: View {
    
    @StateObject var hypedEvent = HypedEvent()
    
    var body: some View {
        Form {
            Section {
                FormLabelView(color: Color.green, title: "Title", iconSystemName: "keyboard")
            TextField("Family Vacation", text: $hypedEvent.title)
                .autocapitalization(.words)
            }
            Section {
                FormLabelView(color: Color.blue, title: "Date", iconSystemName: "calendar")
            DatePicker("Date", selection: $hypedEvent.date, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(GraphicalDatePickerStyle())
            }
            
            Section {
               
                ColorPicker(selection: $hypedEvent.color) {
                    FormLabelView(color: Color.yellow, title: "Color", iconSystemName: "eyedropper")
                }
            }
            
            Section {
                FormLabelView(color: Color.orange, title: "URL", iconSystemName: "link")
            TextField("WonderWoman.com", text: $hypedEvent.url)
                .keyboardType(.URL)
                .autocapitalization(.none)
            }
            
        }
       
    }
}

struct HypedEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateHypedEventView()
    }
}
