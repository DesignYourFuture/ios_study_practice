//
//  ViewController.swift
//  Chapter02-InputForm
//
//  Created by Hamlit Jason on 2021/03/12.
//

import UIKit

class ViewController: UIViewController {

    var paramEmail : UITextField! // 이메일 입력 필드
    var paramUpdate : UISwitch!// 스위치 객체
    var paramInterval : UIStepper! // 스텝퍼 객체
    
    var txtUpdate : UILabel! // 스위치 컨트롤의 값을 표현할 레이블
    var txtInterval : UILabel! // 스테퍼 컨트롤의 값을 표현할 레이블
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "설정" // 네비게이션 아이템은 네비게이션 뷰 컨트롤러 사용시, 화면에 자동으로 임베딩 되어서 따로 변수 설정할 필요가 없다.
        
        let lblEmail = UILabel()
        lblEmail.frame = CGRect(x: 30, y: 100, width: 100, height: 30)
        lblEmail.text = "이메일"
        lblEmail.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(lblEmail)
        
        
        let lblUpdate = UILabel()
        lblUpdate.frame = CGRect(x: 30, y: 150, width: 100, height: 30)
        lblUpdate.text = "자동갱신"
        lblUpdate.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(lblUpdate)
        
        
        let lblInterval = UILabel()
        lblInterval.frame = CGRect(x: 30, y: 200, width: 100, height: 30)
        lblInterval.text = "갱신주기"
        lblInterval.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(lblInterval)
        
        self.paramEmail = UITextField()
        self.paramEmail.frame = CGRect(x: 120, y: 100, width: 220, height: 30)
        self.paramEmail.font = UIFont.systemFont(ofSize: 13)
        self.paramEmail.borderStyle = .roundedRect
        self.paramEmail.autocapitalizationType = .none // 대문자 자동 변환 기능을 헤제하는 구문
        self.view.addSubview(self.paramEmail)
        
        
        self.paramUpdate = UISwitch()
        self.paramUpdate.frame = CGRect(x: 120, y: 150, width: 50, height: 30)
        self.paramUpdate.setOn(true, animated: true)
        self.view.addSubview(self.paramUpdate)
        
        self.paramInterval = UIStepper()
        self.paramInterval.frame = CGRect(x: 120, y: 200, width: 50, height: 30)
        self.paramInterval.minimumValue = 0 // 스테퍼의 최솟값
        self.paramInterval.maximumValue = 100 // 스테퍼의 최댓값
        self.paramInterval.stepValue = 1 // 스테퍼의 값 변경 단위
        self.paramInterval.value = 0 // 초기값
        self.view.addSubview(paramInterval)
        
        self.txtUpdate = UILabel()
        self.txtUpdate.frame = CGRect(x: 250, y: 150, width: 100, height: 30)
        self.txtUpdate.font = UIFont.systemFont(ofSize: 12)
        self.txtUpdate.text = "갱신함" // 1. 갱신함 2. 갱신하지 않음
        self.view.addSubview(txtUpdate)
        
        self.txtInterval = UILabel()
        self.txtInterval.frame = CGRect(x: 250, y: 200, width: 100, height: 30)
        self.txtInterval.font = UIFont.systemFont(ofSize: 12)
        self.txtInterval.textColor = UIColor.red
        self.txtInterval.text = "0분마다"
        self.view.addSubview(self.txtInterval)
        
        
        // 스위치와 스테퍼 컨트롤의 value changed 이벤트를 각각 액션 메소드에 연결한다.
        self.paramUpdate.addTarget(self, action: #selector(presentUpdateValue(_:)), for: .valueChanged)
        self.paramInterval.addTarget(self, action: #selector(presentIntervalValue(_:)), for: .valueChanged)
        
        // 전송 버튼을 내비게이션 아이템에 추가하고, submit 메소드에 연결한다.
        let submitBtn = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(submit(_:)))
        self.navigationItem.rightBarButtonItem = submitBtn
    }
    
    // 스위치와 상호반응할 액션 메소드
    @objc func presentUpdateValue(_ sender : UISwitch){
        self.txtUpdate.text = (sender.isOn == true ? "갱신함" : "갱신하지 않음")
    }
    @objc func presentIntervalValue(_ sender : UIStepper){
        self.txtInterval.text = ("\( Int(sender.value) ) 분마다")
    }
    @objc func submit(_ sender : Any) {
        let rvc = ReadViewController() // 전달할 컨트롤러의 인스턴스 생성해서 전달해주기.
        rvc.pEmail = self.paramEmail.text
        rvc.pUpdate = self.paramUpdate.isOn
        rvc.pInterval = self.paramInterval.value
        
        self.navigationController?.pushViewController(rvc, animated: true) // 화면전환
    }

}

