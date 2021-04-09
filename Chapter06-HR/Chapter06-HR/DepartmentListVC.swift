//
//  EmployeeListVCTableViewController.swift
//  Chapter06-HR
//
//  Created by Hamlit Jason on 2021/04/01.
//

import UIKit

class DepartmentListVC: UITableViewController {
    
    var departList : [(departCd: Int, departTitle: String, departAddr: String)]! // 데이터 소스용 멤버 변수(배열) - DepartmentDAO 클래스의 find 메소드가 반환하는 값을 받아 저장해야 하므로, DepartmentDAO에서 정의된 튜플 타입과 형식이 동일하다.
    let departDAO = DepartmentDAO() // SQLite 처리를 담당할 DAO 객체
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        
        self.departList = self.departDAO.find() // 기존 저장된 부서 정보를 가져온다.
        self.initUI()
    }
    
    func initUI() { // UI를 초기화할 메소드 initUI를 정의한다.
        // 네비게이션 타이틀용 레이블 속성 설정
        let navTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        navTitle.numberOfLines = 2
        navTitle.textAlignment = .center
        navTitle.font = UIFont.systemFont(ofSize: 14)
        navTitle.text = "부서 목록\n" + "총\(self.departList.count) 개"
        
        // 네비게이션 바 UI 설정
        self.navigationItem.titleView = navTitle
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        // 셀을 스와이프했을 때 편집 모드가 되도록 설정
        self.tableView.allowsSelectionDuringEditing = true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.departList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // 각 테이블을 구성하는 메소드

        let rowData = self.departList[indexPath.row] // indexPath 매개변수가 가르키는 행에 대한 데이터를 읽어온다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "DEPART_CELL") // 셀 객체를 생성하고 데이터를 배치한다.
        
        cell?.textLabel?.text = rowData.departTitle
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        cell?.detailTextLabel?.text = rowData.departAddr
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)

        return cell!
    }
    
    @IBAction func add(_ sender: Any) {
        let alert = UIAlertController(title: "신규 부서 등록", message: "신규 부서를 등록해 주세요", preferredStyle: .alert)
        
        alert.addTextField() { (tf) in tf.placeholder = "부서명"}
        alert.addTextField() { (tf) in tf.placeholder = "주소"}
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "확인", style: .default){  (_) in // 확인 버튼
            
            let title = alert.textFields?[0].text // 부서명
            let addr = alert.textFields?[1].text // 부서 주소
            
            if self.departDAO.create(title: title!, addr: addr!) { // 신규 부서가 등록되면 db에서 목록을 다시 읽어온 후, 테이블을 갱신해 준다.
                self.departList = self.departDAO.find()
                self.tableView.reloadData()
                
                let navTitle = self.navigationItem.titleView as! UILabel
                navTitle.text = "부서목록 \n" + "총 \(self.departList.count)개"
            }
        })
        
        self.present(alert, animated: false, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle { // 편집 형식을 결정하는 메소드 (주의 : 편집형식을 결정하지 버튼을 클릭했을 때 실행되는 메소드는 commit editingStyle을 추가해야 한다.) 버튼을 클릭했을 때 나타나는 것 - 즉 삭제모드를 제공할지, 삽입모드를 걱정할지 정한다.
        // 오른쪽으로 셀을 스와이프 했을때 +모양 또는 - 모양이 나올지 선택하게 한다.
        /* 3가지 스타일 값
         UITableViewCell.EditingStyle.delete 삭제모드
         UITableViewCell.EditingStyle.insert 삽입모드
         UITableViewCell.EditingStyle.none 편집 모드 제공 안함
         
         만약 특정 셀에 대해서 차등하여 적용하려면 메소드를 오버라이드 하고 반환값을 반드시 케이스별로 제공하면 돼( 스위치 문 사용해서 ) - 1062 페이지 참고
         
         */
        return UITableViewCell.EditingStyle.delete
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { // 위의 editingStyleForRowAt와 같이 쓰는데, 그 형식에 맞게 사용하는 메소드
        
        // 삭제할 행의 depart_Cd 를 찾는다
        let departCd = self.departList[indexPath.row].departCd
        
        if departDAO.remove(departCd: departCd) { // db에서, 데이터 소스에서, 그리고 테이블 뷰에서 차례대로 삭제한다.
            self.departList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let departCd = self.departList[indexPath.row].departCd // 화면 이동 시 함께 전달할 부서 코드
        
        let infoVC = self.storyboard?.instantiateViewController(withIdentifier: "DEPART_INFO") // 이동할 대상 뷰 컨트롤러의 인스턴스
        
        if let _infoVC = infoVC as? DepartmentInfoVC {
            // 부서 코드를 전달한 다음, 푸시 방식으로 화면 이동
            _infoVC.departCd = departCd
            self.navigationController?.pushViewController(_infoVC, animated: true)
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
