//
//  ListViewController.swift
//  Chapter05-UserDefaults
//
//  Created by Hamlit Jason on 2021/03/26.
//

import UIKit

class ListViewController : UITableViewController {
    
    @IBOutlet var name: UILabel!
    @IBOutlet var gender: UISegmentedControl!
    @IBOutlet var married: UISwitch!
    
 
    @IBAction func edit(_ sender: Any) { // 레이블에 탭 제스쳐 연결하고 도커바에서 액션 연결함
        let alert = UIAlertController(title: nil, message: "이름을 입력하세요.", preferredStyle: .alert)
        
        alert.addTextField() {
            $0.text = self.name.text
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default){ (_) in
            let value = alert.textFields?[0].text
            
            let plist = UserDefaults.standard
            plist.setValue(value, forKey: "name")
            plist.synchronize()
            
            self.name.text = value
        })
        self.present(alert, animated: false, completion: nil)
        
        
    }
    
    override func viewDidLoad() {
        
        // 앱을 껐다가 켜도 저장소에 들어가 있는 값을 불러오기 위함
        let plist = UserDefaults.standard
        
        self.name.text = plist.string(forKey: "name")
        self.married.isOn = plist.bool(forKey: "married")
        self.gender.selectedSegmentIndex = plist.integer(forKey: "gender")
    }
    
    
    @IBAction func changeGender(_ sender: UISegmentedControl) {
        let value = sender.selectedSegmentIndex // 0 이면 남자 1이면 여자
        
        let plist = UserDefaults.standard // 기본 저장소 객체 가져온다
        plist.set(value, forKey: "gender") // 젠더라는 키로 저장한다
        plist.synchronize() // 동기화 처리
    }
    
    @IBAction func changeMarried(_ sender: UISwitch) {
        let value = sender.isOn // 참이면 기혼, 거짓이면 미혼
        
        let plist = UserDefaults.standard
        plist.set(value, forKey: "married") // 젠더라는 키로 저장한다
        plist.synchronize() // 동기화 처리
    }
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let alert = UIAlertController(title: nil, message: "메시지를 입력하세요.", preferredStyle: .alert) // 입력이 가능한 알림창을 띄워 이름을 수정할 수 있도록 한다
            
            alert.addTextField() {
                $0.text = self.name.text // name 레이블의 텍스트를 입력폼에 기본 값을 넣어준다
            }
            
            alert.addAction(UIAlertAction(title: "OK", style: .default){
                (_) in
                // 사용자가 ok버튼을 누르면 입력 필드에 입력된 값을 지정한다.
                
                let value = alert.textFields?[0].text
                
                let plist = UserDefaults.standard
                plist.setValue(value, forKey: "name")
                plist.synchronize() // 동기화 처리 필수
                
                self.name.text = value // 수정된 값을 이름 레이블에도 적용ㅎ나다.
            })
            
            self.present(alert, animated: false, completion: nil) // 알림창을 띄운다.
            
        }
     
    }*/
}
