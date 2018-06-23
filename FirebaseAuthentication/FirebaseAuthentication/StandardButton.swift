//
//  StandardButton.swift
//  FirebaseAuthentication
//
//  Created by Christopher Becom on 6/23/18.
//

import UIKit

class StandardButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        didLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didLoad()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    func didLoad() {
        layer.cornerRadius = frame.height / 2.0
        backgroundColor = UIColor.lightGray
        setTitleColor(UIColor.white, for: .normal)
    }
    
}
