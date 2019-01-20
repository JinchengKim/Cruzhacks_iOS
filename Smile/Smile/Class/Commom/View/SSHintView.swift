//
//  SSHintView.swift
//  Smile
//
//  Created by 李金 on 1/18/19.
//  Copyright © 2019 Kingandyoga. All rights reserved.
//

import UIKit
import SnapKit

class SSHintView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    static let sharedInstance = SSHintView(frame: CGRect(x:0,y:0,width:SCREEN_WIDTH, height:64))
    static let topRect = CGRect(x:0,y:-64,width:SCREEN_WIDTH, height:64)
    static let downRect = CGRect(x:0,y:0,width:SCREEN_WIDTH, height:64)
    var hintBgView:UIView = {
        let hintBgView = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64))
        hintBgView.backgroundColor = RGBA(0,0,0,125)
        return hintBgView
    }()
    var hintLabelView:UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.white
        label.font = FONT(18)
        label.textAlignment = .center
        return label
    }()
    var showHint:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.hintBgView)
        self.addSubview(self.hintLabelView)
        self.hintLabelView.snp.makeConstraints { (make) in
            make.left.equalTo(self.hintBgView.snp.left)
            make.right.equalTo(self.hintBgView.snp.right)
            make.top.equalTo(self.hintBgView.snp.top).offset(10)
            make.bottom.equalTo(self.hintBgView.snp.bottom)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Static func
    static func showHint(message: String){
        showHint(message, view: UIApplication.shared.keyWindow!)
    }
    
    static func showHint(_ message: String, view:UIView){
        let hintView = SSHintView.sharedInstance
        if !hintView.showHint{
            hintView.frame = topRect
            view.addSubview(hintView)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 2, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                hintView.frame = downRect
            }) { (finish) in
                
            }
            hintView.showHint = true
        }else{
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.removeThisView), object: nil)
        }
        self.removeViewAfterDelay(ti: 2)
        hintView.hintLabelView.text = message
    }
    
    static func removeViewAfterDelay(ti:TimeInterval){
        self.perform(#selector(self.removeThisView), with: nil, afterDelay: ti)
    }
    
    @objc static func removeThisView(){
        let hintView = SSHintView.sharedInstance
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 2, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            hintView.frame = topRect
        }) { (finish) in
            if finish {
                hintView.showHint = false
                hintView.removeFromSuperview()
            }
        }
        
    }
}
