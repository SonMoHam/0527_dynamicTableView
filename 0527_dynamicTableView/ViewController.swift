//
//  ViewController.swift
//  0527_dynamicTableView
//
//  Created by 손대홍 on 2021/05/27.
//

import UIKit
import SwipeCellKit

let MY_TABLE_VIEW_CELL_ID = "myTableViewCell"

class Feed {
    let content: String
    var isFavorite: Bool = false
    var isThumbsUp: Bool = false
    
    init(content: String) {
        self.content = content
    }
}

class ViewController: UIViewController  {
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    var contentArray = [
        Feed(content: "Contrary to popular belief, Lorem Ipsum is not simply random text. "),
        
        Feed(content: "It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old."),
        
        Feed(content: "Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source."),
        
        Feed(content: "Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC."),
        
        Feed(content: "This book is a treatise on the theory of ethics, very popular during the Renaissance."),
        
        Feed(content: "The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32."),
        
        Feed(content: "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        // 셀 리소스 가져오기
        let myTableViewCellNib = UINib(nibName: String(describing: MyTableViewCell.self), bundle: nil)  // String(describing: MyTableViewCell.self)
        
        // 셀 리소스 등록¨
        self.myTableView.register(myTableViewCellNib, forCellReuseIdentifier: MY_TABLE_VIEW_CELL_ID)
        
        self.myTableView.rowHeight = UITableView.automaticDimension
        self.myTableView.estimatedRowHeight = 120
        
        // 델리겟, 데이터소스 링킹
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        print("contentArray.count: \(contentArray.count)")
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    
    // 테이블 뷰 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contentArray.count
    }
    
    // 각 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: MY_TABLE_VIEW_CELL_ID, for: indexPath) as! MyTableViewCell
        
        // 스와이프 셀 델리겟 연결
        cell.delegate = self
        
        // 데이터 UI 연결
        if self.contentArray.count > 0 {
            cell.feedData = contentArray[indexPath.row]
        }
        
        return cell
    }
}

// MARK: - SwipeTableViewCellDelegate
extension ViewController: SwipeTableViewCellDelegate {
    
    // 셀 스와이프 액션
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        // 데이터
        let dataItem = contentArray[indexPath.row] as Feed
        
        // 셀
        let cell = tableView.cellForRow(at: indexPath) as! MyTableViewCell
        
        // 스와이프 액션 방향 별 분기 처리
        switch orientation {
        case .left:
            let heartAction = SwipeAction(style: .default, title: nil,
                                          handler: { action, indexPath in
                                            print("heart action")
                                            
                                            // Bool 값 변경
                                            let updatedStatus = !dataItem.isFavorite
                                            dataItem.isFavorite = updatedStatus
                                            // 스와이프 한 cell 만 리로드
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6,
                                                                          execute: { tableView.reloadRows(at: [indexPath], with: .none)})
                                          })
            // 액션 마크 디자인
            heartAction.title = dataItem.isFavorite ? "찜 해제" : "찜 하기"
            heartAction.image = UIImage(systemName: dataItem.isFavorite ? "heart" : "heart.fill")
            heartAction.backgroundColor = dataItem.isFavorite ? .systemGray : #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            
            return [heartAction]
            
        case .right:
            let thumbsUpAction = SwipeAction(style: .default, title: nil,
                                             handler: { action, indexPath in
                                                print("thumbsUp action")
                                                
                                                // Bool 값 변경
                                                let updatedStatus = !dataItem.isThumbsUp
                                                dataItem.isThumbsUp = updatedStatus
                                                // 스와이프 한 cell 만 리로드
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6,
                                                                              execute: { tableView.reloadRows(at: [indexPath], with: .none)})
                                             })
            // 액션 마크 디자인
            thumbsUpAction.title = dataItem.isThumbsUp ? "좋아요 해제" : "좋아요"
            thumbsUpAction.image = UIImage(systemName: dataItem.isThumbsUp ? "hand.thumbsup" : "hand.thumbsup.fill")
            thumbsUpAction.backgroundColor = dataItem.isThumbsUp ? .systemGray : #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            
            // 바텀 액션 클로저
            let closure: (UIAlertAction) -> Void = { (action: UIAlertAction) in
                // 셀 액션 닫기
                cell.hideSwipe(animated: true)
                if let selectedTitle = action.title {
                    print("selectedTitle = \(selectedTitle)")
                    let alertController = UIAlertController(title: selectedTitle, message: "클릭됨", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            
            // 더보기 액션
            let moreAction = SwipeAction(style: .default, title: nil, handler: { action, indexPath in
                print("더보기 액션")
                
                let bottomAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                bottomAlertController.addAction(UIAlertAction(title: "댓글", style: .default, handler: closure))
                bottomAlertController.addAction(UIAlertAction(title: "자세히", style: .default, handler: closure))
                bottomAlertController.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: closure))
                
                self.present(bottomAlertController, animated: true, completion: nil)
            })
            
            // 더보기 액션 디자인
            moreAction.title = "더보기"
            moreAction.image = UIImage(systemName: "ellipsis.circle")
            moreAction.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            
            // 삭제 액션
            let deleteAction = SwipeAction(style: .destructive, title: nil, handler: { action, indexPath in
                print("삭제 액션")
                self.contentArray.remove(at: indexPath.row)
            })
            // 삭제 액션 디자인
            deleteAction.title = "지우기"
            deleteAction.image = UIImage(systemName: "trash.fill")
            deleteAction.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
 
            
            return [ deleteAction, moreAction, thumbsUpAction,]
        }
    }
    
    // 셀 액션 옵션 설정
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        
        options.expansionStyle = orientation == .left ? .selection : .destructive
        options.transitionStyle = .drag
        return options
    }
    
}

