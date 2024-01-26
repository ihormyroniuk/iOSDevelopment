import UIKit
import AUIKit

class CustomShapeScreenView: ScreenViewWithDefaultStatusBarAndDefaultNavigationBar {

    // MARK: Elements

    private let containerView = ContainerView()

    // MARK: Setup

    override func setup() {
        super.setup()
        backgroundColor = .white
        addSubview(containerView)
    }

    // MARK: Layout

    var keyboardFrame: CGRect?

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContainerView()
    }

    func layoutContainerView() {
        let x: CGFloat = 48
        let y: CGFloat = 48
        let width = bounds.size.width - 2 * x
        let height = bounds.size.height - 2 * x
        let frame = CGRect(x: x, y: y, width: width, height: height)
        containerView.frame = frame
    }

}

private class ContainerView: UIView {
    
    // MARK: - Subviews
    
    let containerView = UIView()
    let borderLayer = CAShapeLayer()
    let shadowLayer = CAShapeLayer()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(containerView)
        //containerView.backgroundColor = .green
        borderLayer.fillColor = UIColor.green.cgColor
        borderLayer.strokeColor = UIColor.red.cgColor
        layer.addSublayer(borderLayer)
        
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(containerView)
        containerView.backgroundColor = .green
        borderLayer.fillColor = UIColor.green.cgColor
        borderLayer.strokeColor = UIColor.red.cgColor
        layer.addSublayer(borderLayer)
        
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    // MARK: - Layout
        
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = getBezierPath(width: bounds.maxX, height: bounds.maxY)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        containerView.layer.mask = shapeLayer
        containerView.frame = bounds
        
        borderLayer.path = shapeLayer.path
        borderLayer.lineWidth = 1
        borderLayer.frame = bounds
        
        layer.shadowPath = shapeLayer.path
    }
  
    func getBezierPath(width: Double, height: Double) -> UIBezierPath {
        let rect = CGSize(width: width, height: height)
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 0))
        bezierPath.addLine(to: CGPoint(x: 0, y: rect.height))
        let ggg: CGFloat = rect.width / 16
        for i in 0..<16 {
            bezierPath.addLine(to: CGPoint(x: CGFloat(i) * ggg + ggg / 2, y: rect.height - 16))
            bezierPath.addLine(to: CGPoint(x: CGFloat(i) * ggg + ggg, y: rect.height))
        }
        bezierPath.addLine(to: CGPoint(x: rect.width, y: 0))
        for i in 0..<16 {
            bezierPath.addLine(to: CGPoint(x: rect.width - CGFloat(i) * ggg - ggg / 2, y: 0 + 16))
            bezierPath.addLine(to: CGPoint(x: rect.width - CGFloat(i) * ggg - ggg, y: 0))
        }
        bezierPath.close()
        bezierPath.fill()
        return bezierPath
    }
}
