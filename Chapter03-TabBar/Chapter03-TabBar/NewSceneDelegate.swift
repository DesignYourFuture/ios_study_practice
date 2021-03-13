//
//  NewSceneDelegate.swift
//  Chapter03-TabBar
//
//  Created by Hamlit Jason on 2021/03/13.
//

import UIKit

 /*
 이번에는 스토리보드를 사용하지 않고 프로그래밍 방식으로 탭 바 컨트롤러를 직접 추가해 보기.
 이렇게 하는 이유는 이전에 작성했던 씬 델리게이트를 덜어내야하기 때문에,
 학습을 위해 작성한 코드를 지우기 좀 그러니까 새로운 씬을 만들어서 공부하도록 하자
 */

/*
 새로운 클래스가 씬 델리게이트 역할을 하기 위해서는 몇 가지 기본 조건을 만족해야 한다.
 UIResponder을 상속받고 UIWindowSceneDelegate 프로토콜을 구현해야 한다.
 UI 라이프사이클을 관리하기 위해 필요한 메소드들이 UIWindowSceneDelegate 프로토콜에 정의되어 있기 때문
 또한 씬 델리게이트에는 UIWindow 타입의 변수가 정의되어 있어야 한다.
 그리고 그 변수의 이름은 반드시!! window여야 한다.
 앱이 실행될 떄 씬 델리게이트 클래스는 스토리보드파일을 읽어와 윈도우 객체를 생성하는데, 이 객체를 씬 델리게이트 내의 변수 window에 저장하도록 프로그래밍되어이 있기 때문입니다.
 참고로, 프로젝트 설정에서 스토리보드 파일을 아예 사용하지 않도록 설정한다면 굳이 window 변수를 정의하지 않아도 됩니다. 물론 이를 대신할 윈도우 객체를따로 만들어야 한다.
 
 마지막 조건은 씬 델리게이트 클래스를 프로젝트에 등록해주어야 한다는 것.
 등록과정은 간단 - info.plist 파일에 delegate class name 에서 신 델리게이트 부분을 새로운 클래스 명으로 바꿔주기. 누락할 경우 모든 조건을 만족해도 인식되지 않는다.
 */
class NewSceneDelegate : UIResponder, UIWindowSceneDelegate {
    var window : UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session : UISceneSession, options connectionOptions : UIScene.ConnectionOptions) {
        
        // 탭바 컨트롤러를 생성 후 배경을 흰색으로
        let tbC = UITabBarController()
        tbC.view.backgroundColor = .white
        
        // 생성된 tbC를 루트 뷰 컨트롤러로 등록한다
        self.window?.rootViewController = tbC
        
        // 탭 바 아이템에 연결될 뷰 컨트롤러 객체를 생성한다
        let view01 = ViewController()
        let view02 = SecondViewController()
        let view03 = ThirdViewController()
        
        // 생성된 뷰 아이템에 연결될 뷰 컨트롤러 객체를 생성한다.
        tbC.setViewControllers([view01,view02,view03], animated: false)
        
        // 개별 탭 바 아이템 속성을 설정한다.
        view01.tabBarItem = UITabBarItem(title: "Calendar", image: UIImage(named: "calendar"), selectedImage: nil)
        view02.tabBarItem = UITabBarItem(title: "File", image: UIImage(named: "file-tree"), selectedImage: nil)
        view03.tabBarItem = UITabBarItem(title: "Photo", image: UIImage(named: "photo"), selectedImage: nil)
    }
}
