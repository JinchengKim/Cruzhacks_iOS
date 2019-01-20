//
//  ChooseFaceToolView.swift
//  Smile
//
//  Created by 李金 on 1/19/19.
//  Copyright © 2019 Kingandyoga. All rights reserved.
//

import UIKit

public protocol ChooseFaceToolViewDelegate:class{
//    func clickChooseSmileView(_ image:UIImage, _ index:Int)
    func clickChooseFaceToolAt(_ index:Int)
}

class ChooseFaceToolView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    var buttonStrings:[String] = []
    var delegate:ChooseFaceToolViewDelegate?
    var buttons:[UIButton] = []
    var selectBtn:UIButton?
    
    init(btnStrs:[String]) {
        super.init(frame: .zero)
        self.buttonStrings = btnStrs
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        
        let line:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 1))
        line.backgroundColor = RGB(200, 200, 200)
        self.addSubview(line)
        
        var buttons:[UIButton] = []
        for i in 0...self.buttonStrings.count-1{
            let b = UIButton.init(type: .custom)
            b.setTitle(self.buttonStrings[i], for: .normal)
            b.setTitleColor(RGB(200, 200, 200), for: .normal)
            b.addTarget(self, action: #selector(clickBtn(_:)), for: .touchUpInside)
            buttons.append(b)
        }
        
        self.buttons = buttons
        
        var alighLeftItem = self.snp.left
        var firstBtn:UIButton!
        for i in 0...buttons.count-1 {
            let button = buttons[i]
            self.addSubview(button)
            if i == 0 {
                firstBtn = button
                button.snp.makeConstraints { (make) in
                    make.height.equalToSuperview()
                    make.left.equalTo(alighLeftItem)
                    make.top.equalToSuperview()
                }
                alighLeftItem = button.snp.right
            }else if i < buttons.count - 1{
                button.snp.makeConstraints { (make) in
                    make.width.equalTo(firstBtn)
                    make.height.equalToSuperview()
                    make.top.equalToSuperview()
                    make.left.equalTo(alighLeftItem)
                }
                alighLeftItem = button.snp.right
            }else{
                button.snp.makeConstraints { (make) in
                    make.width.equalTo(firstBtn)
                    make.height.equalToSuperview()
                    make.left.equalTo(alighLeftItem)
                    make.right.equalTo(self.snp.right)
                    make.top.equalToSuperview()
                }
            }
        }
    }
    
    @objc func clickBtn(_ sender:UIButton){
        for i in 0...self.buttons.count{
            if sender == self.buttons[i]{
                if self.selectBtn != nil{
                    self.selectBtn?.setTitleColor(RGB(200, 200, 200), for: .normal)
                }
                self.selectBtn = self.buttons[i]
                self.selectBtn?.setTitleColor(.black, for: .normal)
                self.delegate?.clickChooseFaceToolAt(i)
                break;
            }
        }
    }
    
    func setClick(_ index:Int){
        self.clickBtn(self.buttons[index])
    }
    
    
}
