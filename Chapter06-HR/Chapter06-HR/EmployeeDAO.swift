//
//  EmployeeDAO.swift
//  Chapter06-HR
//
//  Created by Hamlit Jason on 2021/04/02.
//

import Foundation

enum EmpStateType : Int {
    /*
     db에 그대로 넣을 수 없기 때문에 정수 타입으로 정해서 정수값을 지정해줘야 한다.
     굳이 열거형을 사용하는 이유는 컴파일러가 허용하는 범위를 알게해서 정확하게 사용할 수 있고,
     오타 등으로 오류가 발생하는 것을 막기 위함
     */
    
    case ING = 0, STOP, OUT // 순서대로 재직중(0), 휴직(1), 퇴사(2)
    
    func desc() -> String {
        switch self {
        case .ING:
            return "재직중"
        case .STOP:
            return "휴직"
        case .OUT:
            return "퇴사"
        }
    }
}

struct EmployeeVO {
    /*
     구조체를 사용하는 이유 : 우선 클래스보다 객체의 생성 및 초기화 가정이 훨씬 빠르고 가볍고 빠르기 때문
     예외적인 경우를 제외하고 VO 패턴 객체를 정의할 때에는 클래스보다 구조체 사용 권장
     1. VO 객체를 여러곳에 전달해야 할 때
     -> 빠르고 가볍다는 강점이 있지만, 값을 전달해야 할 때에는 내부의 멤버 변수에 저장된 모든 값을 복사해야 하므로 참조 주소만 전달하면 되는 클래스보다 무겁기 때문
     2. VO 객체 내부에 클래스 기바느이 멤버 변수가 사용될 떄
     -> 구조체 내부에 클래스 기반의 멤버 변수가 선언된 상태에서 값을 복사하면 클래스 기반 멤버 변수의 레퍼런스까지 함께 복사되서 동일한 주소를 참조하는 결과를 가져오므로 주의
     3. 상속 구조가 필요할 때
     -> 상속 관계를 정의하고 싶은 경우에는 클래스를 사용해야 합니다. 구조체는 상속이 불가능하기 때문이다.
     
     */
    var empCd = 0 // 사원 코드
    var empName = "" // 사원명
    var joinDate = "" // 입사일
    var stateCd = EmpStateType.ING // 재직 상태 ( 기본값 : 재직중 )
    var departCd = 0 // 소속 부서 코드
    var departTitle = "" // 소속 부서명
}

class EmployeeDAO {
    // FMDatabase 객체 생성 및 초기화
    
    lazy var fmdb : FMDatabase! = {
        // FMDatabase 객체 생성 및 초기화
        let fileMgr = FileManager.default
        
        // 샌드박스 내 문서 디렉터리 경로에서 데베 파일을 읽어온다
        let docPath = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let dbPath = docPath!.appendingPathComponent("hr.sqlite").path
        
        // 샌드박스 경로에 hr.sqlite 파일이 없다면 메인 번들에 만들어 둔 파일을 가져와 복사한다.
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "hr", ofType: "sqlite")
            try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
        }
        // 준비된 데베 파일을 바탕으로 FMDatabase 객체를 생성한다.
        let db = FMDatabase(path: dbPath)
        return db
    }()
    
    init() {
        self.fmdb.open()
    }
    deinit {
        self.fmdb.close()
    }
    
    func find(departCd: Int = 0) -> [EmployeeVO] { // 매개변수가 없었다가 들어갔는데, 이렇게 수정할 때는 매개변수 기본 값을 지정하면 매개 변수 없이도 호출 가능해
        // 사원 목록을 가져올 find() 메소드 정의
        var employeeList = [EmployeeVO]() // 반환할 데이터를 담을 [DepartRecord] 타입의 객체 정의
        
        do {
            let condition = departCd == 0 ? "" : "WHERE Employee.depart_cd = \(departCd)" // 조건절 정의
            
            let sql = """
                SELECT emp_cd, emp_name, join_date, state_cd, department.depart_title
                FROM employee
                JOIN department ON department.depart_cd = employee.depart_cd
                \(condition)
                ORDER BY employee.depart_cd ASC
            """
            
            let rs = try self.fmdb.executeQuery(sql, values: nil)
            
            while rs.next() {
                var record = EmployeeVO()
                
                record.empCd = Int(rs.int(forColumn: "emp_cd"))
                record.empName = rs.string(forColumn: "emp_name")!
                record.joinDate = rs.string(forColumn: "join_date")!
                record.departTitle = rs.string(forColumn: "depart_title")!
                
                let cd = Int(rs.int(forColumn: "state_cd"))
                record.stateCd = EmpStateType(rawValue: cd)!
                
                employeeList.append(record)
            }
        } catch let error as NSError {
            print("failed : \(error.localizedDescription)")
        }
        return employeeList
    }
    
    func create(param: EmployeeVO) -> Bool { // 신규 사원 추가를 위한 메소드
        do {
            let sql = """
                INSERT INTO employee (emp_name, join_date, state_cd, depart_cd)
                VALUES ( ?, ?, ?, ? )
            """
            
            var params = [Any]()
            params.append(param.empName)
            params.append(param.joinDate)
            params.append(param.stateCd.rawValue)
            params.append(param.departCd)
            
            try self.fmdb.executeUpdate(sql, values: params)
            
            return true
        } catch let error as NSError {
            print("Insert Error : \(error.localizedDescription)")
            return false
        }
    }
    
    func remove(empCd: Int) -> Bool { // 사원 정보를 삭제할 메소드를 정의한다.
        do {
            let sql = "DELETE FROM employee WHERE emp_cd = ? "
            try self.fmdb.executeUpdate(sql, values: [empCd])
            return true
        } catch let error as NSError {
            print("Remove Error : \(error.localizedDescription)")
            return false
        }
    }
    
    func editState(empCd: Int, stateCd: EmpStateType) -> Bool {
        do {
            let sql = " UPDATE employee SET state_cd = ? WHERE emp_cd = ?"
            var params = [Any]()
            params.append(stateCd.rawValue) // 재직 상태 코드 0,1,2
            params.append(empCd) // 사원 코드
            
            // 업데이트 실행
            try self.fmdb.executeUpdate(sql, values: params)
            return true
        } catch let error as NSError {
            print("UPDATE error : \(error.localizedDescription)")
            return false
        }
    }
}
