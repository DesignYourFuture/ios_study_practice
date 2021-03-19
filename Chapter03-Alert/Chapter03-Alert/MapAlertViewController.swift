//
//  MapAlertViewController.swift
//  Chapter03-Alert
//
//  Created by Hamlit Jason on 2021/03/15.
//

import UIKit
import MapKit

class MapAlertViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alertBtn = UIButton(type: .system)
        alertBtn.frame = CGRect(x: 0, y: 150, width: 100, height: 30)
        alertBtn.center.x = self.view.frame.width / 2
        alertBtn.setTitle("Map Alert", for: .normal)
        alertBtn.addTarget(self, action: #selector(mapAlert(_:)), for: .touchUpInside)
        self.view.addSubview(alertBtn)
        
        
        let imageBtn = UIButton(type: .system)
        imageBtn.frame = CGRect(x: 0, y: 200, width: 100, height: 30)
        imageBtn.center.x = self.view.frame.width / 2
        imageBtn.setTitle("Image Alert", for: .normal)
        imageBtn.addTarget(self, action: #selector(imageAlert(_:)), for: .touchUpInside)
        self.view.addSubview(imageBtn)
        
        
        let sliderBtn = UIButton(type: .system)
        sliderBtn.frame = CGRect(x: 0, y: 250, width: 100, height: 30)
        sliderBtn.center.x = self.view.frame.width / 2
        sliderBtn.setTitle("Slider Alert", for: .normal)
        sliderBtn.addTarget(self, action: #selector(sliderAlert(_:)), for: .touchUpInside)
        self.view.addSubview(sliderBtn)
        
        let listBtn = UIButton(type: .system)
        listBtn.frame = CGRect(x: 0, y: 300, width: 100, height: 30)
        listBtn.center.x = self.view.frame.width / 2
        listBtn.setTitle("List Alert", for: .normal)
        listBtn.addTarget(self, action: #selector(listrAlert(_:)), for: .touchUpInside)
        self.view.addSubview(listBtn)
    
    }
    
    @objc func listrAlert(_ sender : Any) {
        let contentVC = ListViewController()
        contentVC.delegate = self // 델리게이트의 정보를 받아온다.
        
        let alert = UIAlertController(title:nil,message: "이번 글의 평점을 입력해주세요.",preferredStyle: .alert)
        alert.setValue(contentVC, forKey: "contentViewController")
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        
        self.present(alert, animated: false, completion: nil)
        
    }
    
    func didSelectRowAt(indexPath: IndexPath){
        // 이 코드 선택
        print(">>> 선택된 행은 \(indexPath.row)입니다")
    }
    
    @objc func sliderAlert(_ sender : Any) {
        let contentVC = ControlViewController()
        
        let alert = UIAlertController(title:nil,message: "이번 글의 평점을 입력해주세요.",preferredStyle: .alert)
        alert.setValue(contentVC, forKey: "contentViewController")
        
        let okAction = UIAlertAction(title: "OK", style: .default){
            (_) in print(">>> sliderValue = \(contentVC.sliderValue)")
        }
        
        alert.addAction(okAction)
        
        self.present(alert, animated: false, completion: nil)
        
    }
    
    @objc func imageAlert(_ sender : Any) {
        let alert = UIAlertController(title: nil, message: "이번 글의 평점은 다음과 같습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        let contentVC = ImageViewController()
        alert.setValue(contentVC, forKey: "contentViewController")
        self.present(alert, animated: false, completion: nil)
    }
    
    @objc func mapAlert( _ sender : UIButton) {
        let alert = UIAlertController(title: nil, message: "여기가 맞나요", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        
        let contentVC = MapkitViewController()
        /* 코드를 분리하기 기능별로 분리작성하기 위해 주석처리
        let contentVC = UIViewController()
        let mapkitView = MKMapView(frame: CGRect(x: 0, y: 0, width: 0, height: 0)) // 맵킷뷰의 프레임을 전부 0 으로 설정한 이유는 contentVC.view = mapkitView라는 코드를 사용해 맵킷 뷰를 루트뷰로 설정하였기 때문이다. 설령 값을 지정해 주었다고 하더라도 루트뷰로 지정시 속성갑이 모두 무시된다.
        contentVC.view = mapkitView
        contentVC.preferredContentSize.height = 200 // 루트뷰의 높이값을 키운다
        
        let pos = CLLocationCoordinate2D(latitude: 37.514322, longitude: 126.894623) // 위치 정보를 설정한다. 위도 및 경도를 사용함
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005) // 지도에서 보여줄 넓이, 즉 일종의 축척으로 숫자가 작을수록 좁은 법위를 크게 확대한다.
        let region = MKCoordinateRegion(center: pos, span: span) // 지도의 영역을 정의
        
        // 지도 뷰에 표시
        mapkitView.region = region // 이코드가 없으면 지도가 확대가 안된다.
        mapkitView.regionThatFits(region)
        
        // 위치를 핀으로 표시 - 핀을 꽂는 코드
        let point = MKPointAnnotation()
        point.coordinate = pos
        mapkitView.addAnnotation(point) // 어노테이션은 필요한 만큼 추가할 수 있다.
        */
        
        
        
        alert.setValue(contentVC, forKey: "contentViewController")
        self.present(alert, animated: false, completion: nil)
    }
}
