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
    let activatedImage = UIImage(systemName: "heart.fill")?.withTintColor(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)).withRenderingMode(.alwaysOriginal)
    let normalImage = UIImage(systemName: "heart")?.withTintColor(#colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 1)).withRenderingMode(.alwaysOriginal)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("MyHeartBtn - awakeFromNib() called")
        configureAction()
    }
    
    func setState(_ newValue: Bool) {
        print("MyHeartBtn - setState() called / newValue: \(newValue)")
        
        // 현재 버튼의 상태 변경
        self.isActivated = newValue
        
        // 상태에 따른 이미지 변경

        self.setImage(self.isActivated ? activatedImage : normalImage, for: .normal)
    }
    
    fileprivate func configureAction() {
        print("MyHeartBtn - configureAction() called")
        self.addTarget(self, action: #selector(onBtnClicked(_:)), for: .touchUpInside)
    }
    
    @objc fileprivate func onBtnClicked(_ sender: UIButton){
        print("MyHeartBtn - onBtnClicked() called")
        self.isActivated.toggle()
        // 애니메이션 처리
        animate()
    }
    
    fileprivate func animate() {
        print("MyHeartBtn - animate() called")
        
        // 클릭 시 작아지기 - 크기 변경 50%, 1초 동안
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            guard let self = self else { return }
            
            let newImage = self.isActivated ? self.activatedImage : self.normalImage
            self.transform = self.transform.scaledBy(x: 0.5, y: 0.5)
            self.setImage(newImage, for: .normal)
        }, completion: { _ in
            // 원래 크기로 변경 - 크기 되돌림, 1초 동안
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = CGAffineTransform.identity
            })
        })
        
    }
}
