//
//  TestPDFVC.swift
//  NFCReader
//
//  Created by JohnConnor on 2020/5/22.
//  Copyright © 2020 JohnConnor. All rights reserved.
//https://stackoverflow.com/questions/47135766/implement-ink-annotations-on-ios-11-pdfkit-document

import UIKit
import PDFKit
@available (iOS 11, *)
class TestPDFVC: UIViewController {
    let signingPath = UIBezierPath()
    var lastPoint = CGPoint.zero
    var currentAnnotation = PDFAnnotation()
    
    var annotationAdded = false
    lazy var pdfView: PDFView = {
        let result = PDFView(frame: view.bounds)
        result.document = self.pdfDoc
        result.autoScales = true
         result.isUserInteractionEnabled = false
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
        view.addSubview(pdfView)

        // Do any additional setup after loading the view.
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
