//
//  EmployeeListVCTableViewController.swift
//  Chapter06-HR
//
//  Created by Hamlit Jason on 2021/04/01.
//

import UIKit

class EmployeeListVC: UITableViewController {
    
    var bgCircle : UIView! // 임계점에 도달했을 때 나타날 배경 뷰, 노란 원 형태
    var loadingImg: UIImageView! // 새로고침 컨트롤에 들어갈 이미지 뷰

    var empList: [EmployeeVO]! // 데이터 소스를 저장할 멤버 변수
    var empDAO = EmployeeDAO() // SQLite 처리를 담당할 DAO 클래스
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.empList = self.empDAO.find()
        self.initUI()
        
        self.refreshControl = UIRefreshControl()
        //self.refreshControl?.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        self.refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
        
        // 로딩 이미지 초기화 및 중앙 정렬 - 수직정렬은 하면 안돼 왜냐하면 당기면서 y값이 변경되는데 대응할 수 없게 되서
        self.loadingImg = UIImageView(image: UIImage(named: "refresh"))
        self.loadingImg.center.x = (self.refreshControl?.frame.width)! / 2
        
        // tintColor 값을 제거하여 기본 로딩 이미지인 인디케이터 뷰를 숨기고 로딩 이미지 뷰를 서브 뷰로 등록한다
        self.refreshControl?.tintColor = .clear
        self.refreshControl?.addSubview(self.loadingImg)
        
        // 배경 뷰 초기화 및 노란 원 형태를 위한 속성 설정
        self.bgCircle = UIView()
        self.bgCircle.backgroundColor = UIColor.yellow
        self.bgCircle.center.x = (self.refreshControl?.frame.width)! / 2
        
        // 배경 뷰를 refreshControl 객체에 추가하고, 로딩 이미지를 제일 위로 올림
        self.refreshControl?.addSubview(self.bgCircle)
        self.refreshControl?.bringSubviewToFront(self.loadingImg)
    }
    
    @objc func pullToRefresh(_ sender: Any) {
        // 새로고침 시 갱신되어야 할 내용들
        self.empList = self.empDAO.find()
        self.tableView.reloadData()
        
        self.refreshControl?.endRefreshing() // 당겨서 새로고침 기능 종료
        
        
        // 노란색 원이 로딩 이미지를 중심으로 커지는 애니메이션
        let distance = max(0.0, -(self.refreshControl?.frame.origin.y)!)
        UIView.animate(withDuration: 0.5) {
            self.bgCircle.frame.size.width = 80
            self.bgCircle.frame.size.height = 80
            self.bgCircle.center.x = (self.refreshControl?.frame.width)! / 2
            self.bgCircle.center.y = distance / 2
            self.bgCircle.layer.cornerRadius = (self.bgCircle?.frame.size.width)! / 2
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) { // 스크롤 뷰의 드래그가 끝났을 때 호출되는 메소드
        
        // 노란 원을 다시 초기화
        self.bgCircle.frame.size.width = 0
        self.bgCircle.frame.size.height = 0
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) { // 스크롤이 발생할 때마다 처리할 내용 - 세부 코드는 외워서 쓰기
        let distance = max(0.0, -(self.refreshControl?.frame.origin.y)!) // 이 구문은 통째로 외워두는 것이 좋다. - refreshControl 객체의 y좌표 값을 이용하거 당긴 거리를 계산하는 공식
        
        self.loadingImg.center.y = distance / 2 // center.y 좌표를 당긴 거리만큼 수정
        
        let ts = CGAffineTransform(rotationAngle: CGFloat(distance / 20))
        self.loadingImg.transform = ts
        
        self.bgCircle.center.y = distance / 2 // 배경 뷰의 중심 좌표 설정
    }
    
    func initUI() { // UI를 초기화할 메소드 initUI를 정의한다.
        // 네비게이션 타이틀용 레이블 속성 설정
        let navTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        navTitle.numberOfLines = 2
        navTitle.textAlignment = .center
        navTitle.font = UIFont.systemFont(ofSize: 14)
        navTitle.text = "사원 목록\n" + "총\(self.empList.count) 명"
        
        // 네비게이션 바 UI 설정
        self.navigationItem.titleView = navTitle
        // 에디팅 버튼 직접 구현해보기 !! 자동화에 의존하지 않고
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.empList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowData = self.empList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EMP_CELL")
        
        // 사원명 + 재직 상태 출력
        cell?.textLabel?.text = rowData.empName + "(\(rowData.stateCd.desc()))"
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 12)
        
        cell?.detailTextLabel?.text = rowData.departTitle
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        
        // Configure the cell...

        return cell!
    }
    
    @IBAction func add(_ sender: Any) {
        let alert = UIAlertController(title: "사원 등록", message: "등록할 사원 정보를 입력해 주세요", preferredStyle: .alert)
        
        alert.addTextField { (tf) in
            tf.placeholder = "사원명"
        }
        
        // 알림창에서 커스텀 할 수 있는 부분에 넣기
        let pickervc = DepartPickerVC()
        alert.setValue(pickervc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default){ (_)in
            
            // 알림창의 입력 필드에서 값을 읽어온다
            var param = EmployeeVO()
            param.departCd = pickervc.selectedDepartCd
            param.empName = (alert.textFields?[0].text)!
            
            // 가입일은 오늘로 한다
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            param.joinDate = df.string(from: Date())
            
            // 재직 상태는 '재직중'으로 한다
            param.stateCd = EmpStateType.ING
            
            // 데베 처리
            if self.empDAO.create(param: param) {
                // 테이블 뷰 갱신한다
                self.empList = self.empDAO.find()
                self.tableView.reloadData()
                
                // 내비게이션 타이틀을 갱신한다
                if let navTitle = self.navigationItem.titleView as? UILabel {
                    navTitle.text = "사원목록 \n " + "총 \(self.empList.count)명"
                }
            }
        })
        
        self.present(alert,animated: false)
    }
    
    
    
    @IBAction func editing(_ sender: Any) {
        /*
         주의 : 스토리 보드에서 시스템 아이템은 커스텀으로 해야 편집이 가능하다!!
         */
        if self.isEditing == false { // 편집모드가 아닐떄
            self.setEditing(true, animated: true)
            (sender as? UIBarButtonItem)?.title = "Done"
        } else { // 현재 편집 모드일때
            self.setEditing(false, animated: true)
            (sender as? UIBarButtonItem)?.title = "Edit"
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle { // 목록편집 형식을 결정하는 메소드 (삽입/삭제/none)
        return UITableViewCell.EditingStyle.delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 위의 함수와 함께 사용되며, 목록 편집 버튼을 클릭했을 때 호출되는 메소드
        
        let empCd = self.empList[indexPath.row].empCd
        
        // 데베에서, 데이터 소스에서, 그리고 테이블 뷰에서 차례대로 삭제한다.
        if empDAO.remove(empCd: empCd) {
            self.empList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


}
