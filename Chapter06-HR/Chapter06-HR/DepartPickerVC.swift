//
//  DepartPickerVC.swift
//  Chapter06-HR
//
//  Created by Hamlit Jason on 2021/04/02.
//

import UIKit

class DepartPickerVC : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate { // 멤버 변수와 메소드가 작성될 영역
    
    let departDAO = DepartmentDAO() // DAO 객체
    var departList : [(departCd: Int, departTitle: String, departAddr: String)]! // 피커 뷰의 데이터 소스
    
    var pickerView: UIPickerView! // 피커 뷰 객체
    
    
    var selectedDepartCd : Int { // 현재 피커 뷰에 선택되어 있는 부서의 코드를 가져온다.
        let row = self.pickerView.selectedRow(inComponent: 0)
        return self.departList[row].departCd
    }
    
    override func viewDidLoad() {
        self.departList = self.departDAO.find() // 데베에서 부서 목록을 가져와 튜플 배열을 초기화 한다.
        
        
        // 피커 뷰 객체를 초기화하고, 최상위 서브 뷰로 추가한다
        self.pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.view.addSubview(self.pickerView)
        
        // 외부에서 뷰 컨트롤러를 참조할 때를 위한 사이즈를 지정한다.
        let pWidth = self.pickerView.frame.width
        let pHeight = self.pickerView.frame.height
        self.preferredContentSize = CGSize(width: pWidth, height: pHeight)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // 피커 뷰에 표시될 전체 컴포넌트 갯수
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.departList.count // 특정 컴포넌트의 행의 수
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        // 피커 뷰 각 행에 표시될 타이틀을 지정하는 메소드를 구현한다
        /*
         pickerView(_:titleForRow:forComponent:) 와 다른데 이 메소드는 문자열 속성을 설정할 수 없다
         근데 지금 내가 여기서 사용한 메소드는 UIView 나 UIImage 등 어떤 것이든 반환 가능
         또한 재사용 메커니즘과 비슷하게 사용하는데 메소드 호출 시 매개변수를 통해 전단된다는 특징이 있다. - 객체를 직접관리하진 않음
         */
        
        var titleView = view as? UILabel
        if titleView == nil {
            titleView = UILabel()
            titleView?.font = UIFont.systemFont(ofSize: 14)
            titleView?.textAlignment = .center
        }
        
        titleView?.text = "\(self.departList[row].departTitle) (\(self.departList[row].departAddr))"
        return titleView!
    }
}
