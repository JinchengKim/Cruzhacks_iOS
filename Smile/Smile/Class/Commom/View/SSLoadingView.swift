//
//  SSLoadingView.swift
//  Smile
//
//  Created by 李金 on 1/18/19.
//  Copyright © 2019 Kingandyoga. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
let noticeString = [
    "loading...",
    "Go to beach"
]

class SSLoadingView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 44, height: 44), type: .ballRotate, color: UIColor.black, padding: 0)
    
    init() {
        super.init(frame: CGRect.zero)
        self.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-32)
        }
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        self.activityIndicatorView.startAnimating()
    }
    
    func hide(){
        self.superview?.bringSubviewToFront(self)
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }) { (finished) in
            if finished {
                self.removeFromSuperview()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
