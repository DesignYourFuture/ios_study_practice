//
//  ControlViewController.swift
//  Chapter03-Alert
//
//  Created by Hamlit Jason on 2021/03/15.
//

import UIKit
// 컨트롤도 커스터마이징할 수 있다
class ControlViewController : UIViewController {
    
    private let slider = UISlider() // 슬라이더 객체를 정의한다.
    var sliderValue : Float {
        // 플라이더 객체의 값을 읽어올 연산 프로퍼티
        return self.slider.value
    }
    
    
    override func viewDidLoad() {
        // 슬라이더의 최솟값 최댓값 설정
        self.slider.minimumValue = 0
        self.slider.maximumValue = 100
        
        self.slider.frame = CGRect(x: 0, y: 0, width: 170, height: 30)
        self.view.addSubview(self.slider)
        
        self.preferredContentSize = CGSize(width: self.slider.frame.width, height: self.slider.frame.height+10)
    }
}
