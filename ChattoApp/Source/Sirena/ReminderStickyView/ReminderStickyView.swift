//
//  ReminderStickyView.swift
//  ChattoApp
//
//  Created by Maca on 04/09/2018.
//  Copyright © 2018 Badoo. All rights reserved.
//

import UIKit

class ReminderStickyView: UIView {

    @IBOutlet weak var alarmImage: UIImageView!
    var view: UIView!
    
    //MARK: Constructors
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        setupView()
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ReminderStickyView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func setupView() {
        alarmImage.tintColor = UIColor.white
    }

}
