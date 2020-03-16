//
//  ViewController.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/2/29.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit
//import DDUIKit
import MapKit


class DDMapViewController: UIViewController , MKMapViewDelegate{
    func getAllPoint(center: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        
        return CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
    lazy var mapView = MKMapView(frame: view.bounds)
    var needGobackCenter = true
    var camera = MKMapCamera.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        setupMapView()
        mapView.showsUserLocation = true
        //        CoreDataManager.share.testSaveData()
        //        CoreDataManager.share.testReadData()
        ////        GradientManager.share.testWithView(parentView: view)
        //        SortFunction.share.test()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            
//            DDLocationManager.share.startUpdatingLocation()
            self.mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2DMake(39.90960456, 116.39722824), span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)), animated: true)
//            self.separates()
            self.drawCircle()//performDrawLint(polyline: MKPolyline(coordinates: <#T##UnsafePointer<CLLocationCoordinate2D>#>, count: <#T##Int#>))
        }
        
    }
    
    func computeExtentPositions(center: CLLocationCoordinate2D, minorRadiusByMile: Double, majorRadiusByMile: Double, heading: Double) -> [CLLocationCoordinate2D] {
        let minorDegree = minorRadiusByMile / 111319.55
        let majorDegree = majorRadiusByMile / 111319.55
        return computeExtentPositions(center: center, minorRadius: minorDegree, majorRadius: majorDegree, heading: 0)
    }
    func computeExtentPositions(center: CLLocationCoordinate2D, minorRadius: Double, majorRadius: Double, heading: Double) -> [CLLocationCoordinate2D] {
        let da = (2 * Double.pi) / 360
        var array = [CLLocationCoordinate2D]()
        for i in 0...360 {
            let angle = Double(i) * da
            let result = computeLocationFor(angle: angle, center: center, minorRadius: minorRadius, majorRadius: majorRadius, heading: 0)
            
//            print(result)
            array.append(result!)
            let start =  CLLocation(latitude: array.first!.latitude, longitude: array.first!.longitude)
            let end =  CLLocation(latitude: array.last!.latitude, longitude: array.last!.longitude)
            let distance = start.distance(from: end)
            mylog("distance : \(distance)")
        }
        return array
    }
    func computeLocationFor(angle: Double, center: CLLocationCoordinate2D, minorRadius: Double, majorRadius: Double, heading: Double) -> CLLocationCoordinate2D? {
        let xLength: Double = minorRadius * sin(angle)
        let yLength: Double = majorRadius * cos(angle)
        let distance = sqrt(xLength * xLength + yLength * yLength)
        let singNumyLength: Double = yLength > 0 ? 1 : (yLength < 0 ? -1 : 0)
        let radians = Double.pi / 180 * heading
        let azimuth = (Double.pi / 2) - (acos(xLength / distance) * singNumyLength - radians)
        let result = greatCircleLocation(beginLocation: center, azimuth: radiansRevert(value: azimuth), distance: radiansRevert(value: distance / 6378140 ))//
        return result
    }
    
    func greatCircleLocation(beginLocation: CLLocationCoordinate2D, azimuth: Double, distance: Double) -> CLLocationCoordinate2D?  {
        let latitude = beginLocation.latitude
        let longitude = beginLocation.longitude
        if distance != 0 {
            let lat1 = radians(value: latitude)
            let lon1 = radians(value: longitude)
            let a = radians(value: azimuth)
            let d = radians(value: distance)
            let lat2 = asin(sin(lat1) * cos(d) + cos(lat1) * sin(d) * cos(a))
            let lon2 = lon1 + atan2(sin(d) * sin(a), cos(lat1) * cos(d) - sin(lat1) * sin(d) * cos(a))
            if !lat2.isNaN && !lon2.isNaN {
                return CLLocationCoordinate2D(latitude: normalizeDegresLatitude(latitude: radiansRevert(value: lat2)), longitude: normalizeDegresLongitude(longitude: radiansRevert(value: lon2)))
            }
        }
        return nil
    }
    
    func radians(value:Double) -> Double {
        return Double.pi / 180 * value
    }
    
    func radiansRevert(value:Double) -> Double {
        return 180 * value  / Double.pi
    }
    
    func normalizeDegresLatitude(latitude: Double) -> Double {
        let lat = fmod(latitude, 180)
        
        return lat > 90 ? 180 - lat : ( lat < -90 ? -180 - lat : lat)
    }
    
    
    func normalizeDegresLongitude(longitude: Double) -> Double {
        let lon = fmod(longitude, 360)
        
        return lon > 180 ? lon - 360 : (lon < -180 ? 360 + lon: lon)
    }
    
    
    func getPointOfEllipse(x: CGFloat, shorAxis: CGFloat,longAxis: CGFloat) -> CGFloat{
        let temp = (1 - Double(x * x) / Double(longAxis * longAxis))
        let y = fabsf(Float(Double(shorAxis * shorAxis)  * temp))
        return CGFloat(y)
    }
    
    func drawCircle() {
//        var coor = [CLLocationCoordinate2D]()
//        let center = CLLocationCoordinate2D(latitude: 39.90960456, longitude: 116.39722824)
//        let shorAxis: CGFloat = 1
//        let longAxis: CGFloat = 2
//        var arr4 = [CLLocationCoordinate2D]()
//        var arr3 = [CLLocationCoordinate2D]()
//        var arr2 = [CLLocationCoordinate2D]()
//        for x in 0..<200 {
//            let x = CGFloat(x) / 100
//            let y = getPointOfEllipse(x: CGFloat(x), shorAxis: shorAxis, longAxis: longAxis)
//            //            mylog("x: \(x)___y: \(y.0), y1: y: \(y.1)")
//            let targetX = x/10000
//            let targetY = y/10000
//
//            let po = CLLocationCoordinate2DMake(CLLocationDegrees(center.latitude + CLLocationDegrees(targetY)),  center.longitude + CLLocationDegrees(targetX ))
////            coor.append(po)
//
//            let po4 = CLLocationCoordinate2DMake(CLLocationDegrees(center.latitude + CLLocationDegrees(-targetY)),  center.longitude + CLLocationDegrees(targetX))
//            arr4.append(po4)
//            let po3 = CLLocationCoordinate2DMake(CLLocationDegrees(center.latitude + CLLocationDegrees(-targetY)),  center.longitude + CLLocationDegrees(-targetX))
//            arr3.append(po3)
//
//            let po2 = CLLocationCoordinate2DMake(CLLocationDegrees(center.latitude + CLLocationDegrees(targetY)),  center.longitude + CLLocationDegrees(-targetX))
//            arr2.append(po2)
//
//        }
//        coor.append(contentsOf: arr4.reversed())
//        coor.append(contentsOf: arr3)
//        coor.append(contentsOf: arr2.reversed())
//        let result = computeExtentPositions(center: center, minorRadiusByMile: 200, majorRadiusByMile: 100, heading: 2)
        var coor = [CLLocationCoordinate2D]()
               let center = CLLocationCoordinate2D(latitude: 39.90960456, longitude: 116.39722824)
        let result = computeExtentPositions(center: center, minorRadius: 80, majorRadius: 40, heading: 0)
        coor.append(contentsOf: result)
        let line = MKPolyline(coordinates: &coor, count: result.count )
        mapView.addOverlay(line)
        
    }
    
    
    
    func separates() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        addPlaceMarkWithTouches(touches: touches)
        //        DDWindow.share.show()
        //        let vc = DDViewController()
        //        vc.collectionView.sections = [
        //            DDSection(rows: [ DDRow4(), DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
        //            DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]),
        //
        //        ]
        //        navigationController?.pushViewController(vc, animated: true)
    }
    func setupMapView()  {
        
        self.mapView.frame =  view.bounds
        self.mapView.showsUserLocation = true
        self.mapView.showsScale = true
        self.mapView.delegate = self
        if #available(iOS 9.0, *) {
            self.mapView.showsScale = true
        } else {
            // Fallback on earlier versions
        }//比例尺
        if #available(iOS 9.0, *) {
            self.mapView.showsTraffic = false
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 9.0, *) {
            self.mapView.showsCompass = true
        } else {
            // Fallback on earlier versions
        }
        //        map.userLocation//用户当前位置
        self.mapView.mapType = MKMapType.standard
    }
    
}
 

