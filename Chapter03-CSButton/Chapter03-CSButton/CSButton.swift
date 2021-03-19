//
//  CSButton.swift
//  Chapter03-CSButton
//
//  Created by Hamlit Jason on 2021/03/18.
//

import UIKit

public enum CSButtonType {
    case rect
    case circle
}

class CSButton: UIButton {
    
    // required가 붙은 메소드는 필수 구현 메소드이다.
    required init(coder aDecoder: NSCoder) { // init구문은 스토리보드 방식으로 객체를 생성할 때 호출되는 초기화 메소드
        super.init(coder: aDecoder)!
    
        // 스토리보드 방식으로 버튼을 정의했을 때 정의된다.
        self.backgroundColor = .green // 배경을 녹색으로
        self.layer.borderWidth = 2 // 테두리는 조금 두껍게
        self.layer.borderColor = UIColor.black.cgColor // 테두리는 검은색
        self.setTitle("버튼", for: .normal) // 기본 문구 설정
    }
    
    override init(frame: CGRect){
        // 프로그래밍 방식으로 버튼 정의한 것 사용
        super.init(frame: frame)
        
        self.backgroundColor = .gray // 배경을 녹색으로
        self.layer.borderWidth = 2 // 테두리는 조금 두껍게
        self.layer.borderColor = UIColor.black.cgColor // 테두리는 검은색
        self.setTitle("코드로 생성된 버튼", for: .normal) // 기본 문구 설정
    }
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    convenience init(type: CSButtonType) {
        self.init()
        
        switch type {
        case .rect :
            self.backgroundColor = .black // 배경을 녹색으로
            self.layer.borderWidth = 2 // 테두리는 조금 두껍게
            self.layer.borderColor = UIColor.black.cgColor // 테두리는 검은색
            self.layer.cornerRadius = 0 // 모서리는 전혀 둥글지 않게
            self.setTitleColor(.white, for: .normal)
            self.setTitle("Rect 버튼", for: .normal) // 기본 문구 설정
        case .circle :
            self.backgroundColor = .red // 배경을 녹색으로
            self.layer.borderWidth = 2 // 테두리는 조금 두껍게
            self.layer.borderColor = UIColor.blue.cgColor // 테두리는 검은색
            self.layer.cornerRadius = 50
            self.setTitle("Circle 버튼", for: .normal) // 기본 문구 설정
        }
        self.addTarget(self,action: #selector(counting(_:)),for: .touchUpInside)
        
    }
    
    
    var style : CSButtonType = .rect{
        didSet{
            switch style {
            case .rect :
                self.backgroundColor = .black // 배경을 녹색으로
                self.layer.borderWidth = 2 // 테두리는 조금 두껍게
                self.layer.borderColor = UIColor.black.cgColor // 테두리는 검은색
                self.layer.cornerRadius = 0 // 모서리는 전혀 둥글지 않게
                self.setTitleColor(.white, for: .normal)
                self.setTitle("Rect 버튼", for: .normal) // 기본 문구 설정
            case .circle :
                self.backgroundColor = .red // 배경을 녹색으로
                self.layer.borderWidth = 2 // 테두리는 조금 두껍게
                self.layer.borderColor = UIColor.blue.cgColor // 테두리는 검은색
                self.layer.cornerRadius = 50
                self.setTitle("Circle 버튼", for: .normal) // 기본 문구 설정
            }
        }
    }
    
    @objc func counting(_ sender : UIButton) {
        sender.tag = sender.tag + 1 // 태그속성 사용함
        sender.setTitle("\(sender.tag) 번째 클릭", for: .normal)
    }
}
