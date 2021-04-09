//
//  ListVC.swift
//  Chapter07-CoreData
//
//  Created by Hamlit Jason on 2021/04/05.
//

import UIKit
import CoreData

class ListVC : UITableViewController {
    
    lazy var list : [NSManagedObject] = { // 데이터 소스 역할을 할 배열 변수
        return self.fetch()
    }()
    
    func fetch() -> [NSManagedObject]{ // 데이터를 읽어올 메소드
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // 앱 델리게이트 객체 참조
        
        let context = appDelegate.persistentContainer.viewContext // 관리 객체 컨텍스트 참조
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Board") // 요청 객체 생성
        
        // 정렬 속성 설정 - 파라미터 키 : 정렬기준칼럼, 뒤에는 오름차순 여부
        let sort = NSSortDescriptor(key: "regdate", ascending: false) // 등록 날짜 기준으로 내림차순으로 정렬되도록 객체를 생성한 다음 fetchRequset 속성에 대입
        fetchRequest.sortDescriptors = [sort]
        
        let result = try! context.fetch(fetchRequest) // 데이터 가져오기
        return result
    }
    
    func save(title : String, contents: String) -> Bool { // 데이터를 저장할 메소드
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // 앱 델리게이트 객체 참조
        
        let context = appDelegate.persistentContainer.viewContext // 관리 객체 컨텍스트 참조
        
        let object = NSEntityDescription.insertNewObject(forEntityName: "Board", into: context) // 관리 객체 생성 및 값을 설정
        
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(Date(), forKey: "regdate")
        
        // 로그 관리 객체 생성 및 어트리뷰트 값 대입
        let logObject = NSEntityDescription.insertNewObject(forEntityName: "Log", into: context) as! LogMO
        logObject.regdate = Date()
        logObject.type = LogType.create.rawValue
        // 게시글 객체의 logs 속성에 새로 생성된 로그 객체 추가
        (object as! BoardMO).addToLogs(logObject)
        
        // 영구 저장소에 커밋되고 나면 list 프로퍼티에 추가된다.
        do {
            try context.save()
            self.list.insert(object, at: 0) // 새 게시글 등록시 self.list 배열에 0번 인덱스에 삽입되도록 코드를 수정
            //self.list.append(object) // 성공하면 배열에도 추가하여 굳이 데이터를 읽어오지 않도록 처리
            return true
        } catch {
            context.rollback() // 동기화에 실패했을 경우에 대한 rollback() 메소드 호출 마지막 동기화 시점 이후의 모든 변경 내용을 원래대로 되돌리는 역할을 한다.
            return false
        }
        
    }
    
    
    override func viewDidLoad() { // 화면 및 로직 초기화 메소드
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add(_:)))
        
        self.navigationItem.rightBarButtonItem = addBtn
    }
    
    @objc func add(_ sender : Any) {
        let alert = UIAlertController(title: "게시글 등록", message: nil, preferredStyle: .alert)
        
        // 입력 필드 추가(이름 및 전화번호) $0는 클로저 축약형으로 매개변수를 생략하는 대신 $0, $1 등으로 사용할 수 있다.
        alert.addTextField(){ $0.placeholder = "제목"}
        alert.addTextField(){ $0.placeholder = "내용"}
        
        // 버튼 추가(취소 및 저장)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in
            guard let title = alert.textFields?.first?.text, let contents = alert.textFields?.last?.text else {
                return
            }
            // 값을 저장하는 메소드를 호출하고, 성공이면 테이블 뷰를 리로드한다.
            if self.save(title: title, contents: contents) == true {
                self.tableView.reloadData()
            }
        })) // end of alert.addAction(...
        
        self.present(alert,animated: false)
        
        
    }
    
    func delete(object : NSManagedObject) -> Bool {
        // 삭제는 투스텝 - 컨텍스트에서 해당 데이터 삭제 후 동기화(저장)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // 앱 델리게이트 객체 참조
        
        let context = appDelegate.persistentContainer.viewContext // 관리 객체 컨텍스트 참조
        
        context.delete(object) // 컨텍스트에서 해당 데이터 삭제
        
        do {
            try context.save() // 동기화
            return true
        } catch {
            context.rollback()
            return false
        }
    }
    
    override func tableView(_ tv: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tv: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 해당하는 셀 가져오기
        let record = self.list[indexPath.row]
        let title = record.value(forKey: "title") as? String
        let contents = record.value(forKey: "contents") as? String
        
        // 셀을 생성하고, 값을 대입한다.
        let cell = tv.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = contents
        
        return cell
    
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let object = self.list[indexPath.row] // 삭제할 대상 객체
        
        if self.delete(object: object) {
            // 코어 데이터에서 삭제되고 나면 배열 목록과 테이블 뷰의 행도 삭제한다.
            self.list.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func edit(object:NSManagedObject, title: String, contents: String) -> Bool { // 데이터 수정 처리를 담당할 메소드 구현
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // 앱 델리게이트 객체 참조
        
        let context = appDelegate.persistentContainer.viewContext // 관리 객체 컨텍스트 참조
        
        // 관리 객체의 값을 수정 - 첫번째 매개변수로 수정할 관리 객체를 전달, 여러 개의 객체 한꺼번에 수정해야 하는 일이 있어도 매번 save() 호출할 필요 없이 마지막에 한번만 호출해주면 돼
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(Date(), forKey: "regdate")
        
        // Log 관리 객체 생성 및 어트리뷰트에 값 대입
        let logObject = NSEntityDescription.insertNewObject(forEntityName: "Log", into: context) as! LogMO
        logObject.regdate = Date()
        logObject.type = LogType.edit.rawValue
        
        // 게시글 객체의 logs 속성에 새로 생성된 로그 객체 추가
        (object as! BoardMO).addToLogs(logObject)
        
        do {
            try context.save()
            self.list = self.fetch() // list 배열을 생신 - 데이터 변경 후에 fetch() 메소드를 호출하여 list 배열을 갱신하도록 코드를 추가한다.
            return true
        } catch {
            context.rollback()
            return false
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // 셀 선택시 수정하는 기능 실행
        let object = self.list[indexPath.row]
        let title = object.value(forKey: "title") as? String
        let contents = object.value(forKey: "contents") as? String
        
        let alert = UIAlertController(title: "게시글 수정", message: nil, preferredStyle: .alert)
        
        // 입력 필드 추가(이름 및 전화번호) $0는 클로저 축약형으로 매개변수를 생략하는 대신 $0, $1 등으로 사용할 수 있다. - 저장 부분이랑 코드가 다르니 꼭 확인
        alert.addTextField(){ $0.placeholder = title}
        alert.addTextField(){ $0.placeholder = contents}
        
        // 버튼 추가(취소 및 저장)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in
            guard let title = alert.textFields?.first?.text, let contents = alert.textFields?.last?.text else {
                return
            }
            
            // 값을 수정하는 메소드를 호출하고, 성공이면 테이블 뷰를 리로드한다.
            if self.edit(object: object, title: title, contents: contents) == true {
                // self.tableView.reloadData()
                
                // 셀의 내용을 직접 수정한다
                let cell = self.tableView.cellForRow(at: indexPath)
                cell?.textLabel?.text = title
                cell?.detailTextLabel?.text = contents
                
                // 수정된 셀을 첫 번째 행으로 이동시킨다.
                let firstIndexPath = IndexPath(item: 0, section: 0)
                self.tableView.moveRow(at: indexPath, to: firstIndexPath) // 셀 자체를 맨 위로 옮긴다.
                
            }
        })) // end of alert.addAction(...
        
        self.present(alert,animated: false)
    }
    
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) { // 액세서리 탭을 클랙했을 때 하는 부분 - 이 메소드는 didSelectRowAt: 메소드가 실행되지 않는다.
        let object = self.list[indexPath.row]
        
        let uvc = self.storyboard?.instantiateViewController(withIdentifier: "LogVC") as! LogVC
        
        uvc.board = (object as! BoardMO)
        
        self.show(uvc, sender: self)
    }
}
