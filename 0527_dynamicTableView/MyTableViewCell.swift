//
//  MyTableViewCell.swift
//  0527_dynamicTableView
//
//  Created by 손대홍 on 2021/05/27.
//

import Foundation
import UIKit

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userProfileImg: UIImageView!
    
    @IBOutlet weak var userContentLabel: UILabel!
    
    // 셀이 렌더링 될 때
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("MyTableViewCell - awakeFromNib() called")
        
        userProfileImg.layer.cornerRadius = userProfileImg.frame.width / 2
    }
}