extension DDMapViewController {
    
    func addPlaceMarkWithTouches(touches: Set<UITouch>)  {
        let touch : UITouch = touches.first!;
        let point =  touch.location(in: self.mapView)
        let coornidate =  self.mapView.convert(point, toCoordinateFrom: self.mapView)
        let userLocation = GDLocation.init()
        mylog(self.mapView.annotations.count)//如果显示当前位置的话 , count 至少为1
        if self.mapView.showsUserLocation {
            if self.mapView.annotations.count % 2 ==  0 {
                userLocation.type = GDLocationType.origen
            }else {
                userLocation.type = GDLocationType.image1
            }
        }else{
            if self.mapView.annotations.count % 2 ==  0 {
                userLocation.type = GDLocationType.origen
            }else {
                userLocation.type = GDLocationType.image1
            }
        }
        userLocation.coordinate = coornidate
        userLocation.title = "title"
        userLocation.subtitle = "subTitle"
        let location = CLLocation.init(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
         
        //        self.mapView?.addAnnotation((self.mapView?.userLocation)!)
        //            self.mapView?.showAnnotations([userLocation], animated: true)
        self.mapView.addAnnotation(userLocation)
        //                self.mapView?.removeAnnotation(<#T##annotation: MKAnnotation##MKAnnotation#>)
        //        self.mapView?.annotations//大头针数组
        //        }
        
    }
    
    // MARK: 注释 : 导航划线
    func drawLineMethod(sourceCoordinate : CLLocationCoordinate2D , destinationCoordinate : CLLocationCoordinate2D , transportType: MKDirectionsTransportType =  MKDirectionsTransportType.any)  {
        let tempRequest = MKDirections.Request.init()
        tempRequest.transportType = transportType
        tempRequest.source = MKMapItem.init(placemark: MKPlacemark.init(coordinate: sourceCoordinate , addressDictionary:nil ))
        tempRequest.destination = MKMapItem.init(placemark: MKPlacemark.init(coordinate: destinationCoordinate, addressDictionary:nil ))
        let tempDerection : MKDirections = MKDirections.init(request: tempRequest)
        tempDerection.calculate(completionHandler: { (resp, error ) in
            if error == nil {
                if let route = resp?.routes.last{
                    self.mapView.addOverlays([route.polyline])
                }else{
                    mylog("error")
                }
            }else{
                mylog(error)
            }
            /*
             resp'properties:
             let routes : [MKRoute]= respons?.routes//线路数组(多种方案)
             let route = routes.first
             route.name : 线路名称
             route.distance : 距离
             expectedTravelTime : 语句时间
             polyline : 折线(数据模型)
             let steps : [MKRouteStep] = route.first.steps
             let step = steps.first
             step.instructions : 导航提示语
             */
            
        })
    }
    
    ///
    
    ////delegate
    
    ////
    
    //MARK: 获取两个坐标之间的路线resp?.routes
    func getRoutes(sourceCoordinate : CLLocationCoordinate2D , destinationCoordinate : CLLocationCoordinate2D , complate : @escaping (_ response : MKDirections.Response? )->())  {
        if #available(iOS 10.0, *) {
            let tempRequest = MKDirections.Request.init()
            tempRequest.source = MKMapItem.init(placemark: MKPlacemark.init(coordinate: sourceCoordinate))
            tempRequest.destination = MKMapItem.init(placemark: MKPlacemark.init(coordinate: destinationCoordinate))
            let tempDerection : MKDirections = MKDirections.init(request: tempRequest)
            tempDerection.calculate(completionHandler: { (resp, error ) in
                if error != nil {complate(nil) ;return}
                /*
                 resp'properties:
                 let routes : [MKRoute]= respons?.routes//线路数组(多种方案)
                 let route = routes.first
                 route.name : 线路名称
                 route.distance : 距离
                 expectedTravelTime : 语句时间
                 polyline : 折线(数据模型)
                 let steps : [MKRouteStep] = route.first.steps
                 let step = steps.first
                 step.instructions : 导航提示语
                 */
                complate(resp)
            })
        } else {
            // Fallback on earlier versions
            complate(nil)
        }
    }
    
