//
//  FaceRectView.swift
//  Smile
//
//  Created by 李金 on 1/18/19.
//  Copyright © 2019 Kingandyoga. All rights reserved.
//

import UIKit

class FaceRectView: UIView {

    private var _didTapView: (() -> Void)?
    public func didTapView(completion: @escaping () -> Void) {
        _didTapView = completion
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tapView(_:))))
        initView()
        
    }
    
    func initView() -> Void {
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapView(_ sender:Any) -> Void {
        self.backgroundColor = RGBA(250, 196, 96, 125)
        _didTapView?()
    }
    
    public func setUnSelect(){
        self.backgroundColor = .clear
    }
}
