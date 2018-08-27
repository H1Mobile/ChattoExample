//
//  SirenaChatViewController.swift
//  ChattoApp
//
//  Created by Maca on 24/08/2018.
//  Copyright © 2018 Badoo. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions

class SirenaChatViewController: BaseChatViewController {
    
    var chatInputPresenter: BasicChatInputBarPresenter!
    
    var dataSource: SirenaChatDataSource! {
        didSet {
            self.chatDataSource = self.dataSource
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sirena"
        
    }
    
    override func createChatInputView() -> UIView {
        let chatInputView = ChatInputBar.loadNib()
        var appearance = ChatInputBarAppearance()
        appearance.sendButtonAppearance.title = NSLocalizedString("Send", comment: "")
        appearance.textInputAppearance.placeholderText = NSLocalizedString("Type a message", comment: "")
        self.chatInputPresenter = BasicChatInputBarPresenter(chatInputBar: chatInputView, chatInputItems: self.createChatInputItems(), chatInputBarAppearance: appearance)
        chatInputView.maxCharactersCount = 1000
        return chatInputView
    }
    
    func createChatInputItems() -> [ChatInputItemProtocol] {
        // Por cada tipo de item de input hay que crear una clase que cumple con el protocolo de ChatInputItemProtocol
        var items = [ChatInputItemProtocol]()
        items.append(self.createTextInputItem())
        items.append(self.createPhotoInputItem())
        return items
    }
    
    private func createTextInputItem() -> TextChatInputItem {
        let item = TextChatInputItem()
        item.textInputHandler = { [weak self] text in
            // Your handling logic
        }
        return item
    }
    
    private func createPhotoInputItem() -> PhotosChatInputItem {
        let item = PhotosChatInputItem(presentingController: self)
        item.photoInputHandler = { [weak self] image in
            // Your handling logic
        }
        return item
    }
    
    public typealias ChatItemType = String
    override func createPresenterBuilders() -> [ChatItemType: [ChatItemPresenterBuilderProtocol]] {
        
        return [
            SendingStatusModel.chatItemType: [SendingStatusPresenterBuilder()],
            TimeSeparatorModel.chatItemType: [TimeSeparatorPresenterBuilder()],
            NotesModel.chatItemType: [NotesPresenterBuilder()]
        ]
    }
}
