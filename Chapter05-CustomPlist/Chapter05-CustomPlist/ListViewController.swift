//
//  ListViewController.swift
//  Chapter05-CustomPlist
//
//  Created by Hamlit Jason on 2021/03/27.
//

import UIKit

class ListViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var married: UISwitch!
    
    var defaultPList : NSDictionary! // 메인 번들에 정의된 plist 내용을 저장할 딕셔너리
    
    
    var accountlist = [String]()
    /*var accountlist = ["lgvv.com",
    "9898.com",
    "abc1.com",
    "abc2.com",
    "abc3.com"]
    */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // 생성할 컴포넌트 갯수 정의
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // 저장된 컴포넌트의 개수를 정의
        return self.accountlist.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // 지정된 컴포넌트의 목록 각 행에 출력될 내용을 정의
        return self.accountlist[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //지정된 컴포넌트의 목록 각 행을 사용자가 선택했을 때 실행할 액션을 정의한다
        let account = self.accountlist[row] // 선택된 계정
        self.account.text = account
        
        
        // 사용자가 계정을 생성하면 이 계정을 선택한 것으로 간주하고 저장
        let plist = UserDefaults.standard
        plist.set(account,forKey: "selectedAccount")
        plist.synchronize()
        //self.view.endEditing(true) // 입력 뷰를 닫음
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 1 && !(self.account.text?.isEmpty)!{ // 계정 정보가 비어 있지 않을 때에만
            let alert = UIAlertController(title: nil, message: "이름을 입력하세요.", preferredStyle: .alert)
            
            alert.addTextField() {
                $0.text = self.name.text
            }
           
            alert.addAction(UIAlertAction(title: "OK", style: .default){ (_) in
                
                let value = alert.textFields?[0].text
 
                let customPlist = "\(self.account.text!).plist"
                
                let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                let path = paths[0] as NSString
                let plist = path.strings(byAppendingPaths: [customPlist]).first!
                let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary(dictionary : self.defaultPList)
                
                data.setValue(value, forKey: "name")
                data.write(toFile: plist, atomically: true)
                //let plist = UserDefaults.standard // 기본 저장소 객체를 가져온다
                //plist.set(value,forKey: "name") // 키의 이름을 정해 값을 저장한다
                //plist.synchronize() // 동기화 처리
                
                self.name.text = value
        })
            self.present(alert, animated: false, completion: nil)
           
        }
    }
    
    
    @IBOutlet weak var account: UITextField!
   
    override func viewDidLoad() {
        let picker = UIPickerView()
        
        picker.delegate = self // 피커 뷰의 델리게이트 객체 지정
        self.account.inputView = picker// account 텍스트 필드 입력 방식을 가상 키보드 대신 피커 뷰로 설정
        
        // 툴바 객체 정의
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 35)
        toolbar.barTintColor = .lightGray
        
        self.account.inputAccessoryView = toolbar // 액세서리 뷰 영역에 툴바 표시
        
        // 툴 바에 들어갈 닫기 버튼
        let done = UIBarButtonItem()
        done.title = "Done"
        done.target = self
        done.action = #selector(pickerDone)
        
        // 가변 폭 버튼 정의
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        // 툴 바에 들어갈 닫기 버튼
        let new = UIBarButtonItem()
        new.title = "New"
        new.target = self
        new.action = #selector(newAccount(_:))
        
        
        toolbar.setItems([new,flexSpace,done], animated: true) // 버튼을 툴 바에 추가
        
        let plist = UserDefaults.standard
        
        self.name.text = plist.string(forKey: "name")
        self.married.isOn = plist.bool(forKey: "married")
        self.gender.selectedSegmentIndex = plist.integer(forKey: "gender")
        
        let accountlist = plist.array(forKey: "accountlist") as? [String] ?? [String]()
        self.accountlist = accountlist
        
        if let account = plist.string(forKey: "selectedAccount") {
            self.account.text = account
            
            let customPlist = "\(account).plist"
            
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            
            let path = paths[0] as NSString
            let clist = path.strings(byAppendingPaths: [customPlist]).first!
            let data = NSMutableDictionary(contentsOfFile: clist)
           
            self.name.text = data?["name"] as? String
            self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0
            self.married.isOn = data?["married"] as? Bool ?? false
        }
        
        if (self.account.text?.isEmpty)! { // 사용자 계정의 값이 비어 있다면 설정하는 것을 막는다.
            self.account.placeholder = " 등록된 계정이 없습니다. "
            self.gender.isEnabled = false
            self.married.isEnabled = false
        }
        
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newAccount(_:)))
        self.navigationItem.rightBarButtonItems = [addBtn]
        
        // 메인 번들에 UserInfo.plist가 포함되어 있으면 이를 읽어와 딕셔너리에 담는다
        if let defaultPListPath = Bundle.main.path(forResource: "UserInfo", ofType: "plist") { // 파라미터 : 파일이름 매개변수의 확장자
            self.defaultPList = NSDictionary(contentsOfFile: defaultPListPath)
        }
        
    }
    
    @IBAction func changeGender(_ sender: UISegmentedControl) {
        let value = sender.selectedSegmentIndex
        
        //let plist = UserDefaults.standard // 기본 저장소 객체를 가져온다
        //plist.set(value,forKey: "gender") // 키의 이름을 정해 값을 저장한다
        //plist.synchronize() // 동기화 처리
        
        let customPlist = "\(self.account.text!).plist"
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = paths[0] as NSString
        let plist = path.strings(byAppendingPaths: [customPlist]).first!
        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary(dictionary : self.defaultPList)
        
        data.setValue(value, forKey: "gender")
        data.write(toFile: plist, atomically: true)
    }
    
    @IBAction func changeMarried(_ sender: UISwitch) {
        let value = sender.isOn
        
        //let plist = UserDefaults.standard // 기본 저장소 객체를 가져온다
        //plist.set(value,forKey: "married") // 키의 이름을 정해 값을 저장한다
        //plist.synchronize() // 동기화 처리
    
        let customPlist = "\(self.account.text!).plist"
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = paths[0] as NSString
        let plist = path.strings(byAppendingPaths: [customPlist]).first!
        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary(dictionary : self.defaultPList)
        
        data.setValue(value, forKey: "married")
        data.write(toFile: plist, atomically: true)
        
        print("custom plist = \(plist)")
    }
    
    
    
    @objc func pickerDone(_ sender : Any){
        self.view.endEditing(true)
        
        if let _account = self.account.text {
            let customPlist = "\(_account).plist"
            
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let path = paths[0] as NSString
            let clist = path.strings(byAppendingPaths: [customPlist]).first!
            let data = NSDictionary(contentsOfFile: clist)
            
            self.name.text = data?["name"] as? String
            self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0
            self.married.isOn = data?["married"] as? Bool ?? false
        }
    }
    /*
    @objc func newAccount(_ sender : Any){
        self.view.endEditing(true) // 열려 있는 입력 뷰 먼저 닫아준다.
        
        let alert = UIAlertController(title: "새 계정을 입력하세요", message: nil, preferredStyle: .alert)
        
        alert.addTextField() {
            $0.placeholder = "ex) abc.titttttt.cccoomm"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default){ (_) in
            if let account = alert.textFields?[0].text {
                self.accountlist.append(account)
                self.account.text = account
                
                // 컨트롤 값 초기화
                self.name.text = ""
                self.gender.selectedSegmentIndex = 0
                self.married.isOn = false
                
                let plist = UserDefaults.standard
                plist.set(self.accountlist,forKey: "accountlist")
                plist.set(account, forKey: "selectedAccoint") // 추가된 구문
                plist.synchronize()
            }
            
            self.present(alert, animated: false, completion: nil)
        })
        
        self.present(alert, animated: false, completion: nil)// 프레젠트가 2번 있어서 결국 오류가 난듯...
        
    }*/
    
    @objc func newAccount(_ sender: Any) {
      self.view.endEditing(true) // 일단 열려있는 입력용 뷰부터 닫아준다.
      // 알림창 객체 생성
      let alert = UIAlertController(title: "새 계정을 입력하세요", message: nil,
                                    preferredStyle: .alert)
      // 입력폼 추가
      alert.addTextField() {
        $0.placeholder = "ex) abc@gmail.com"
      }
      // 버튼 및 액션 정의
      alert.addAction(UIAlertAction(title: "OK", style: .default) { (_) in
        if let account = alert.textFields?[0].text {
          // 계정 목록 배열에 추가한다.
          self.accountlist.append(account)
          // 계정 텍스트 필드에 표시한다.
          self.account.text = account
          
          // 컨트롤 값을 모두 초기화한다.
          self.name.text = ""
          self.gender.selectedSegmentIndex = 0
          self.married.isOn = false
          
          // 계정 목록을 통째로 저장한다.
          let plist = UserDefaults.standard
          
          plist.set(self.accountlist, forKey: "accountlist")
          plist.set(account, forKey: "selectedAccount")
          plist.synchronize()
          
          // STEP 3) 입력 항목을 활성화한다.
          self.gender.isEnabled = true
          self.married.isEnabled = true
        }
      })
      // 알림창 오픈
      self.present(alert, animated: false, completion: nil)
    }
}
