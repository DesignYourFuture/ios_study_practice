//
//  ReadViewController.swift
//  Chapter02-InputForm
//
//  Created by Hamlit Jason on 2021/03/12.
//

import UIKit

// 화면 전환도 구현해보자.
class ReadViewController : UIViewController {
    var pEmail : String?
    var pUpdate : Bool?
    var pInterval : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white // 배경색상 설정 - 스토리보드 사용에는 사용할 일 없었으나 루트 뷰의 배경 색상 고려해줘야 해 안그러면 까맣게 보여
        
        let email = UILabel()
        let update = UILabel()
        let interval = UILabel()
        
        email.frame = CGRect(x: 50, y: 100, width: 300, height: 30)
        update.frame = CGRect(x: 50, y: 150, width: 300, height: 30)
        interval.frame = CGRect(x: 50, y: 200, width: 300, height: 30)
        
        // 전달받은 값을 레이블에 표시한다.
        email.text = "전달받은 이메일 : \(self.pEmail! )"
        update.text = "업데이트 여부 : \(self.pUpdate == true ? "업데이트 함" : "업데이트 안함")"
        interval.text = "업데이트 주기 : \(self.pInterval! )분 마다"
        
        // 레이블을 루트 뷰에 추가한다.
        self.view.addSubview(email)
        self.view.addSubview(update)
        self.view.addSubview(interval)
    
        
    }
}
