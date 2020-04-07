// Copyright © 2019 , Inc. All rights reserved.
import UIKit
final class DDEmojiEmitterView : UIView {
    // MARK: Nested
    enum Direction {
        case topToBottom, bottomLeftToTopRight
    }

    enum Density {
        case high, low

        fileprivate var factor: Float {
            switch self {
            case .high: return 2
            case .low: return 1
            }
        }
    }

    private enum TextCellPosition {
        case side, center, bottom
    }

    // MARK: Configuration
    var emoji: Character = "🚀" { didSet { handleEmojiUpdated() } }
    var direction: Direction = .bottomLeftToTopRight
    var duration: TimeInterval = 2
    var density: Density = .low

    private var image: CGImage! // Image cache

    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    private func initialize() {
        backgroundColor = .clear
        isUserInteractionEnabled = false
        handleEmojiUpdated()
    }

    // MARK: Emitter Layers
    private lazy var leftEmitterLayer: CAEmitterLayer = {
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterSize = CGSize(width: bounds.width / 4, height: 1)
        emitterLayer.emitterPosition = CGPoint(x: bounds.width / 4, y: 0)
        emitterLayer.emitterShape = .line
        emitterLayer.birthRate = 0
        layer.addSublayer(emitterLayer)
        return emitterLayer
    }()

    private lazy var centerEmitterLayer: CAEmitterLayer = {
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterSize = CGSize(width: bounds.width / 2, height: 1)
        emitterLayer.emitterPosition = CGPoint(x: bounds.midX, y: 0)
        emitterLayer.emitterShape = .line
        emitterLayer.birthRate = 0
        layer.addSublayer(emitterLayer)
        return emitterLayer
    }()

    private lazy var rightEmitterLayer: CAEmitterLayer = {
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterSize = CGSize(width: bounds.width / 4, height: 1)
        emitterLayer.emitterPosition = CGPoint(x: (3 * bounds.width) / 4, y: 0)
        emitterLayer.emitterShape = .line
        emitterLayer.birthRate = 0
        layer.addSublayer(emitterLayer)
        return emitterLayer
    }()

    private lazy var bottomEmitterLayer: CAEmitterLayer = {
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterSize = CGSize(width: bounds.width, height: 1)
        emitterLayer.emitterPosition = CGPoint(x: 0, y: bounds.maxY)
        emitterLayer.emitterShape = .line
        emitterLayer.birthRate = 0
        layer.addSublayer(emitterLayer)
        return emitterLayer
    }()

    // MARK: Action
    func startAnimation() {
        layoutIfNeeded()
        isUserInteractionEnabled = true
//        ZLAppDelegate.shared.window?.resetToNormalLayerSpeed()
        switch direction {
        case .topToBottom:
            leftEmitterLayer.emitterCells = [ createTextCell(position: .side) ]
            centerEmitterLayer.emitterCells = [ createTextCell(position: .center) ]
            rightEmitterLayer.emitterCells = [ createTextCell(position: .side) ]
            setupAnimation(emitter: leftEmitterLayer, initialTime: 0.05)
            setupAnimation(emitter: centerEmitterLayer, initialTime: 0)
            setupAnimation(emitter: rightEmitterLayer, initialTime: 0.08)
        case .bottomLeftToTopRight:
            bottomEmitterLayer.emitterCells = [ createTextCell(position: .bottom) ]
            setupAnimation(emitter: bottomEmitterLayer, initialTime: 0)
        }
        perform(#selector(stopAnimation), with: self, afterDelay: 1.1 * duration)
    }

    // MARK: Internal
    private func handleEmojiUpdated() {
        image = String(emoji).convertToImage()!.cgImage
    }

    private func setupAnimation(emitter: CAEmitterLayer, initialTime: NSNumber) {
        let animation = CAKeyframeAnimation(keyPath: #keyPath(CAEmitterLayer.birthRate))
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.values = [1, 0, 0]
        animation.keyTimes = [initialTime, 0.9, 1]

        emitter.beginTime = CACurrentMediaTime()
        emitter.add(animation, forKey: nil)
    }

    @objc private func stopAnimation() {
        switch direction {
        case .topToBottom:
            leftEmitterLayer.removeAllAnimations()
            centerEmitterLayer.removeAllAnimations()
            rightEmitterLayer.removeAllAnimations()
        case .bottomLeftToTopRight:
            bottomEmitterLayer.removeAllAnimations()
        }
//        ZLAppDelegate.shared.window?.speedUpLayer()
        isUserInteractionEnabled = false
    }

    private func createTextCell(position: TextCellPosition) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contents = image
        cell.velocity = 900 // Empirical value =(

        switch position {
        case .side:
            cell.birthRate = 2 * density.factor
            cell.lifetime = Float((3 * duration) / 4)
            cell.emissionLongitude = .pi
        case .center:
            cell.birthRate = 4 * density.factor
            cell.lifetime = Float((3 * duration) / 4)
            cell.emissionLongitude = .pi
            let angle = atan((bounds.width / 4) / bounds.height) // Make sure that the cell won't leave the screen by the side
            cell.emissionRange = angle
        case .bottom:
            cell.birthRate = 10 * density.factor
            cell.lifetime = Float(duration)
            cell.emissionLongitude = .pi / 4
        }

        return cell
    }
}
