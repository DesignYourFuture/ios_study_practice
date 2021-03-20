//
//  SideBarViewController.swift
//  Chapter04-SideBarDly
//
//  Created by Hamlit Jason on 2021/03/20.
//

import UIKit
class SideBarViewController : UITableViewController {
    
    let titles = [
        "menu 01",
        "menu 02",
        "menu 03",
        "menu 04",
        "menu 05"
    ]
    
    let icons = [
    UIImage(named: "icon01.png"),
    UIImage(named: "icon02.png"),
    UIImage(named: "icon03.png"),
    UIImage(named: "icon04.png"),
    UIImage(named: "icon05.png"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 계정 정보를 표시할 레이블 객체를 정의
        let accountLabel = UILabel()
        accountLabel.frame = CGRect(x: 10, y: 30, width: self.view.frame.width, height: 30)
        
        accountLabel.text = "lgvv9898@~~"
        accountLabel.textColor = .white
        accountLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        // 테이블 뷰 상단에 표시될 뷰를 정의
        let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70)
        v.backgroundColor = .brown
        v.addSubview(accountLabel)
        
        // 생성한 뷰 v를 테이블 헤더 뷰 영역에 등록
        self.tableView.tableHeaderView = v
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 재사용 큐로부터 테이블 셀을 꺼내 온다.
        let id = "menucell" // 재사용 큐에 등록할 식별자
        
        
        /* 아래의 코드로 대체할 수 있다.
         var cell = tableView.dequeueReusableCell(withIdentifier: id)
        // 재사용 큐에 menucell 키로 등록된 테이블 뷰 셀이 없다면 새로 추가한다.
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: id)
        }
        */
        
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        
        // 타이틀과 이미지를 대입한다.
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        
        // 폰트설정
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return cell
    }
}
