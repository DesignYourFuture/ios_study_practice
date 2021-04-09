//
//  ViewController.swift
//  Chapter06-SQLite3
//
//  Created by Hamlit Jason on 2021/04/01.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        let dbPath = getDBPath()
        self.dbExecute(dbPath: dbPath)
        
    }

    func getDBPath() -> String {
        
        // 앱 내 문서 디렉터리 경로에서 SQLite DB파일을 찾는다
        let fileMgr = FileManager() // 파일 매니저 객체를 생성한다
        let docPathURL = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first! // 생성된 매니저 객체를 사용하여 앱 내의 문서 디렉터리 경로를 찾고, 이를 URL 객체로 생상한다.
        let dbPath = try! docPathURL.appendingPathComponent("db.sqlite").path // URL 객체에 "db.sqlite" 파일 경로를 추가한 SQLite3 데이터베이스 경로를 만들어 냅니다.
        //let dbPath = "/Users/hamlitjason/db.sqlite" // pwd로 확인한 홈 디렉터로 경로
        
        // dbPath 경로에 파일이 없다면 앱 번들에 만ㄷ르어 둔 db.sqlite를 가져와 복사한다.
        if fileMgr.fileExists(atPath: dbPath) == false { // dbPath 경로에 파일이 있는지 없는지를 체크한다.
            let dbSource = Bundle.main.path(forResource: "db", ofType: "sqlite") // 만약 파일이 없다며 앱 번들에 포함된 db.sqlite 파일의 경로를 읽어옵니다.
            try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath) // 번들 파일 경로에 있는 db.sqlite 파일을 dbPath 경로에 복사한다.
        }
        return dbPath
    }
    
    func dbExecute(dbPath: String) {
        
        var db: OpaquePointer? = nil // SQLite 연결 정보를 담을 객체
        guard sqlite3_open(dbPath, &db) == SQLITE_OK else {
            print("DB Connect Fail")
            return
        }
        
        // 데이터베이스 연결 종료
        defer {
            /* defer 구문은 지연 블록이라고도 불리며 함수의 작성된 코드 흐름과 관계없이 가장 마지막에 실행되는 블록
             그러나 defer 블록을 읽기 전에 함수의 실행이 종료될 경우 실행되지 않는다.
             하나의 함수나 메소드 내에서 defer 블록 여러번 사용할 수 있다.
             이때는 가장 마지막에 작성된 defer 블록부터 역순으로 실행된다.
             또한 defer 중첩 사용할 경우 가장 안쪽의 defer가 가장 마지막에 실행된다.*/
            print("close db connection")
            sqlite3_close(db)
        }
        
        var stmt: OpaquePointer? = nil // 컴파일된 SQL을 담을 객체
        let sql = "CREATE TABLE IF NOT EXISTS sequence (num INTEGER)" // DDL - sequence라는 이름의 테이블 정의하라 - 하나의 integer 타입의 칼럼 가짐 if not exist 는 테이블은 한번만 생성되어야 하기 때문에
        guard sqlite3_prepare(db,sql,-1,&stmt,nil) == SQLITE_OK else {
            print("Prepare Statement Fail")
            return
        }
        
        // stmt 변수 해제
        defer {
            print("Finalize Statement")
            sqlite3_finalize(stmt)
        }
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            print("Create Table Success!")
        }
        
    }
    
}

