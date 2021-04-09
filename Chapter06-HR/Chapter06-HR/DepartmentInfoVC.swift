//
//  DepartmentInfoVC.swift
//  Chapter06-HR
//
//  Created by Hamlit Jason on 2021/04/03.
//

import UIKit

class DepartmentInfoVC : UITableViewController {
    
    typealias DepartRecord = (departCd: Int, departTitle: String, departAddr: String) // 부서 정보를 저장할 데이터 타입
    
    var departCd : Int! // 부서 목록으로부터 넘겨 받을 붓 ㅓ코드
    
    // DAO 객체
    let departDAO = DepartmentDAO()
    let empDAO = EmployeeDAO()
    
    // 부서 정보와 사원 목록을 담을 멤버 변수
    var departInfo: DepartRecord!
    var empList: [EmployeeVO]!
    
    override func viewDidLoad() {
        self.departInfo = self.departDAO.get(departCd: self.departCd)
        self.empList = self.empDAO.find(departCd: self.departCd)
        self.navigationItem.title = "\(self.departInfo.departTitle)"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int { // 작성 안하면 기본값 1
        // 부서 상세 정보화면에서 테이블 뷰는 정보 섹션과 소속 사원 섹션으로 나누어 제공되어서 메소드가 반환하는 값은 2어야 한다.
        return 2
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { // 각 센션 헤더에 들어갈 뷰를 정의하는 메소드
        let textHeader = UILabel(frame: CGRect(x: 35, y: 5, width: 200, height: 30)) // 헤더에 들어갈 레이블 객체 정의
        
        textHeader.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: 2.5))
        textHeader.textColor = UIColor(red: 0.03, green: 0.28, blue: 0.71, alpha: 1.0)
        
        // 헤더에 들어갈 이미지 뷰 객체 정의
        let icon = UIImageView()
        icon.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        
        // 섹션에 따라 타이틀과 이미지 다르게 설정
        if section == 0 {
            textHeader.text = "부서 정보"
            icon.image = UIImage(imageLiteralResourceName: "depart")
        } else {
            textHeader.text = "소속 사원"
            icon.image = UIImage(imageLiteralResourceName: "employee")
        }
        
        // 레이블과 이미지 뷰를 담을 컨테이너용 뷰 객체 정의
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        v.backgroundColor = UIColor(red: 0.93, green: 0.96, blue: 0.99, alpha: 1.0)
        
        // 뷰에 레이블과 이미지 추가
        v.addSubview(textHeader)
        v.addSubview(icon)
        
        return v
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { // 헤더의 높이 설정
        return 40
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // 테이블 뷰의 목록 개수를 설정하는 메소드.
        // 일괄적으로 목록 개수를 출력하는 것이 아닌 부서 정보 섹션에 3가지
        // 소속 사원 섹션에는 소속 사원 수와 일치하는 동적 갯수 출력
        if section == 0 {
            return 3
        } else {
            return self.empList.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 { // 부서 영역
            let cell = tableView.dequeueReusableCell(withIdentifier: "DEPART_CELL")
            
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 12)
            cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
            
            switch indexPath.row {
            case 0:
                cell?.textLabel?.text = "부서 코드"
                cell?.detailTextLabel?.text = "\(self.departInfo.departCd)"
            case 1:
                cell?.textLabel?.text = "부서명"
                cell?.detailTextLabel?.text = self.departInfo.departTitle
            case 2:
                cell?.textLabel?.text = "부서 주소"
                cell?.detailTextLabel?.text = self.departInfo.departAddr
            default:
                () // 작성할 구문이 없을 때 넣어주는 더미 코드
            }
            return cell!
        } else { // 소속 사원 영역
            let row = self.empList[indexPath.row]
            
            // 테이블 뷰 설정
            let cell = tableView.dequeueReusableCell(withIdentifier: "EMP_CELL")
            cell?.textLabel?.text = "\(row.empName) (입사일: \(row.joinDate))"
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 12)
            
            // 재직 상태를 나타내는 세그먼트 컨트롤
            let state = UISegmentedControl(items: ["재직중", "휴직", "퇴사"])
            state.frame.origin.x = self.view.frame.width - state.frame.width - 10 // 1097페이지 확인
            state.frame.origin.y = 10
            state.selectedSegmentIndex = row.stateCd.rawValue // 데베에 저장된 상태값으로 설정
            
            state.tag = row.empCd // 액션 메소드에서 참조할 수 있도록 사원 코드를 저장
            state.addTarget(self, action: #selector(self.changeState(_:)), for: .valueChanged)
            
            cell?.contentView.addSubview(state)
            return cell!
        }
    }
    
    @objc func changeState(_ sender : UISegmentedControl) {
        
        let empCd = sender.tag // 사원 코드
        
        let stateCd = EmpStateType(rawValue: sender.selectedSegmentIndex) // 재작 상태
        
        if self.empDAO.editState(empCd: empCd, stateCd: stateCd!) {
            let alert = UIAlertController(title: nil, message: "재직 상태가 변경되었습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
            self.present(alert, animated: false, completion: nil)
        }
    }
    
}
