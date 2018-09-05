//
//  MessageInputBarView.swift
//  ChattoApp
//
//  Created by Maca on 29/08/2018.
//  Copyright © 2018 Badoo. All rights reserved.
//

import UIKit
import ChattoAdditions

protocol MessageInputBarViewDelegate {
    func didTapPlusButton()
}

class MessageInputBarView: UIView {

    var view: UIView!
    
    @IBOutlet weak var leftButtonStackView: UIStackView!
    @IBOutlet weak var rightButtonsStackView: UIStackView!
    @IBOutlet weak var textViewContainer: UIView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var camButton: UIButton!
    @IBOutlet weak var micButton: UIButton!
    @IBOutlet weak var expandableTextView: ExpandableTextView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    
    var delegate: MessageInputBarViewDelegate?
    
    //MARK: Constructors
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: type(of: self).nibName(), bundle: bundle)
        let view = nib.instantiate(withOwner: nil, options: nil).first as! UIView
        return view
    }
    
    class func loadNib() -> MessageInputBarView {
        let view = Bundle(for: self).loadNibNamed(self.nibName(), owner: nil, options: nil)!.first as! MessageInputBarView
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect.zero
        return view
    }
    
    class func nibName() -> String {
        return "MessageInputBarView"
    }
    
    override func awakeAfter(using aDecoder: NSCoder) -> Any? {
        if self.subviews.count > 0 {
            return self
        }
        
        let bundle = Bundle(for: type(of: self))
        if let loadedView = bundle.loadNibNamed(type(of: self).nibName(), owner: nil, options: nil)?.first as? UIView {
            loadedView.frame = frame
            loadedView.autoresizingMask = autoresizingMask
            loadedView.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
            for constraint in constraints {
                let firstItem = constraint.firstItem === self ? loadedView : constraint.firstItem
                let secondItem = constraint.secondItem === self ? loadedView : constraint.secondItem
                loadedView.addConstraint(NSLayoutConstraint(item: firstItem as Any, attribute: constraint.firstAttribute, relatedBy: constraint.relation, toItem: secondItem, attribute: constraint.secondAttribute, multiplier: constraint.multiplier, constant: constraint.constant))
            }
            return loadedView
        } else {
            return nil
        }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.expandableTextView.scrollsToTop = false
        self.expandableTextView.delegate = self
        self.expandableTextView.placeholderDelegate = self
    }
    
    func toggleSendButton() {
        if sendButton.isHidden {
            plusButton.isHidden = true
            camButton.isHidden = true
            micButton.isHidden = true
            sendButton.isHidden = false
            mediumButton.isHidden = false
        } else {
            sendButton.isHidden = true
            mediumButton.isHidden = true
            plusButton.isHidden = false
            camButton.isHidden = false
            micButton.isHidden = false
        }
        
    }
    
    
    @IBAction func plusButtonAction(_ sender: Any) {
        delegate?.didTapPlusButton()
    }
    
    @IBAction func sendButtonAction(_ sender: Any) {
    }
}

extension MessageInputBarView: UITextViewDelegate {
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        //return self.delegate?.inputBarShouldBeginTextEditing(self) ?? true
        toggleSendButton()
        return true
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        //self.presenter?.onDidEndEditing()
        //self.delegate?.inputBarDidEndEditing(self)
        toggleSendButton()
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        //self.presenter?.onDidBeginEditing()
        //self.delegate?.inputBarDidBeginEditing(self)
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        //self.updateSendButton()
        //self.delegate?.inputBarDidChangeText(self)
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn nsRange: NSRange, replacementText text: String) -> Bool {
//        let range = self.textView.text.bma_rangeFromNSRange(nsRange)
//        if let maxCharactersCount = self.maxCharactersCount {
//            let currentCount = textView.text.count
//            let rangeLength = textView.text[range].count
//            let nextCount = currentCount - rangeLength + text.count
//            return UInt(nextCount) <= maxCharactersCount
//        }
        return true
    }
}

// MARK: ExpandableTextViewPlaceholderDelegate
extension MessageInputBarView: ExpandableTextViewPlaceholderDelegate {
    public func expandableTextViewDidShowPlaceholder(_ textView: ExpandableTextView) {
        //self.delegate?.inputBarDidShowPlaceholder(self)
    }
    
    public func expandableTextViewDidHidePlaceholder(_ textView: ExpandableTextView) {
        //self.delegate?.inputBarDidHidePlaceholder(self)
    }
}
