//
//  ViewController.swift
//  Chapter03-TabBar
//
//  Created by Hamlit Jason on 2021/03/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let title = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 30))
        title.text = "첫번째 템"
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
        
        //self.tabBarItem.image = UIImage(named: "calendar.png")
        //self.tabBarItem.title = "Calendar"
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) { // 탭 바 숨기기 - 이 메소드는 UIRespond에 정의되어 있는데 UIViewController 상위 클래시라서 사용할 수 있다. - 화면에서 터치가 끝났을 떄 호출되는 메소드
        let tabBar = self.tabBarController?.tabBar // 탭바 컨트롤러의 탭바 객체 사용
        //tabBar?.isHidden = (tabBar?.isHidden == true) ? false : true // 숨겨져 있으면 false로 안 숨겨져 있으면 true로 - 근데 이 코드는 너무 딱딱해서 아래 코드로 대체해서 애니메이션 효과를 줌
        
        UIView.animate(withDuration: TimeInterval(0.15)) { // 인자값으로 초단위 사용 - 시간초 동안 중간과정은 코코아터치 프레임워크가 알아서 구현해줌 단, 알파속성에서만 적용가능
            // 알파값이 0이면 1로 1이면 0으로인데 호출될 때마다 투명해졌다가 점점 진해질 것이다
            
            tabBar?.alpha = ( tabBar?.alpha == 0 ? 1 : 0)
        }
    }


}

