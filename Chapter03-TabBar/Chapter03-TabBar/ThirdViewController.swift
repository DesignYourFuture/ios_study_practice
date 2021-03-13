//
//  ThirdViewController.swift
//  Chapter03-TabBar
//
//  Created by Hamlit Jason on 2021/03/13.
//

import UIKit

class ThirdViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 30))
        title.text = "세번째 템"
        title.textColor = .red
        title.textAlignment = .center // 레이블 내에서 중앙으로
        title.font = UIFont.boldSystemFont(ofSize: 14) // 폰트는 시스템 폰트 사이즈는 14
        /* 사이즈 투핏 - 센터 맞추기
         이 순서로 코드를 작성해야하는데 둘이 순서가 바뀌면
         센터를 맞춘 후 사이즈 맞춰서 오른쪽으로 치우치는 현상 발생 가능
         */
        title.sizeToFit() // 콘텐츠 내용에 맞게 레이블크기 변경 - 엘립시스 처리 방지
        title.center.x = self.view.frame.width / 2 // x축의 중앙에 오도록
        self.view.addSubview(title)
        
        //self.tabBarItem.image = UIImage(named: "photo.png")
        //self.tabBarItem.title = "Photo"
    }
}
