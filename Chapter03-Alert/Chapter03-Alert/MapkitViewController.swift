//
//  MapkitViewController.swift
//  Chapter03-Alert
//
//  Created by Hamlit Jason on 2021/03/15.
//

import UIKit
import MapKit

class MapkitViewController : UIViewController {
    override func viewDidLoad() {
        let mapkitView = MKMapView(frame: CGRect(x: 0, y: 0, width: 0, height: 0)) // 맵킷뷰의 프레임을 전부 0 으로 설정한 이유는 contentVC.view = mapkitView라는 코드를 사용해 맵킷 뷰를 루트뷰로 설정하였기 때문이다. 설령 값을 지정해 주었다고 하더라도 루트뷰로 지정시 속성갑이 모두 무시된다.
        self.view = mapkitView
        self.preferredContentSize.height = 200 // 루트뷰의 높이값을 키운다
        
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
    }
}
