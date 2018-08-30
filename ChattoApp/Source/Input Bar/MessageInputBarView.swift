//
//  MessageInputBarView.swift
//  ChattoApp
//
//  Created by Maca on 29/08/2018.
//  Copyright © 2018 Badoo. All rights reserved.
//

import UIKit
import ChattoAdditions

class MessageInputBarView: UIView {

    var view: UIView!
    
    @IBOutlet weak var leftButtonStackView: UIStackView!
    @IBOutlet weak var rightButtonsStackView: UIStackView!
    @IBOutlet weak var textViewContainer: UIView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var camButton: UIButton!
    @IBOutlet weak var micButton: UIButton!
    @IBOutlet weak var expandableTextView: ExpandableTextView!
    
    
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
        
}
