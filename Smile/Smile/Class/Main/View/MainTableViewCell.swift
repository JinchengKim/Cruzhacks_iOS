//
//  MainTableViewCell.swift
//  Smile
//
//  Created by 李金 on 1/19/19.
//  Copyright © 2019 Kingandyoga. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    var boxView:UIView = UIView.init(frame: .zero)
    var faceView:UIImageView = UIImageView.init(frame: .zero)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    static func cellWithTableView(tableView:UITableView, reusedIdentifier identifier:String) -> MainTableViewCell{
        var cell:MainTableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as? MainTableViewCell
        if cell == nil {
            cell = MainTableViewCell.init(style: .default, reuseIdentifier: identifier)
        }
        return cell!
    }
    
    func initView(){
        self.backgroundColor = .clear
        
        boxView.backgroundColor = .white
        
        self.addSubview(boxView)
        boxView.addSubview(faceView)
        
        boxView.layer.cornerRadius = 10
        faceView.layer.cornerRadius = 10
        
        boxView.snp.makeConstraints { (make) in
            make.height.height.equalTo(SCREEN_WIDTH - 20)
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        faceView.snp.makeConstraints { (make) in
            make.height.height.equalToSuperview()
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
