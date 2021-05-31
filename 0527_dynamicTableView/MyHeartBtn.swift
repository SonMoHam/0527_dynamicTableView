//
//  MyHeartBtn.swift
//  0527_dynamicTableView
//
//  Created by 손대홍 on 2021/05/31.
//

import Foundation
import UIKit

class MyHeartBtn: UIButton {
    
    var isActivated: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("MyHeartBtn - awakeFromNib() called")
    }
    
    func setState(_ newValue: Bool) {
        print("MyHeartBtn - setState() called / newValue: \(newValue)")
        
        // 현재 버튼의 상태 변경
        self.isActivated = newValue
        
        // 상태에 따른 이미지 변경
        let activatedImage = UIImage(systemName: "heart.fill")?.withTintColor(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)).withRenderingMode(.alwaysOriginal)
        let normalImage = UIImage(systemName: "heart")?.withTintColor(#colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 1)).withRenderingMode(.alwaysOriginal)
        self.setImage(self.isActivated ? activatedImage : normalImage, for: .normal)
    }
}
