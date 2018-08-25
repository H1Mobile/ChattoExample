//
//  NotesModel.swift
//  ChattoApp
//
//  Created by Maca on 25/08/2018.
//  Copyright © 2018 Badoo. All rights reserved.
//

import Foundation
import UIKit
import Chatto

class NotesModel: ChatItemProtocol {
    let uid: String
    let type: String = NotesModel.chatItemType
    let text: String
    let date: String
    
    static var chatItemType: ChatItemType {
        return "NotesModel"
    }
    
    init(uid: String, text: String, date: String) {
        self.text = text
        self.date = date
        self.uid = uid
    }
}