    //执行划线
    func performDrawLint (polyline: MKPolyline)  {
        
        self.mapView.addOverlay(polyline)
    }
    // MARK: 注释 : (划线用的代理方法)添加覆盖层后调用
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer{
        if overlay.isKind(of: MKPolyline.self ) {
            
            let lineRender = MKPolylineRenderer.init(overlay: overlay)
            lineRender.lineWidth = 2
            //lineRender.fillColor = UIColor.red
            lineRender.strokeColor = UIColor.red
            return lineRender
        }
        if overlay.isKind(of: MKCircle.self ) {
            let lineRender = MKCircleRenderer.init(overlay: overlay)
            lineRender.alpha = 0.5
            lineRender.fillColor = UIColor.red
            lineRender.strokeColor = UIColor.purple
            lineRender.lineWidth = 10
            return lineRender
        }
        
        return MKOverlayRenderer()
    }
    
    
    
    
    
    // MARK: 注释 : 获取地图截图
    func getshotScreen() {
        let options = MKMapSnapshotter.Options()
        //options.size = CGSize(width: 200, height: 200)
        let snapShotter  : MKMapSnapshotter = MKMapSnapshotter.init(options: options)
        snapShotter.start { (snapShot, error ) in
            mylog(snapShot?.image)
        }
    }
    
