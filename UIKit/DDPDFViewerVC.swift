//
//  DDPDFViewerVC.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/5/20.
//  Copyright © 2020 JohnConnor. All rights reserved.
//
/*
import UIKit
import MessageUI
import WebKit
class DDPDFViewerVC: UIViewController, WKNavigationDelegate, MFMailComposeViewControllerDelegate  {
    private let fetchPDFURL: (@escaping (URL?, Error?) -> Void) -> Void
     private var pdfDescription: String
     private let filename: String?
     private let navTitle: String?
     private let backButtonTitle: String?
     private let isLocal: Bool
     private var remotePDFURL: URL!
     private var localPDFURL: URL!
     private var isNavBarHidden: Bool!
     private var exportButton: UIBarButtonItem!
     private var isExportingEnabled = true
     var isAdventureTime = false
     private let shouldSignDocument: Bool
     private let shouldAgreeDocument: Bool
     private var didSignHandler: ((UIImage) -> Void)?
     private var didAgreeHandler: (() -> Void)?
     private var enableChatSharing: Bool
     private let isZinder: Bool


     private let webView: WKWebView = {
         let result = WKWebView()
         result.backgroundColor = .white
         return result
     }()

     private let signView: ZLSignView = {
         let signView = Bundle.main.loadNibNamed("ZLSignView", owner: self, options: nil)?.first as! ZLSignView
         signView.title = NSLocalizedString("Signature", comment: "")
         let heightConstant: CGFloat = 288
         signView.constrainHeight(to: heightConstant)
         signView.frame.size.height = heightConstant // Used so we can determine the view height by simply accessing UIView.height property.
         signView.canAdventureToNext = false
         signView.isUserInteractionEnabled = false
         return signView
     }()

     // MARK: Initialization
    init(withPDFURL: URL){
         
         super.init(nibName: nil, bundle: nil)
     }

     // Obj-C
     @objc convenience init(withPDFURL fetchPDFURL: @escaping (@escaping (URL?, Error?) -> Void) -> Void, ofType rawType: String, pdfDescription: String) {
         guard let type = ZLPDFType(from: rawType) else { preconditionFailure("Invalid PDF type: \"\(rawType)\".") }
         self.init(withPDFURL: fetchPDFURL, ofType: type, pdfDescription: pdfDescription)
     }

     required init(coder: NSCoder) { preconditionFailure() }

     public override func viewDidLoad() {
         super.viewDidLoad()
         webView.navigationDelegate = self
         view.backgroundColor = .white
         view.addSubview(webView, pinningEdgesToSafeArea: [ .left, .top, .right ])
         let webViewBottomMargin: CGFloat = shouldAgreeDocument ? _accessoryView.frame.height : (shouldSignDocument ? signView.frame.height : 0)
         refetchPDF()
         setUpNavBar()
     }
     private func refetchPDF() {
         fetchPDFURL { [weak self] requestURL, error in
             guard let self = self else { return }
             if self.isLocal {
                 guard let localPDFURL = requestURL else { return }
                 self.localPDFURL = localPDFURL
                 self.webView.loadFileURL(localPDFURL, allowingReadAccessTo: localPDFURL)
             } else {
                 let errorMessage = NSLocalizedString("We couldn't fetch this PDF right now. Please try again later.", comment: "")
                 // Fetch remote URL
                 self.remotePDFURL = requestURL
                 self.showOfflineStateViewIfNeeded()
                     // Fetch PDF
                     var request = URLRequest(url: self.remotePDFURL!)
//                     request.addValue(ZLAppManager.authToken!, forHTTPHeaderField: "Auth-Token")
//                     request.addValue(ZLAppManager.deviceID, forHTTPHeaderField: "Device-Id")
                     let session = URLSession(configuration: .default)
                     let task = session.downloadTask(with: request) { [weak self] temporaryLocalPDFURL, _, _ in
                         guard let self = self else { return }
                         // Copy PDF to documents folder immediately
                         if let temporaryLocalPDFURL = temporaryLocalPDFURL {
                             let folder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
                             let name = ProcessInfo().globallyUniqueString.appending(".pdf")
                             let localPDFURL = URL(fileURLWithPath: folder).appendingPathComponent(name, isDirectory: false)
                             do {
                                 try FileManager.default.copyItem(at: temporaryLocalPDFURL, to: localPDFURL)
                                 DispatchQueue.main.async {
                                     self.localPDFURL = localPDFURL
                                     // Load PDF
                                     self.webView.loadFileURL(localPDFURL, allowingReadAccessTo: localPDFURL)
                                 }
                             } catch {
                                 DispatchQueue.main.async {
                                    
                                 }
                             }
                         }
                     }
                     task.resume()
                 
             }
         }
     }

     // MARK: Design
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
     }

     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         navigationController?.isNavigationBarHidden = isNavBarHidden
     }

     func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
         exportButton.isEnabled = isExportingEnabled
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
                guard let self = self else { return }
//                self.loader.remove()
                self.signView.canAdventureToNext = true
                self.signView.isUserInteractionEnabled = true
            }
        } else {
            // Fallback on earlier versions
        } // Crude way of waiting for pages to finish layout
     }

     func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//         showOfflineStateViewIfNeeded()
     }

     // MARK: Exporting
     private func export() {
         let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
         actionSheet.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
         let exportAction = UIAlertAction(title: NSLocalizedString("Share to the World", comment: ""), style: .default) { [unowned self] _ in
             let fileName: String = {
                 var result = self.filename ?? NSLocalizedString("Tellus \(self.pdfType.displayString) - \(self.pdfDescription)", comment: "")
                 if !result.hasExtension(ofKind: .pdf) { result += ZLDocumentExtension.pdf.rawValue }
                 return result
             }()
             ZLShareVC.show(fileURL: self.localPDFURL, filenameIncludingExtension: fileName)
         }
         actionSheet.addAction(exportAction)
         if enableChatSharing {
             let shareInChatAction = UIAlertAction(title: NSLocalizedString("Share in Chat", comment: ""), style: .default) { _ in self.shareInChat() }
             actionSheet.addAction(shareInChatAction)
         }
         if let popover = actionSheet.popoverPresentationController {
             popover.barButtonItem = exportButton
         }
         present(actionSheet, animated: true, completion: nil)
     }

     private func shareInChat() {
         guard !ZLSession.isDemoMode else {
             ZLAuthenticationOptionsVC.showSignUpOptions(on: self) { [unowned self] context in
                 let signUpVC = ZLSignUpVC()
                 signUpVC.selectedSignUpContext = context
                 self.show(signUpVC, animated: true)
             }
             return
         }
         do {
             let data = try Data(contentsOf: localPDFURL)
             let fileName: String = {
                 var result = self.filename ?? (pdfDescription.isEmpty ? NSLocalizedString("PDF File", comment: "") : pdfDescription)
                 if !result.hasExtension(ofKind: .pdf) { result += ZLDocumentExtension.pdf.rawValue }
                 return result
             }()
             guard let document = DocumentData(data: data, mime: ZLDocumentExtension.pdf.mime, filename: fileName.sanitizeAsFilename()) else { return }
             showShareInChat(mode: .documentData(document))
         } catch {
             UIAlertController.presentAlert(title: NSLocalizedString("Unable To Share", comment: ""), message: NSLocalizedString("We're unable to share this file at the moment.", comment: ""))
         }
     }

     // MARK: Adventure
     private func goBack() {
 
     }

 

     // MARK: Accessors
     var signViewTitle: String? {
         get { return signView.title }
         set { signView.title = newValue }
     }

}

final class ZLSignView : UIView, ZLSignatureViewDelegate {
    @IBOutlet private var resetButton: ZLButton!
    @IBOutlet private var titleLabel: ZLLabel!
    @IBOutlet private var doneButton: ZLButton!
    @IBOutlet private var signatureView: ZLInvestSignatureView!
    @IBOutlet private var footerTextView: ZLHyperlinkTextView!
    @IBOutlet private var gradientView: ZLGradientView!

    var canAdventureToNext: Bool = false {
        didSet {
            doneButton.isEnabled = canAdventureToNext
        }
    }

    var didSignHandler: ((UIImage) -> Void)?
    var isZinder: Bool = false {
        didSet { gradientView.gradient = isZinder ? .color(.zinderPurple) : .curiousBlueToVividViolet }
    }

    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        signatureView.delegate = self
        signatureView.usesClearButton = false
        resetButton.isHidden = true
        doneButton.isEnabled = false
        doneButton.adjustsImageWhenHighlighted = false
        footerTextView.isHidden = true
        addSeparator(onEdges: .top)
        addShadow(radius: 8, yOffset: 4)

        // Gradient
        gradientView.layer.cornerRadius = ZLCornerRadius.default
        gradientView.gradient = .color(.zinderPurple)
        gradientView.direction = .leftToRight
        doneButton.setAccessibilityID(id: .done)
        doneButton.backgroundColor = .zillyLightGray
        doneButton.cornerRadius = ZLCornerRadius.default
    }

    // MARK: Signature View
    func signatureViewDidDraw() {
        resetButton.isHidden = false
        doneButton.isEnabled = true
        doneButton.backgroundColor = .clear
    }

    func signatureViewDidClear() {
        resetButton.isHidden = true
        doneButton.isEnabled = false
        doneButton.backgroundColor = .zillyLightGray
    }

    // MARK: Interaction
    @IBAction private func proceed() {
        let errorMessage = NSLocalizedString("There was a problem completing your request. Please try again later.", comment: "")
        guard let signature = signatureView.createImage() else { return UIAlertController.presentAlert(message: errorMessage) }
        didSignHandler?(signature)
    }

    @IBAction private func resetSignature() {
        signatureView.clear()
    }

    func setFooterAttributedString(_ attributedString: NSAttributedString, linksAndActions: [(linkString: String, action: ActionClosure)]) {
        footerTextView.isHidden = false
        let links = linksAndActions.map { ZLHyperlinkTextView.Link(text: $0.linkString, action: $0.action) }
        footerTextView.setAttributedText(attributedString, links: links)
    }

    func setFooterText(_ text: String, linksAndActions: [(linkString: String, action: ActionClosure)]) {
        footerTextView.isHidden = false
        let links = linksAndActions.map { ZLHyperlinkTextView.Link(text: $0.linkString, action: $0.action) }
        footerTextView.setText(text, links: links)
    }

    // MARK: Accessors
    var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }

    var proceedButtonTitle: String? {
        get { return doneButton.title(for: .normal) }
        set { doneButton.setTitle(newValue, for: .normal) }
    }
}








import Lottie

protocol ZLSignatureViewDelegate : AnyObject {
    func signatureViewDidDraw()
    func signatureViewDidClear()
}

class ZLSignatureView : UIView {
    private var path = UIBezierPath()
    var delegate: ZLSignatureViewDelegate?
    var usesClearButton: Bool = true

    // MARK: Content
    private lazy var lineLayer: CAShapeLayer = {
        let result = CAShapeLayer()
        result.fillColor = UIColor.clear.cgColor
        result.lineCap = .round
        result.lineJoin = .round
        result.strokeColor = UIColor.zillyDarkestGray.cgColor
        result.lineWidth = 4
        result.backgroundColor = UIColor.zillyWhite.cgColor
        return result
    }()

    fileprivate lazy var iconView: UIImageView = {
        let result = UIImageView(image: #imageLiteral(resourceName: "sign"))
        result.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            result.widthAnchor.constraint(equalToConstant: 24),
            result.heightAnchor.constraint(equalToConstant: 24),
        ])
        return result
    }()

    private lazy var clearButton: UIButton = {
        let action = ZLButtonAction(title: NSLocalizedString("Clear", comment: ""), color: .zillyRed, block: { [unowned self] in self.clear() })
        let result = ZLButton(action: action)
        result.titleLabel!.font = .zillyFont(size: .size12, weight: .regular)
        return result
    }()

    // MARK: Lifecycle
    override init(frame: CGRect) { super.init(frame: frame); initialize() }
    required init?(coder: NSCoder) { super.init(coder: coder); initialize() }

    fileprivate func initialize() {
        layer.addSublayer(lineLayer)
        addSubview(iconView, pinningEdges: [ .left, .bottom ], withInsets: UIEdgeInsets(uniform: 8))
        addSubview(clearButton, pinningEdges: [ .right, .bottom ], withInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8))
        clearButton.isHidden = true
    }

    // MARK: Interaction
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        path.move(to: location)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        path.addLine(to: location)
        lineLayer.path = path.cgPath
        if usesClearButton { clearButton.isHidden = false }
        delegate?.signatureViewDidDraw()
        signatureChangedHandler?(!path.isEmpty)
    }

    func clear() {
        path = UIBezierPath()
        lineLayer.path = path.cgPath
        clearButton.isHidden = true
        delegate?.signatureViewDidClear()
        signatureChangedHandler?(!path.isEmpty)
    }

    // MARK: General
    var signatureChangedHandler: ValueChangedHandler<Bool>?

    func createImage() -> UIImage? {
        guard !path.isEmpty else { return nil }
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        let image = renderer.image { lineLayer.render(in: $0.cgContext) }
        return image
    }
}

final class ZLInvestSignatureView : ZLSignatureView {
    override func initialize() {
        super.initialize()
        addSubview(backgroundLottieView, pinningEdges: .all, withInsets: UIEdgeInsets(uniform: 32))
        addSubview(signatureImageView, pinningEdges: .all, withInsets: UIEdgeInsets(uniform: 32))
        iconView.isHidden = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // Ensure it's only called once
        guard backgroundLottieView.currentProgress == 0 && !backgroundLottieView.isAnimationPlaying else { return }
        backgroundLottieView.play()
    }

    // MARK: Components
    private lazy var backgroundLottieView: AnimationView = {
        let result = AnimationView(name: "signature-lottie")
        result.loopMode = .playOnce
        result.contentMode = .scaleAspectFit
        result.clipsToBounds = false
        return result
    }()

    private lazy var signatureImageView: UIImageView = {
        let result = UIImageView()
        result.isHidden = true
        return result
    }()

    override func clear() {
        super.clear()
        backgroundLottieView.isHidden = false
        signatureImageView.isHidden = true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        backgroundLottieView.isHidden = true
    }

    // MARK: Accessors
    var signatureImage: UIImage? {
        get { return signatureImageView.image }
        set {
            signatureImageView.image = newValue
            signatureImageView.isHidden = newValue == nil
        }
    }
}
*/
