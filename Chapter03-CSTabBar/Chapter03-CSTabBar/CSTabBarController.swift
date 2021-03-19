//
//  CSTabBarController.swift
//  Chapter03-CSTabBar
//
//  Created by Hamlit Jason on 2021/03/18.
//

import UIKit

class CSTabBarController: UITabBarController {
    let csView = UIView()
    let tabItem01 = UIButton(type: .system)
    let tabItem02 = UIButton(type: .system)
    let tabItem03 = UIButton(type: .system)
    
    override func viewDidLoad() {
        self.tabBar.isHidden = true // 기존 탭바를 숨김 처리
        
        let width = self.view.frame.width // 뷰의 너비가 화면 전체의 너비와 같게 설정
        let height : CGFloat = 50 // 뷰의 높이 50
        let x: CGFloat = 0 // x좌표
        let y = self.view.frame.height - height // 뷰의 하단까지 빈공간 없이 채워지도록 화면 전체 높이에서 뷰의 높이를 뺀 만큼을 y좌표로 설정한다.
        
        // 정의된 값을 이용해 새로운 뷰의 속성을 설정
        self.csView.frame = CGRect(x: x, y: y, width: width, height: height)
        self.csView.backgroundColor = .brown
        
        self.view.addSubview(self.csView)
    
        // 버튼의 너비와 높이 설정
        let tabBtnWidth = self.csView.frame.size.width / 3
        let tabBtnHeight = self.csView.frame.height
        
        // 버튼의 영역을 차례로 설정
        self.tabItem01.frame = CGRect(x: 0, y: 0, width: tabBtnWidth, height: tabBtnHeight)
        self.tabItem02.frame = CGRect(x: tabBtnWidth, y: 0, width: tabBtnWidth, height: tabBtnHeight)
        self.tabItem03.frame = CGRect(x: tabBtnWidth * 2, y: 0, width: tabBtnWidth, height: tabBtnHeight)
        
        self.addTabBarBtn(btn: self.tabItem01, title: "첫 번째 버튼", tag: 0)
        self.addTabBarBtn(btn: self.tabItem02, title: "두 번째 버튼", tag: 1)
        self.addTabBarBtn(btn: self.tabItem03, title: "세 번째 버튼", tag: 2)
        
        self.onTabBarItemClick(self.tabItem01) // 처음에 첫 번째 탭이 선택되어 있도록 초기 상태를 정의해 준다.
        
    }
    
    // 버튼의 공통 속성을 정의하기 위한 메소드
    func addTabBarBtn(btn: UIButton, title: String, tag: Int){
        
        // 버튼의 타이틀과 태그값 입력
        btn.setTitle(title, for: .normal)
        btn.tag = tag // 버튼의 태그값을 주기
        
        // 버튼의 텍스트 색상을 일반 상태와 선택된 상태로 나누어 설정
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitleColor(UIColor.yellow, for: .selected)
        btn.addTarget(self, action: #selector(onTabBarItemClick(_:)), for: .touchUpInside)
        
        self.csView.addSubview(btn)
    }
    
    @objc func onTabBarItemClick(_ sender : UIButton){
        //모든 버튼을 선탠되지 않은 상태로 처리한다
        self.tabItem01.isSelected = false
        self.tabItem02.isSelected = false
        self.tabItem03.isSelected = false
        // 인자값으로 입력된 버튼만 선택된 상태로 변경한다.
        sender.isSelected = true
        
        self.selectedIndex = sender.tag // 버튼 클릭시 화면도 같이 바뀔 수 있게끔
    }
}

