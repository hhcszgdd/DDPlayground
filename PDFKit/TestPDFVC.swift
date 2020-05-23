//
//  TestPDFVC.swift
//  NFCReader
//
//  Created by JohnConnor on 2020/5/22.
//  Copyright © 2020 JohnConnor. All rights reserved.
//https://stackoverflow.com/questions/47135766/implement-ink-annotations-on-ios-11-pdfkit-document

import UIKit
import PDFKit
enum SignType {
    case signing
    case browsing
}
@available (iOS 11, *)
class TestPDFVC: UIViewController {
    let signingPath = UIBezierPath()
    var lastPoint = CGPoint.zero
    var currentAnnotation = PDFAnnotation()
    
    var annotationAdded = false
    var signType: SignType = SignType.browsing {
        didSet {
            self.pdfView.isUserInteractionEnabled = signType != .signing
        }
    }
    lazy var pdfView: PDFView = {
        let result = PDFView(frame: view.bounds)
        result.document = self.pdfDoc
        result.autoScales = true
//         result.isUserInteractionEnabled = false
//        result.displayMode = .singlePageContinuous
        result.displayBox = PDFDisplayBox.cropBox
        return result
    }()
    lazy var pdfDoc: PDFDocument = {
        let path = Bundle.main.url(forResource: "Girl.pdf", withExtension: nil)
        let result = PDFDocument(url: path!)
        result?.delegate = self
        return result!
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(pdfView)
        view.add(subview: pdfView)
        let sign = UIBarButtonItem(title: "浏览模式", style: UIBarButtonItem.Style.plain, target: self, action: #selector(beginSign(sender:)))
        sign.tintColor = .red
        let cancelSign = UIBarButtonItem(title: "重置", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelSign(sender:)))
        cancelSign.tintColor = .black
        let share = UIBarButtonItem(title: "分享", style: UIBarButtonItem.Style.plain, target: self, action: #selector(shareeee))
        share.tintColor = .green
        navigationItem.rightBarButtonItems = [sign, cancelSign]
        navigationItem.leftBarButtonItem =  share
        // Do any additional setup after loading the view.
    }
     @objc    func shareeee()  {
        let dir = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first ?? "") + "/newFile.pdf"
        let result = pdfView.document?.write(to: URL(fileURLWithPath: dir))
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            
            do {
                let pdfData = try Data(contentsOf: URL(fileURLWithPath: dir))
                let vc = UIActivityViewController(activityItems: [ "here you are", URL(fileURLWithPath: dir) ], applicationActivities: nil)
                vc.excludedActivityTypes = [ .print, .assignToContact, .addToReadingList, .openInIBooks ]
                vc.completionWithItemsHandler = { activityType, _, _, _ in
                    //            if activityType == .copyToPasteboard { UIPasteboard.general.string = User.current!.referralLink }
                }
                vc.excludedActivityTypes = [ .postToTencentWeibo, .markupAsPDF];
                self.present(vc, animated: true, completion: nil)
            } catch  {
                print("xxxxxx: \(error)")
            }

        }
//        let result = PDFDocument(url: path!)
    }
    
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: pdfView)
//            signingPath = UIBezierPath()
            signingPath.removeAllPoints()
            signingPath.move(to: pdfView.convert(position, to: pdfView.page(for: position, nearest: true)!))
            annotationAdded = false
            lastPoint = pdfView.convert(position, to: pdfView.page(for: position, nearest: true)!)
        }
    }
    
    @objc func beginSign(sender:UIBarButtonItem) {
        self.signType = self.signType == .signing ? .browsing : .signing
        sender.title = self.signType == .signing ? "签名模式" : "浏览模式"
    }
    @objc func cancelSign(sender:UIBarButtonItem) {
        self.pdfView.document?.page(at: 0)?.annotations.forEach({
            self.pdfView.document?.page(at: 0)?.removeAnnotation($0)
        })
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: pdfView)
            let convertedPoint = pdfView.convert(position, to: pdfView.page(for: position, nearest: true)!)
            let page = pdfView.page(for: position, nearest: true)!
            signingPath.addLine(to: convertedPoint)
            let rect = signingPath.bounds

            if( annotationAdded ) {
                pdfView.document?.page(at: 0)?.removeAnnotation(currentAnnotation)
                currentAnnotation = PDFAnnotation(bounds: rect, forType: .ink, withProperties: nil)

                var signingPathCentered = UIBezierPath()
                signingPathCentered.cgPath = signingPath.cgPath
                signingPathCentered.moveCenter(to: rect.center)
                currentAnnotation.add(signingPathCentered)
                pdfView.document?.page(at: 0)?.addAnnotation(currentAnnotation)

            } else {
                lastPoint = pdfView.convert(position, to: pdfView.page(for: position, nearest: true)!)
                annotationAdded = true
                currentAnnotation = PDFAnnotation(bounds: rect, forType: .ink, withProperties: nil)
                currentAnnotation.add(signingPath)
                pdfView.document?.page(at: 0)?.addAnnotation(currentAnnotation)
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: pdfView)
            signingPath.addLine(to: pdfView.convert(position, to: pdfView.page(for: position, nearest: true)!))

            pdfView.document?.page(at: 0)?.removeAnnotation(currentAnnotation)

            let rect = signingPath.bounds
            let annotation = PDFAnnotation(bounds: rect, forType: .ink, withProperties: nil)
            annotation.color = UIColor.red
            signingPath.moveCenter(to: rect.center)
            annotation.add(signingPath)
            pdfView.document?.page(at: 0)?.addAnnotation(annotation)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
@available (iOS 11, *)
extension DDViewController {
    func showPDFSign() {
        self.navigationController?.pushViewController(TestPDFVC(), animated: true)
    }
}

@available (iOS 11, *)
extension TestPDFVC :  PDFDocumentDelegate {
    func `class`(forAnnotationType annotationType: String) -> AnyClass {
        if annotationType == "Line" {
            return LineAnnotation.self
        } else {
            return PDFAnnotation.self
        }
    }
    func classForPage() -> AnyClass {
        return LinePage.self
    }
}
@available (iOS 11, *)
class LinePage: PDFPage {

}
@available (iOS 11, *)
class LineAnnotation: PDFAnnotation {
    override func draw(with box: PDFDisplayBox, in context: CGContext) {
        // Draw original content under the new content.
        super.draw(with: box, in: context)
        
        // Draw a custom purple line.
        UIGraphicsPushContext(context)
        context.saveGState()
        
        let path = UIBezierPath()
        path.lineWidth = 10
        path.move(to: CGPoint(x: bounds.minX + startPoint.x, y: bounds.minY + startPoint.y))
        path.addLine(to: CGPoint(x: bounds.minX + endPoint.x, y: bounds.minY + endPoint.y))
        UIColor.systemPurple.setStroke()
        path.stroke()

        context.restoreGState()
        UIGraphicsPopContext()
    }
}
