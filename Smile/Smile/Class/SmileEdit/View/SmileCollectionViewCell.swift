//
//  SmileCollectionViewCell.swift
//  Smile
//
//  Created by 李金 on 1/18/19.
//  Copyright © 2019 Kingandyoga. All rights reserved.
//

import UIKit

class SmileCollectionViewCell: UICollectionViewCell {

    var label: UILabel = UILabel.init(frame: .zero)
    var imageView: UIImageView = UIImageView.init(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(label)
        label.isHidden = true
        
        self.imageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(70)
            make.centerX.equalTo(self)
            make.top.equalToSuperview().offset(10)
        }
        
        self.label.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(28)
        }
    }
    
    func setData(name:String, image:UIImage) -> Void {
        self.label.text = name
        self.imageView.image = image
    }
    
    func setSelected(_ selected:Bool) -> Void {
        if selected {
            self.layer.borderColor = UIColor.yellow.cgColor
            self.layer.borderWidth = 2
        }else {
            self.layer.borderColor = UIColor.white.cgColor
            self.layer.borderWidth = 2
        }
    }
}
