//
//  HypedEventView.swift
//  HypedList
//
//  Created by Mac mini on 2021/08/29.
//

import SwiftUI

struct CreateHypedEventView: View {
    
    @StateObject var hypedEvent = HypedEvent()
    @State var showTime = false
    @State var showImagePicker = false
    
    // a small change
    var body: some View {
        Form {
            
            
            Section {
                FormLabelView(color: Color.green, title: "Title", iconSystemName: "keyboard")
                TextField("Family Vacation", text: $hypedEvent.title)
                    .autocapitalization(.words)
            }
            Section {
                FormLabelView(color: Color.blue, title: "Date", iconSystemName: "calendar")
                DatePicker("Date", selection: $hypedEvent.date, displayedComponents: showTime ? [.date, .hourAndMinute] : [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                Toggle(isOn: $showTime)  {
                    FormLabelView(color: Color.blue, title: "Time", iconSystemName: "clock.fill")
                }
            }
            
            
            Section {
                if hypedEvent.image() == nil {
                    
                    HStack {
                        FormLabelView(color: .purple, title: "Image", iconSystemName: "camera")
                        
                        Spacer()
                        Button(action: {
                            showImagePicker = true
                        }){
                            Text("Pick Image")
                        }
                    }
                } else {
                    HStack {
                        FormLabelView(color: .purple, title: "Image", iconSystemName: "camera")
                        
                        Spacer()
                        Button(action: {
                            hypedEvent.imageData = nil
                        }){
                            Text("Remove Image")
                                .foregroundColor(.red)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    Button(action: {
                        showImagePicker = true
                    }){
                        hypedEvent.image()!
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(imageData: $hypedEvent.imageData)
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
