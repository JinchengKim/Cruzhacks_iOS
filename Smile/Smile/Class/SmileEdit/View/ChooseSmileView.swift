//
//  ChooseSmileView.swift
//  Smile
//
//  Created by 李金 on 1/18/19.
//  Copyright © 2019 Kingandyoga. All rights reserved.
//

import UIKit

public protocol ChooseSmileViewDelegate:class{
    func clickChooseSmileView(_ image:UIImage, _ index:Int)
}

class ChooseSmileView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var collectionView:UICollectionView!
    var smiles:[UIImage] = []
    var smileName:[String] = ["Original", "Smile 1", "Smile 2", "Smile 3", "Smile 4", "Smile 5"]
    var delegate:ChooseSmileViewDelegate?
    var selectIdx:Int = 0
    
    init(smiles:[UIImage]) {
        super.init(frame: .zero)
        initViews()
    }
    
    func initViews() {
        self.collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout())
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self)
        }
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(SmileCollectionViewCell.self, forCellWithReuseIdentifier: "FilterCollectionCell")
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.backgroundColor = .clear
    }
    
    func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 4
        layout.sectionInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        layout.itemSize = CGSize(width: 100, height: 100)
        return layout
    }
    
    
    func setData(smiles:[UIImage], selectIdx:Int){
        self.smiles = smiles
        self.selectIdx = selectIdx
        self.collectionView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChooseSmileView:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.smiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let s = self.smiles[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionCell", for: indexPath) as? SmileCollectionViewCell {
            cell.setData(name: self.smileName[indexPath.row], image: s)
//            cell.setSelected(self.selectIdx == indexPath.row)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        selectedFilter = typeList[indexPath.row]
        self.delegate?.clickChooseSmileView(self.smiles[indexPath.row], indexPath.row)
    }
}
