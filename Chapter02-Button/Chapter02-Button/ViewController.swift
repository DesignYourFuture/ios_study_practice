//
//  ViewController.swift
//  Chapter02-Button
//
//  Created by Hamlit Jason on 2021/03/12.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 버튼 객체 생성하고, 속성을 설정
        let btn = UIButton(type: .system)
        btn.frame = CGRect(x:50, y:100, width: 150, height: 30)
        btn.setTitle("테스트 버튼",for: .normal)
        
        btn.center = CGPoint(x: self.view.frame.size.width / 2, y: 100) // 버튼을 수평 중앙 정렬한다. 이 구문은 무조건 frame 구문보다 아래에 있어야 하는데 그 이유는 센터 후 프레임 구문 작성 시, 좌측 상단 꼭짓점의 좌표로 최종 결정되서 그럼.
        
        self.view.addSubview(btn) // 루트 뷰에 버튼을 추가한다.
        
        btn.addTarget(self, action: #selector(btnOnClick(_:)), for: .touchUpInside) // 버튼의 이벤트와 메소드 연결한다.
    }
    
    @objc func btnOnClick(_ sender : Any){
        // 호출한 객체가 버튼이면
        if let btn = sender as? UIButton {
            btn.setTitle("클릭되었습니다", for: .normal)
        }
    }
    
    /*
     @objc func btnOnClick(_ sender : UIButton){
         // 캐스팅 할 필요 없다
             btn.setTitle("클릭되었습니다", for: .normal)
       
     }
     */



}

