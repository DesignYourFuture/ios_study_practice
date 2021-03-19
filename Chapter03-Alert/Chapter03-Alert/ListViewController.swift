//
//  ListViewController.swift
//  Chapter03-Alert
//
//  Created by Hamlit Jason on 2021/03/18.
//

import UIKit

class ListViewController: UITableViewController {
    
    var delegate : MapAlertViewController? // 이 변수는 델리게이트 객체
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize.height = 220
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = "\(indexPath.row)번째 옵션입니다."
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectRowAt(indexPath: indexPath) // 델리게이트로 전달한다. 이유는 리스트뷰컨트롤러에 있는것을 맵알터뷰컨트롤러에 작성된 코드로 정보를 넘겨야 하기 때문에
    }
}
