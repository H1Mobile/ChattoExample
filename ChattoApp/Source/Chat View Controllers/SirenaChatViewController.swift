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
    
    //var chatInputPresenter: BasicChatInputBarPresenter!
    var stickyStackView: UIStackView?
    
    var dataSource: SirenaChatDataSource! {
        didSet {
            self.chatDataSource = self.dataSource
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sirena"
        prepareView()
    }
    
    override func createChatInputView() -> UIView {
//        let chatInputView = ChatInputBar.loadNib()
//        var appearance = ChatInputBarAppearance()
//        appearance.sendButtonAppearance.title = NSLocalizedString("Send", comment: "")
//        appearance.textInputAppearance.placeholderText = NSLocalizedString("Type a message", comment: "")
//        self.chatInputPresenter = BasicChatInputBarPresenter(chatInputBar: chatInputView, chatInputItems: self.createChatInputItems(), chatInputBarAppearance: appearance)
//        chatInputView.maxCharactersCount = 1000
        

        let chatInputView = MessageInputBarView.loadNib()
        chatInputView.delegate = self
        return chatInputView
    }
    
    func createChatInputItems() -> [ChatInputItemProtocol] {
        // Por cada tipo de item de input hay que crear una clase que cumple con el protocolo de ChatInputItemProtocol
        var items = [ChatInputItemProtocol]()
        items.append(self.createTextInputItem())
//        items.append(self.createPhotoInputItem())
        return items
    }
    
    private func createTextInputItem() -> TextChatInputItem {
        let item = TextChatInputItem()
        item.textInputHandler = { [weak self] text in
            // Your handling logic
            self?.dataSource.addTextMessage(text)
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
    
    fileprivate func prepareView() {
        self.view.backgroundColor = UIColor.init(hexString: "eceff1")
        navigationItem.titleView = NavProspectView(frame: CGRect(x: 0, y: 0, width: 250, height: 40))
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "0097a7")
        navigationController?.navigationBar.backgroundColor = UIColor(hexString: "0097a7")
        navigationItem.backBarButtonItem?.tintColor = UIColor.white
        
        prepareStickyContainer()
    }
    
    fileprivate func prepareStickyContainer() {
        stickyStackView = UIStackView(frame: CGRect.zero)
        stickyStackView?.backgroundColor = UIColor.red
        stickyStackView?.alignment = .fill
        stickyStackView?.distribution = .fill
        stickyStackView?.spacing = 4
        view.addSubview(stickyStackView!)
        
        stickyStackView?.translatesAutoresizingMaskIntoConstraints = false
        

        stickyStackView?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        stickyStackView?.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        stickyStackView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true

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

extension SirenaChatViewController: MessageInputBarViewDelegate {
    func didTapPlusButton() {
        var removed = false
        self.stickyStackView?.arrangedSubviews.forEach({ (subView) in
            subView.removeFromSuperview()
            removed = true
        })
        if !removed {
            let reminderStickyView = ReminderStickyView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 36))
            self.stickyStackView?.addArrangedSubview(reminderStickyView)
        }

    }
    
    
}
