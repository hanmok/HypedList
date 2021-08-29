//
//  HypedEvent.swift
//  HypedList
//
//  Created by Mac mini on 2021/08/29.
//

import Foundation
import SwiftUI

class HypedEvent: ObservableObject {
    var date = Date()
    var title = ""
    var url = ""
    var color = Color.purple
    var imageData : Data?
}
