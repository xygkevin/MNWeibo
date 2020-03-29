//
//  MNStatusPictureView.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/28.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNStatusPictureView: UIView {
    
    var urls: [MNStatusPicture]?{
        didSet{
            //hidden imageView
            subviews.forEach { $0.isHidden = true}

            guard let urls = urls else {
                print("MNStatusPictureView - urls is empty.")
                return
            }
            
            var index = 0
            for url in urls{
                let iv:UIImageView = subviews[index] as! UIImageView
                
                //特殊处理4张图片的情况
                if index == 1 && urls.count == 4{
                    index += 1
                }
                
                iv.mn_setImage(urlString: url.thumbnail_pic, placeholderImage: nil)
                iv.isHidden = false
                index += 1
            }
        }
    }
    
    var viewModel: MNStatusViewModel?{
        didSet{
            //包含原创&被转发
            urls = viewModel?.picUrls
            self.snp.updateConstraints { (make) in
                make.height.equalTo(viewModel?.pictureViewSize.height ?? 0)
            }
        }
    }

    init(parentView: UIView?, topView: UIView?, bottomView: UIView?) {
        super.init(frame: CGRect())
//        self.backgroundColor = superview?.backgroundColor
        self.backgroundColor = UIColor.orange
        
        let margin = MNLayout.Layout(12)
        guard let parentView = parentView, let topView = topView else {
            return
        }
        
        parentView.addSubview(self)
        
        if bottomView == nil{
            self.snp.makeConstraints { (make) in
                      make.left.equalTo(margin)
                      make.right.equalTo(-margin)
                      make.top.equalTo(topView.snp.bottom)
                      make.bottom.equalToSuperview()
                      make.height.equalTo(MNLayout.Layout(200))
                  }
        }else{
            self.snp.makeConstraints { (make) in
                      make.left.equalTo(margin)
                      make.right.equalTo(-margin)
                      make.top.equalTo(topView.snp.bottom)
                      make.bottom.lessThanOrEqualTo(bottomView!.snp.top).offset(-margin)
                      make.height.equalTo(MNLayout.Layout(200))
                  }
        }
        
//        self.snp.makeConstraints { (make) in
//            make.left.equalTo(margin)
//            make.right.equalTo(-margin)
//            make.top.equalTo(topView.snp.bottom)
//            make.bottom.lessThanOrEqualTo(bottomView.snp.top).offset(-margin)
//            make.height.equalTo(MNLayout.Layout(200))
//        }
        
        setupPictures()
    }
    
    func setupPictures()  {
        clipsToBounds = true
        let maxCount = 9
  
        for i in 0..<maxCount{
            
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            iv.image = UIImage(named: "timeline_icon_ip")
            let row = CGFloat(i / Int(MNPictureMaxPerLine))
            let column = CGFloat(i % Int(MNPictureMaxPerLine))
            let x = column * (MNPictureItemWidth + MNStatusPictureInnerMargin)
            let y = MNStatusPictureOutterMargin + row * (MNPictureItemWidth + MNStatusPictureInnerMargin)
            iv.frame = CGRect(x: x, y: y, width: MNPictureItemWidth, height: MNPictureItemWidth)
        
            addSubview(iv)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
