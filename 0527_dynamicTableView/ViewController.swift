//
//  ViewController.swift
//  0527_dynamicTableView
//
//  Created by 손대홍 on 2021/05/27.
//

import UIKit

class ViewController: UIViewController  {

    @IBOutlet weak var myTableView: UITableView!
    
    let contentArray: [String] = [
        "Contrary to popular belief, Lorem Ipsum is not simply random text. ",
        
        "It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.",
        
        "Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
        
        "Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC.",
        
        "This book is a treatise on the theory of ethics, very popular during the Renaissance.",
        
        "The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.",
        
        "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        // 셀 리소스 가져오기
        let myTableViewCellNib = UINib(nibName: String(describing: MyTableViewCell.self), bundle: nil)  // String(describing: MyTableViewCell.self)
        
        // 셀 리소스 등록¨
        self.myTableView.register(myTableViewCellNib, forCellReuseIdentifier: "myTableViewCell")
        
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
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myTableViewCell", for: indexPath) as! MyTableViewCell
        
        cell.userContentLabel.text = contentArray[indexPath.row]
        
        return cell
    }
}

