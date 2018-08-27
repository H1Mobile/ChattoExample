//
//  NotesCollectionViewCell.swift
//  ChattoApp
//
//  Created by Maca on 25/08/2018.
//  Copyright © 2018 Badoo. All rights reserved.
//

import UIKit

class NotesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noteIconImage: UIImageView!
    @IBOutlet weak var noteContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func commonInit() {
        let tintColor = UIColor(hexString: "ffc107")
        noteIconImage.image = noteIconImage.image?.tinted(with: tintColor)
        
        noteContainerView.layer.borderWidth = 1
        noteContainerView.layer.borderColor = tintColor.cgColor
    }
    
    var text: String = "" {
        didSet {
            if oldValue != text {
                self.setTextOnLabel(text)
            }
        }
    }
    
    var stringDate: String = "" {
        didSet {
            if oldValue != stringDate {
                self.setDateOnLabel(stringDate)
            }
        }
    }
    
    private func setTextOnLabel(_ text: String) {
        self.textLabel.text = text
        self.setNeedsLayout()
    }
    
    private func setDateOnLabel(_ stringDate: String) {
        self.dateLabel.text = stringDate
        self.setNeedsLayout()
    }
    


}
