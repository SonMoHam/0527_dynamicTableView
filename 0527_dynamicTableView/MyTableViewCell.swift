//
//  MyTableViewCell.swift
//  0527_dynamicTableView
//
//  Created by 손대홍 on 2021/05/27.
//

import Foundation
import UIKit
import SwipeCellKit

class MyTableViewCell: SwipeTableViewCell {
    
    @IBOutlet weak var userProfileImg: UIImageView!
    
    @IBOutlet weak var userContentLabel: UILabel!
    
    @IBOutlet weak var heartBtn: MyHeartBtn!
    
    @IBOutlet weak var thumbsUpBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet var btns: [UIButton]!
    
    var heartBtnAction: ((Bool) -> Void)?
    // 피드 데이터
    var feedData: Feed? {
        didSet{
            print("MyTableViewCell - didSet / feedData: \(String(describing: feedData))")
            
            if let data = feedData {
                
                
            }
        }
    }
    
    // 셀이 렌더링 될 때
    override func awakeFromNib() {
        super.awakeFromNib()
        print("MyTableViewCell - awakeFromNib() called")
        
        userProfileImg.layer.cornerRadius = userProfileImg.frame.width / 2
    }
    
    func updateUI(with data: Feed) {
        print("MyTableViewCell - updateUI() called")
//        heartBtn.tintColor = data.isFavorite ? #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1) : .systemGray
        heartBtn.setState(data.isFavorite)
        thumbsUpBtn.tintColor = data.isThumbsUp ? #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 1)
        userContentLabel.text = data.content
    }
}
