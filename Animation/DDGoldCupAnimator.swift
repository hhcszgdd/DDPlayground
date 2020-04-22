// Copyright © 2019 Zilly, Inc. All rights reserved.
import UIKit

final class DDGoldCupAnimator {
    static func show(on view: UIView) {
        let cupView = CupView(frame: CGRect(x: -444, y: 88, width: 32, height: 32))
        view.addSubview(cupView)
        view.bringSubviewToFront(cupView)
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            cupView.layer.removeAllAnimations()
            cupView.removeFromSuperview()
        })
        cupView.layer.add(CupViewAnimatation(point:CGPoint(x: view.bounds.width / 2, y: view.bounds.height/2)), forKey: nil)
        CATransaction.commit()
    }
}

extension DDGoldCupAnimator {
    final private class CupView : UIView {
        lazy var image = UIImageView(image: #imageLiteral(resourceName: "zilly-cat-hero-large"))
        override init(frame: CGRect) {
            super.init(frame: frame)
            add(subview: image, pin: .all)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

    final private class CupViewAnimatation : CAAnimationGroup {
        private var touchPoint: CGPoint = .zero
        private let timeInterval: CFTimeInterval = 1.2
        private lazy var basePath = CupPathPoint(0.00, 0.00, -0.255, -0.115, -0.06, -0.324, -0.033, -0.743)

        convenience init(point: CGPoint) {
            self.init()
            touchPoint = point
            animations = [ positionAnim, scaleAnim, opacityAnim ]
            duration = timeInterval
            isRemovedOnCompletion = true
            fillMode = .forwards
        }

        private lazy var cupPaths: [CupPathPoint] = {
            [
                basePath.add(vector: CGVector(dx: 0.15, dy: 0)),
                basePath.add(vector: CGVector(dx: 0.05, dy: 0)),
                basePath.add(vector: CGVector(dx: 0.1, dy: 0)),
                basePath.add(vector: CGVector(dx: -0.05, dy: 0)),
                basePath.add(vector: CGVector(dx: -0.1, dy: 0)),
                basePath.add(vector: CGVector(dx: -0.15, dy: 0)),
                basePath.add(vector: CGVector(dx: 0.1, dy: 0.15)),
                basePath.add(vector: CGVector(dx: -0.1, dy: 0.15)),
            ]
        }()

        private lazy var positionAnim: CAKeyframeAnimation = {
            var cupPointPath = cupPaths.randomElement()!
            var cupPoint = cupPointPath.multiply(by: 200)
            cupPoint = cupPoint.add(vector: CGVector(dx: touchPoint.x, dy: touchPoint.y))
            let path = UIBezierPath()
            let startPoint = cupPoint.startPoint
            let curve1Point = cupPoint.curve1Point
            let curve2Point = cupPoint.curve2Point
            let endPoint = cupPoint.endPoint
            path.move(to: startPoint)
            path.addCurve(to: endPoint, controlPoint1: curve1Point, controlPoint2: curve2Point)
            let positionAnim = CAKeyframeAnimation(keyPath: "position")
            positionAnim.path = path.cgPath
            positionAnim.calculationMode = .linear
            return positionAnim
        }()

        private lazy var scaleAnim: CAKeyframeAnimation = {
            let maxScale: CGFloat = 1.4
            let midScale: CGFloat = 1.0
            let minScale: CGFloat = 0.8
            let maxTransform = CATransform3DScale(CATransform3DIdentity, maxScale, maxScale, maxScale)
            let midTransform = CATransform3DScale(CATransform3DIdentity, midScale, midScale, midScale)
            let minTransform = CATransform3DScale(CATransform3DIdentity, minScale, minScale, minScale)
            let transformAnim = CAKeyframeAnimation(keyPath: "transform")
            transformAnim.values = [ minTransform, maxTransform, midTransform, midTransform ]
            transformAnim.keyTimes = [ 0.0, 0.3, 0.5, 1 ]
            transformAnim.timingFunction = CAMediaTimingFunction(name: .easeOut)
            return transformAnim
        }()

        private lazy var opacityAnim: CAKeyframeAnimation = {
            let opacityAnim = CAKeyframeAnimation(keyPath: "opacity")
            opacityAnim.values = [ 1.0, 0.0 ]
            opacityAnim.keyTimes = [ 0, 1 ]
            return opacityAnim
        }()
    }

    struct CupPathPoint {
        var startPoint: CGPoint
        var curve1Point: CGPoint
        var curve2Point: CGPoint
        var endPoint: CGPoint
        init(_ startPointX: CGFloat, _ startPointY: CGFloat, _ curve1PointX: CGFloat, _ curve1PointY: CGFloat, _ curve2PointX: CGFloat, _ curve2PointY: CGFloat, _ endPointX: CGFloat, _ endPointY: CGFloat) {
            startPoint = CGPoint(x: startPointX, y: startPointY)
            curve1Point = CGPoint(x: curve1PointX, y: curve1PointY)
            curve2Point = CGPoint(x: curve2PointX, y: curve2PointY)
            endPoint = CGPoint(x: endPointX, y: endPointY)
        }

        mutating func add(vector: CGVector) -> CupPathPoint {
            var copy = self
            copy.startPoint.x += vector.dx
            copy.startPoint.y += vector.dy
            copy.curve1Point.x += vector.dx
            copy.curve1Point.y += vector.dy
            copy.curve2Point.x += vector.dx
            copy.curve2Point.y += vector.dy
            copy.endPoint.x += vector.dx
            copy.endPoint.y += vector.dy
            return copy
        }

        mutating func multiply(by value: CGFloat) -> CupPathPoint {
            var copy = self
            copy.startPoint.x *= value
            copy.startPoint.y *= value
            copy.curve1Point.x *= value
            copy.curve1Point.y *= value
            copy.curve2Point.x *= value
            copy.curve2Point.y *= value
            copy.endPoint.x *= value
            copy.endPoint.y *= value
            return copy
        }
    }
}
