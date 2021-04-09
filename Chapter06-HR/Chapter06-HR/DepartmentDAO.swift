//
//  DepartmentDAO.swift
//  Chapter06-HR
//
//  Created by Hamlit Jason on 2021/04/01.
//

import Foundation

class DepartmentDAO {
    
    // 부서 정보를 담을 튜플 타입 정의
    typealias DepartRecord = (Int, String, String)
    
    lazy var fmdb : FMDatabase! = { // SQLite 연결 및 초기화
        
        let fileMgr = FileManager.default // 파일 매니저 객체를 생성
        
        let docPath = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first // 샌드박스 내 문서 디렉터리에서 데베 파일 경로 확인
        let dbPath = docPath!.appendingPathComponent("hr.sqlite").path
        
        if fileMgr.fileExists(atPath: dbPath) == false { // 샌드박스 경로에 파일이 없다면 메인 번들에 만들어 둔 hr.sqlite을 가져와 복사
            let dbSource = Bundle.main.path(forResource: "hr", ofType: "sqlite")
            try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
        }
        
        // 준비된 데베 파일을 파탕으로 FMDatebase 생성
        let db = FMDatabase(path: dbPath)
        return db
    }() // 지연 저장 프로퍼티 fmdb로 실제로 참조되기 전까지는 초기화되지 않으며, 초기화를 위한 클로저 구문 역시 fmdb 변수가 초기화되는 시점에 최초 한 번만 실행된다.
    
    init() {
        self.fmdb.open()
    }
    deinit {
        self.fmdb.close()
    }
    
    func find() -> [DepartRecord] { // department 테이블로부터 부서 목록을 읽어올 메소드
        
        var departList = [DepartRecord]() // 반환할 데이터를 담을 [DepartRecord] 타입의 객체 정의
        
        do {
            let sql = """
                SELECT depart_cd, depart_title, depart_addr
                FROM department
                ORDER BY depart_cd ASC
            """
            
            let rs = try self.fmdb.executeQuery(sql, values: nil)
            
            while rs.next() {
                let departCd = rs.int(forColumn: "depart_cd")
                let departTitle = rs.string(forColumn: "depart_title")
                let departAddr = rs.string(forColumn: "depart_addr")
                
                departList.append( (Int(departCd), departTitle!, departAddr! ) ) // append 메소드 호출 시 아래 튜플을 괄호 없이 사용하지 않도록 주의 - 괄호가 없으면 단순 3개의 인자값이고 괄호가 있어야 튜플로 인식한다.
            }
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        return departList
    }
    
    
    func get(departCd : Int) -> DepartRecord? { // 단일 부서 정보를 읽어올 메소드
        
        let sql = """
                SELECT depart_cd, depart_title, depart_addr
                FROM department
                WHERE depart_cd = ?
            """
        
        let rs = self.fmdb.executeQuery(sql, withArgumentsIn: [departCd])
        
        if let _rs = rs {
            _rs.next()
            
            let departId = _rs.int(forColumn: "depart_cd")
            let departTitle = _rs.string(forColumn: "depart_title")
            let departAddr = _rs.string(forColumn: "depart_addr")
            
            return (Int(departId), departTitle!, departAddr!)
        } else { // 결과 집합이 없을 경우 nil 반환한다.
            return nil
        }
    }
    
    func create(title: String!, addr: String!) -> Bool { // 부서 정보를 추가할 메소드를 정의한다.
        do {
            let sql = """
                INSERT INTO department (depart_title, depart_addr)
                VALUES ( ? , ? )
                """
            try self.fmdb.executeUpdate(sql, values: [title!, addr!]) // 업데이트는 내용을 변경할 때 사용하는 구문
            return true
        } catch let error as NSError {
            print("Insert Error : \(error.localizedDescription)")
            return false
        }
    }
    
    func remove(departCd : Int) -> Bool { // 부서정보를 삭제할 메소드
        /*
         executeUpdate를 사용하는 이유 현업에서는 실제로 삭제하는 것이 아닌 단지 상태값 필드를 따로 두고 이를 '삭제'로 변경하여 처리하는 경우가 많다고 함.
         예를 틀면 회사가 폐업시 회사 상태를 완전히 삭제하는 것이 아니라 상태 정보만 '폐업' 이라고만 한다.
         */
        do {
            let sql = "DELETE FROM department WHERE depart_cd= ? "
            try self.fmdb.executeUpdate(sql, values: [departCd])
            return true
        } catch let error as NSError {
            print("DELETE Error : \(error.localizedDescription)")
            return false
        }
    }
    
    
    
    
}
