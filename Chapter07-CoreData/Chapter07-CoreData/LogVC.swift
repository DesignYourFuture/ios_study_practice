//
//  LogVC.swift
//  Chapter07-CoreData
//
//  Created by Hamlit Jason on 2021/04/08.
//

import UIKit
import CoreData

class LogVC : UITableViewController {
    var board: BoardMO! // 게시글 정보를 전달받을 변수
    
    lazy var list : [LogMO]! = { // 멤버 변수 list를 정의하고 원 게시글이 참조하는 로그 데이터 목록을 LogMO타입으로 가져와 대입하도록 처리
        return self.board.logs?.array as! [LogMO]
    }()
    
    override func viewDidLoad() {
        self.navigationItem.title = self.board.title // 보드 멤버 변수의 title속성을 가져다 내비게이션 타이틀로 설정
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "logcell")!
        cell.textLabel?.text = "\(row.regdate!)에 \(row.type.toLogType())되었습니다."
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        
        return cell
    }
}

public enum LogType : Int16 { // 코어 데이터가 사용할 수 있도록 0,1,2 설정
    case create = 0
    case edit = 1
    case delete = 2
}

extension Int16 { // 16비트 정수값을 의미 있는 텍스트로 변경하는 역할
    func toLogType() -> String {
        switch self {
        case 0: return "생성"
        case 1: return "수정"
        case 2: return "삭제"
        default: return ""
        }
    }
}
