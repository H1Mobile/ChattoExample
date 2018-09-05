//
//  SirenaChatDataSource.swift
//  ChattoApp
//
//  Created by Maca on 24/08/2018.
//  Copyright © 2018 Badoo. All rights reserved.
//

import Foundation
import Chatto

class SirenaChatDataSource: ChatDataSourceProtocol {
    
    var delegate: ChatDataSourceDelegateProtocol?

    var nextMessageId: Int = 0
    let preferredMaxWindowSize = 500
    
    var slidingWindow: SlidingDataSource<ChatItemProtocol>!

    var hasMoreNext: Bool {
        return self.slidingWindow.hasMore()
    }
    
    var hasMorePrevious: Bool {
        return self.slidingWindow.hasPrevious()
    }
    
    var chatItems: [ChatItemProtocol] {
        return self.slidingWindow.itemsInWindow
    }
    
    init(items: [ChatItemProtocol], pageSize: Int) {
        self.slidingWindow = SlidingDataSource(items: items, pageSize: pageSize)
    }

    func loadNext() {
        self.slidingWindow.loadNext()
        self.slidingWindow.adjustWindow(focusPosition: 1, maxWindowSize: self.preferredMaxWindowSize)
        self.delegate?.chatDataSourceDidUpdate(self, updateType: .pagination)
    }
    
    func loadPrevious() {
        self.slidingWindow.loadPrevious()
        self.slidingWindow.adjustWindow(focusPosition: 0, maxWindowSize: self.preferredMaxWindowSize)
        self.delegate?.chatDataSourceDidUpdate(self, updateType: .pagination)
    }
    
    func adjustNumberOfMessages(preferredMaxCount: Int?, focusPosition: Double, completion:(_ didAdjust: Bool) -> Void) {
        let didAdjust = self.slidingWindow.adjustWindow(focusPosition: focusPosition, maxWindowSize: preferredMaxCount ?? self.preferredMaxWindowSize)
        completion(didAdjust)
    }
    
    
    // MARK: - Adding components
    func addTextMessage(_ text: String) {
        let uid = "\(self.nextMessageId)"
        self.nextMessageId += 1
        let message = DemoChatMessageFactory.makeTextMessage(uid, text: text, isIncoming: false)
        self.slidingWindow.insertItem(message, position: .bottom)
        self.delegate?.chatDataSourceDidUpdate(self)
    }
    
}
