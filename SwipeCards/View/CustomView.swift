//
//  CustomView.swift
//  TinderSwipeView_Example
//
//  Created by Nick on 29/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Shuffle_iOS

class CustomView: SwipeCard,Nib {
    
    @IBOutlet var contentView: UIView!{
        didSet{
            self.layer.masksToBounds = true
            self.layer.cornerRadius = 20
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.borderWidth = 2
        }
    }
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var restoreButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    
    //    var userModel : UserModel! {
    //        didSet{
    //            self.imageViewBackground.image = UIImage(named:String(Int(1 + arc4random() % (8 - 1))))
    //        }
    //    }
    
     
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    private let backgroundView: UIView = {
        let background = UIView()
        background.clipsToBounds = true
        background.layer.cornerRadius = 10
        return background
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.withAlphaComponent(0.01).cgColor,
                           UIColor.black.withAlphaComponent(0.8).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        return gradient
    }()
    
    
    private func initialize() {
        
        //        addSubview(backgroundView)
        //        backgroundView.anchorToSuperview()
        //        backgroundView.addSubview(imageView)
        //        imageView.anchorToSuperview()
        //        applyShadow(radius: 8, opacity: 0.2, offset: CGSize(width: 0, height: 2))
        //        backgroundView.layer.insertSublayer(gradientLayer, above: imageView.layer)
        
    }
    
//    override func overlay(forDirection direction: SwipeDirection) -> UIView? {
//        switch direction {
//        case .left:
//            return SampleCardOverlay.left()
//        case.right:
//            return SampleCardOverlay.right()
//        default:
//            return nil
//        }
//    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let heightFactor: CGFloat = 0.35
        gradientLayer.frame = CGRect(x: 0, y: (1 - heightFactor) * bounds.height,
                                     width: bounds.width,
                                     height: heightFactor * bounds.height)
    }
    
    
    func commonInit() {
        registerNib()
        initialize()
    }
    
}

extension UIView {
    
    func fixInView(_ container: UIView!) -> Void{
        
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}

extension NSObject {
    
    class var className: String {
        return String(describing: self)
    }
}
protocol Nib {
    func registerNib()
}

extension Nib where Self : UIView {
    
    func registerNib() {
        guard let nibName = type(of: self).description().components(separatedBy: ".").last else { return }
        #if !TARGET_INTERFACE_BUILDER
        let bundle = Bundle(for: type(of: self))
        guard let _ = bundle.path(forResource: nibName, ofType: "nib")
            else { fatalError("can't find \(nibName) xib resource in current bundle") }
        #endif
        guard let view = Bundle(for: type(of: self)).loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView
            else { return }
        view.frame = bounds
        addSubview(view)
    }
}
