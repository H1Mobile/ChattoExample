//
//  NotesPresenter.swift
//  ChattoApp
//
//  Created by Maca on 25/08/2018.
//  Copyright © 2018 Badoo. All rights reserved.
//

import Foundation
import UIKit
import Chatto

public class NotesPresenterBuilder: ChatItemPresenterBuilderProtocol {
    
    public func canHandleChatItem(_ chatItem: ChatItemProtocol) -> Bool {
        return chatItem is NotesModel
    }
    
    public func createPresenterWithChatItem(_ chatItem: ChatItemProtocol) -> ChatItemPresenterProtocol {
        assert(self.canHandleChatItem(chatItem))
        return NotesPresenter(notesModel: chatItem as! NotesModel)
    }
    
    public var presenterType: ChatItemPresenterProtocol.Type {
        return NotesPresenter.self
    }
}

class NotesPresenter: ChatItemPresenterProtocol {
    
    let notesModel: NotesModel
    init (notesModel: NotesModel) {
        self.notesModel = notesModel
    }
    
    private static let cellReuseIdentifier = NotesCollectionViewCell.self.description()
    
    static func registerCells(_ collectionView: UICollectionView) {
        collectionView.register(NotesCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
    }
    
    func dequeueCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: NotesPresenter.cellReuseIdentifier, for: indexPath)
    }
    
    func configureCell(_ cell: UICollectionViewCell, decorationAttributes: ChatItemDecorationAttributesProtocol?) {
        guard let notesCell = cell as? NotesCollectionViewCell else {
            assert(false, "expecting status cell")
            return
        }
        
        notesCell.text = self.notesModel.text
        notesCell.stringDate = self.notesModel.date
    }
    
    var canCalculateHeightInBackground: Bool {
        return true
    }
    
    func heightForCell(maximumWidth width: CGFloat, decorationAttributes: ChatItemDecorationAttributesProtocol?) -> CGFloat {
        return 24
    }
}
