//
//  ImageViewController.swift
//  Chapter03-Alert
//
//  Created by Hamlit Jason on 2021/03/15.
//

import UIKit

class ImageViewController : UIViewController {
    
    override func viewDidLoad() {
        let icon = UIImage(named: "rating5")
        let iconV = UIImageView(image: icon)
        
        // 이미지 뷰의 영역과 위치를 지정
        iconV.frame = CGRect(x: 0, y: 0, width: (icon?.size.width)!, height: (icon?.size.height)!)
        self.view.addSubview(iconV)
        
        // 외부에서 참조할 뷰 컨트롤러 사이즈를 이미지 크기와 동일하게 설정
        self.preferredContentSize = CGSize(width: (icon?.size.width)!, height: (icon?.size.height)! + 10) // 이 속성을 통해 외부 객체가 ImageViewController를 나타낼 때, 참고할 사이즈를 정의한다. 간혹 이미지가 알림창을 모두 채울만큼 넓지 않은 경우 알림창에서 한쪽으로 치우친 모습으로 표현되고도 하는데 이를 하기 위해 이 속성에 이미지의 높이와 너비를 모두 설정해 주는 것이 좋습니다. 높이값을 지정할 때, 이미지 높이 + 10으로 처리하는 것은 알림창에 이미지가 표시될 때 이미지 아래에 여백을 주기 위한 것.
    }
    
}
