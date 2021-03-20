//
//  FrontViewController.swift
//  Chapter04-SideBarDly
//
//  Created by Hamlit Jason on 2021/03/20.
//

import UIKit
class FrontViewController : UIViewController {
    
    var delegate : RevealViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btnSiderBar = UIBarButtonItem(image: UIImage(named: "sidemenu.png"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(moveSide(_:))) // 사이드 바 오픈용 버튼 정의
    
        self.navigationItem.leftBarButtonItem = btnSiderBar // 버튼을 내비게이션 바의 왼쪽 영역에 추가
        
        // 화면 끝에서 다른 쪽으로 패닝하는 제스처를 정의
        let dragLeft = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(moveSide)) // 모서리를 사용해야 하니까 엣지
        dragLeft.edges = UIRectEdge.left // 시작 모서리는 왼쪽
        self.view.addGestureRecognizer(dragLeft) // 뷰에 제스처 객체를 등록
        
        // 화면을 스와이프 하는 제스처를 정의 사이드 메뉴 닫기용
        let dragRight = UISwipeGestureRecognizer(target: self, action: #selector(moveSide))
        dragRight.direction = .left // 방향은 왼쪽
        self.view.addGestureRecognizer(dragRight) // 뷰에 제스처 객체를 등록
    }
    
    @objc func moveSide(_ sender : Any){
        if sender is UIScreenEdgePanGestureRecognizer {
            self.delegate?.openSideBar(nil)
        } else if sender is UISwipeGestureRecognizer {
            self.delegate?.closeSideBar(nil)
        } else if sender is UIBarButtonItem {
            if self.delegate?.isSideBarShowing == false {
                self.delegate?.openSideBar(nil)
            } else {
                self.delegate?.closeSideBar(nil)
            }
        }
    }
}
