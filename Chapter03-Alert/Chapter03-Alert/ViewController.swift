//
//  ViewController.swift
//  Chapter03-Alert
//
//  Created by Hamlit Jason on 2021/03/14.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let defaultAlertBtn = UIButton(type: .system) // 커스텀 버튼 만들고
        defaultAlertBtn.frame = CGRect(x: 0, y: 100, width: 100, height: 30)
        defaultAlertBtn.center.x = self.view.frame.width / 2 // 화면 중앙 정렬
        defaultAlertBtn.setTitle("기본알림창", for: .normal) // 버튼의 텍스트
        defaultAlertBtn.addTarget(self
                                  , action: #selector(defaultAlert(_:)), for: .touchUpInside) // IBAction과 동일한 코드
        self.view.addSubview(defaultAlertBtn) // 화면에 커스텀 버튼 추가
        
    }
    
    @objc func defaultAlert(_ sender : Any){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        // title - 기본메시지가 들어가는 곳이라는 메시지로 공간을 남겨두지만
        // message - 부분을 nil처리하면 아예 지워버린다. 즉, 공간 자체를 없앤다.
        // 액션시트로 바꾸어도 큰 차이는 없다.
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        let v = UIViewController()
        v.view.backgroundColor = .red
        alert.setValue(v, forKey: "contentViewController") // 알림창에 뷰 컨트롤러를 등록한다. 커스텀을 위한 코드로 속성의 이름과 값 순서에 주의하기.
        /* 짚고 넘어가자!!
         alert.setValue(v, forKey: "contentViewController")로 작성하는 이유는
         프라이빗 API이기 때문에 alert.contentViewController로 작성할 수 없다.
         
         */
        
        self.present(alert, animated: true, completion: nil)
    }


}

