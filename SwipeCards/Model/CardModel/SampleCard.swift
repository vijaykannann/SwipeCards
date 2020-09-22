import Shuffle_iOS

class SampleCard: SwipeCard {
    
//     var swipeDirections: [SwipeDirection] {
//        return [.left, .up, .right]
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        footerHeight = 80
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
//    override func overlay(forDirection direction: SwipeDirection) -> UIView? {
//        switch direction {
//        case .left:
//            return SampleCardOverlay.left()
//        case .up:
//            return SampleCardOverlay.up()
//        case.right:
//            return SampleCardOverlay.right()
//        default:
//            return nil
//        }
//    }
    
//    func configure(withModel model: SampleCardModel) {
//        content = CustomView() //SampleCardContentView(withImage: model.image)
//        footer = nil //SampleCardFooterView(withTitle: "\(model.name), \(model.age)", subtitle: model.occupation)
//    }
}
extension UIView {
    
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat = 0, paddingLeft: CGFloat = 0, paddingBottom: CGFloat = 0, paddingRight: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: paddingTop))
        }
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: paddingLeft))
        }
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom))
        }
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -paddingRight))
        }
        if width > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: width))
        }
        if height > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: height))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
    @discardableResult
    func anchorToSuperview() -> [NSLayoutConstraint] {
        return anchor(top: superview?.topAnchor, left: superview?.leftAnchor, bottom: superview?.bottomAnchor, right: superview?.rightAnchor)
    }
}

