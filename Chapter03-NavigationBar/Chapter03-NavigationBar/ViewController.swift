//
//  ViewController.swift
//  Chapter03-NavigationBar
//
//  Created by Hamlit Jason on 2021/03/14.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.initTitle()
        //self.initTitleNew()
        //self.initTitleImage()
        self.initTitleInput()
    }

    func initTitle() {
        let nTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        nTitle.numberOfLines = 2
        nTitle.textAlignment = .center
        nTitle.font = UIFont.systemFont(ofSize: 15)
        nTitle.text = "58개 숙소 \n 1박(1월 10일 ~ 1월 11일)"
        
        self.navigationItem.titleView = nTitle
    
        let color = UIColor(red: 0.02, green: 0.22, blue: 0.49, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = color
    }
    
    func initTitleNew() {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 36)) // 하나의 큰 컨테이너 뷰를 만들어서 이 컨테이너 뷰에 레이블을 추가한다.
        
        let topTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 18))
        topTitle.numberOfLines = 1
        topTitle.textAlignment = .center
        topTitle.font = UIFont.systemFont(ofSize: 15)
        topTitle.text = "58개 숙소"
       
        let subTitle = UILabel(frame: CGRect(x: 0, y: 18, width: 200, height: 18))
        subTitle.numberOfLines = 1
        subTitle.textAlignment = .center
        subTitle.font = UIFont.systemFont(ofSize: 12)
        subTitle.text = "1박(1월 10일 ~ 1월 11일)"
        
        containerView.addSubview(topTitle)
        containerView.addSubview(subTitle)
     
        self.navigationItem.titleView = containerView
    
        let color = UIColor(red: 0.02, green: 0.22, blue: 0.49, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = color
    }
    
    func initTitleImage() {
        /*
         이미지 뒤의 @2x @3x의 의미는 동일한 크기로 출력되지만 해상도는 훨씬 높아서 더 선명한 이미지를 제공한다.
         */
        let image = UIImage(named: "swift_logo")
        let imageV = UIImageView(image: image)
        
        self.navigationItem.titleView = imageV
    }
    
    func initTitleInput(){
        let tf = UITextField()
        tf.frame = CGRect(x: 0, y: 0, width: 300, height: 120)
        tf.backgroundColor = .white
        tf.font = UIFont.systemFont(ofSize: 13)
        tf.autocapitalizationType = .none // 자동 대문자 변환 사용 안함
        tf.autocorrectionType = .no // 자동 입력 기능 헤제
        tf.spellCheckingType = .no // 스펠링 체크 기능 헤제
        tf.keyboardType = .URL // URL 전용 키보드
        tf.keyboardAppearance = .dark
        tf.layer.borderWidth = 0.3 // 테두리 경계선 두께
        tf.layer.borderColor = UIColor(red: 0.6, green: 0.60, blue: 0.6, alpha: 1.0).cgColor
    
        // 타이틀 뷰 속성에 대입
        self.navigationItem.titleView = tf
        
        
        let back = UIImage(named: "arrow-back")
        let leftItem = UIBarButtonItem(image: back, style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = leftItem
        
        
        // 오른쪽은 레이블과 아이템 2개가 들어가야해서 컨테이너 방식으로 사용해야함.
        let rv = UIView()
        rv.frame = CGRect(x: 0, y: 0, width: 70, height: 37) // 뷰공간 확보
        
        let rItem = UIBarButtonItem(customView: rv) // 오른쪽에 컨테이너 뷰 넣을건데
        self.navigationItem.rightBarButtonItem = rItem
        
        // 카운트 값을 표시할 레이블
        let cnt = UILabel()
        cnt.frame = CGRect(x: 10, y: 8, width: 20, height: 20)
        cnt.font = UIFont.boldSystemFont(ofSize: 10)
        cnt.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        cnt.text = "12"
        cnt.textAlignment = .center
        
        // 외곽선
        cnt.layer.cornerRadius = 3 // 모서리 둥글게 처리
        cnt.layer.borderWidth = 2
        cnt.layer.borderColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0).cgColor
        
        rv.addSubview(cnt) // 레이블을 서브뷰로 추가
        
        // more 버튼 구현
        let more = UIButton(type: .system)
        more.frame = CGRect(x: 50, y: 10, width: 16, height: 16)
        more.setImage(UIImage(named: "more"), for: .normal)
        
        rv.addSubview(more)
        
        /*
        let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: 150, height: 37)
        v.backgroundColor = .brown
        let leftItem = UIBarButtonItem(customView: v)
        self.navigationItem.leftBarButtonItem = leftItem
        
        let rv = UIView()
        rv.frame = CGRect(x: 0, y: 0, width: 100, height: 37)
        rv.backgroundColor = .red
        
        let rightItem = UIBarButtonItem(customView: rv)
        self.navigationItem.rightBarButtonItem = rightItem
         */
    }
    
    
    

}

