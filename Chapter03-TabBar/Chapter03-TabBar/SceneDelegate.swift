//
//  SceneDelegate.swift
//  Chapter03-TabBar
//
//  Created by Hamlit Jason on 2021/03/13.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        // 윈도우 중 루트 뷰 컨트롤러를 작성하는 이유는 이렇게 해야 탭바컨트롤러(이니시되는 부분)을 참조하는 것이기 때문이다.
        if let tbC = self.window?.rootViewController as? UITabBarController {
            if let tbItems = tbC.tabBar.items {
                //tbItems[0].image = UIImage(named: "calendar")
                //tbItems[1].image = UIImage(named: "file-tree")
                //tbItems[2].image = UIImage(named: "photo")
                /*
                 원본 그대로 사용하는 코드 렌더링 모드를 변경하는 구문임.
                 */
                tbItems[0].image = UIImage(named: "designbump")?.withRenderingMode(.alwaysOriginal)
                tbItems[1].image = UIImage(named: "rss")?.withRenderingMode(.alwaysOriginal)
                tbItems[2].image = UIImage(named: "facebook")?.withRenderingMode(.alwaysOriginal)
          
                tbItems[0].title = "calendar"
                tbItems[1].title = "file"
                tbItems[2].title = "photo"
                
                tbC.tabBar.tintColor = .white // 선택된 탭바
                tbC.tabBar.unselectedItemTintColor = .gray // 선택되지 않는 탭바
                tbC.tabBar.backgroundImage = UIImage(named: "menubar-bg-mini") // 탭바에 배경 이미지 설정
                /*
                 할당된 이미지가 배경 영역보다 작을 떄, 이미지는 모자란 공간만큼 반복해서 배치된다. menubar-bg-mini는 높이는 충분하나 width는 많이 부족해서 부족한 영역 반복해서 채움
                 */
                
                for tbItem in tbItems { // 탭 바 아이템 전체를 순회하면서 selectedImage 속성에 이미지를 설정한다. - 탭 바 이미지를 아예 교체하는 코드 (선택 되었을 때)
                    let image = UIImage(named: "checkmark")?.withRenderingMode(.alwaysOriginal)
                    tbItem.selectedImage = image
                    
                    // 탭 바 아이템 별 텍스트 색상 속성을 설정한다.
                    /*
                    tbItem.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .disabled)
                    tbItem.setTitleTextAttributes([.foregroundColor: UIColor.red], for: .selected)
                    tbItem.setTitleTextAttributes([.font : UIFont.systemFont(ofSize: 15)], for: .normal)
                     */
                }
                // 외형 프록시를 이용하여서도 똑같이 만들 수 있다.
                /*
                 appearance - 코코아 터치 프레임 워크에서는 요소별 속성을 공통으로 적용할 수 있는 객체를 제공함 - 따라서 전체 순회없이도 이렇게 해도 같은 효과 낼 수 있다.
                 */
                let tbItemProxy = UITabBarItem.appearance()
                tbItemProxy.setTitleTextAttributes([.foregroundColor: UIColor.red], for: .selected)
                tbItemProxy.setTitleTextAttributes([.foregroundColor: UIColor.red], for: .selected)
                tbItemProxy.setTitleTextAttributes([.font : UIFont.systemFont(ofSize: 15)], for: .normal)
                
                
            }
            
          
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