    // MARK: 注释 : 3D视角
    func setup3D()  {
        
        let camera = MKMapCamera.init(lookingAtCenter: CLLocationCoordinate2D.init(latitude: self.mapView.centerCoordinate.latitude, longitude: self.mapView.centerCoordinate.longitude), fromEyeCoordinate: CLLocationCoordinate2D.init(latitude: self.mapView.centerCoordinate.latitude - 0.005, longitude: self.mapView.centerCoordinate.longitude), eyeAltitude: 21.0)//3D视角
        self.camera = camera
        self.mapView.setCamera(camera, animated: true)
    }
    
    //实时获取用户位置代理
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation){
        mylog("get current location : \(userLocation.coordinate)")
        //        mapView.setCenter(userLocation.coordinate, animated: true)//设置当前位置到屏幕中心
        if needGobackCenter {
            needGobackCenter = false
            self.settheUserLocationToScreenCenter(location:userLocation)//实时设置当前位置到屏幕中心
        }
    }
    //实时设置位置到屏幕中心
    func settheUserLocationToScreenCenter(location: MKUserLocation)  {
        mapView.setCenter(location.coordinate, animated: true)//设置当前位置到屏幕中心
        let span :  MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.010001, longitudeDelta: 0.010001)//初始显示范围,值越小越精确
        let  region: MKCoordinateRegion = MKCoordinateRegion.init(center:location.coordinate, span: span)
        mapView.setRegion(region, animated: true)//当region改变的时候设置这些
    }
    //返回大头针视图的代理
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if  annotation.coordinate.longitude == mapView.userLocation.coordinate.longitude && annotation.coordinate.latitude == mapView.userLocation.coordinate.latitude {//用户当前的位置正常返回蓝圈
            return nil
        }else{//其他的返回(自定义)大头针
            if let gdLocation  = annotation as? GDLocation {
                if gdLocation.type == GDLocationType.origen {//
                    return returnCustomAnnotationView(mapView, viewFor: annotation)
                }else if (gdLocation.type == GDLocationType.image1){
                    return self.returnCustomAnnotationViewWithImage(mapView, viewFor: annotation)
                }else{
                    return nil
                }
            }else{
                return nil
            }
        }
    }
    //返回图片大头针
    func returnCustomAnnotationViewWithImage(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: "placeMark")
        if view == nil  {
            view = MKAnnotationView.init(annotation: annotation, reuseIdentifier: "placeMark")
        }
        view?.annotation = annotation
        view?.canShowCallout = true//不用图片的时候使用 , 弹出常规的文字
        view?.isDraggable = true
        
        view?.image = UIImage(named: "ar_back")
        //        view?.leftCalloutAccessoryView/rightCalloutAccessoryView//标题弹窗的左右视图
        //        view.detailCalloutAccessoryView//标题弹窗的subTitle位置
        return view //
    }
    
    //返回系统大头针,(只是自定义颜色)
    func returnCustomAnnotationView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: "placeMark")
        if view == nil  {
            view = MKAnnotationView.init(annotation: annotation, reuseIdentifier: "placeMark")
        }
        if let subView  = view as? MKPinAnnotationView {
            subView.annotation = annotation
            subView.canShowCallout = true//不用图片的时候使用 , 弹出常规的文字
            subView.animatesDrop = true
            subView.isDraggable = true
            if #available(iOS 9.0, *) {
                subView.pinTintColor = UIColor.red
            } else {
                /**
                 MKPinAnnotationColorRed = 0,
                 MKPinAnnotationColorGreen,
                 MKPinAnnotationColorPurple
                 */
                subView.pinColor = MKPinAnnotationColor.red
            }
            return subView //
        }else{
            return nil  //默认是系统
        }
    }
    
    
    
}
enum GDLocationType {
    case origen
    case image1
    case image2
    case image3
    case image4
    case image5
}
class GDLocation: NSObject ,  MKAnnotation  {//大头针数据模型,包含位置,标题,副标题等
    override init() {
        super.init()
    }
    var coordinate: CLLocationCoordinate2D  =  CLLocationCoordinate2D.init(){
        didSet{
            //            coordinate = newValue
        }
        willSet{
            //            return self.coordinate
        }
    }
    // Title and subtitle for use by selection UI.
    var title: String?
    
    var subtitle: String?
    var type  :GDLocationType?//大头针类型
    
}
public func mylog <T>(_ message: T, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line){
    #if DEBUG
    let  url = URL.init(fileURLWithPath: fileName)
    
    print("✅\(url.lastPathComponent)[\(lineNumber)]:👉\(message)")
    #endif
}
