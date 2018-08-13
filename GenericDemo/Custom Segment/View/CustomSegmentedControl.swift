//
//  CustomSegmentedControl.swift
//  GenericDemo
//
//  Created by Shantaram Kokate on 8/8/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit
//
@IBDesignable
class CustomSegmentedControl: UIControl {
    var buttons = [UIButton]()
    var selector: UIView!
    var selectedSegmentIndex = 0
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable var commaSeperatedButtonTitles: String = "" {
        didSet {
            updateView()
        }
    }
    @IBInspectable var textColor: UIColor = .darkGray {
        didSet {
            updateView()
        }
    }
    @IBInspectable var selectorColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    @IBInspectable var borderRadius: CGFloat = 8.0 {
        didSet {
            updateView()
        }
    }
    @IBInspectable var selectorTextColor: UIColor = .black {
        didSet {
            updateView()
        }
    }
    @IBInspectable var backgroundColos: UIColor = UIColor.init(red: 232, green: 234, blue: 239) {
        didSet {
            updateView()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // self.frame = CGRect.init(x: 80, y: 0, width: 500, height: 50)
        // updateView()
        //fatalError("init(coder:) has not been implemented")
    }

    func updateView() {
        buttons.removeAll()
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        self.layer.cornerRadius = borderRadius
        self.clipsToBounds = true
        self.backgroundColor = backgroundColos
        let buttonTitles = commaSeperatedButtonTitles.components(separatedBy: ",")
        for buttonTitle in buttonTitles {
            let button = UIButton.init(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        let selectorWidth = frame.width / CGFloat(buttonTitles.count) + 15
       // let y = (self.frame.maxY - self.frame.minY) - 3.0
        selector = UIView.init(frame: CGRect.init(x: 6, y: 3, width: selectorWidth, height: self.frame.height - 6))
        //selector.layer.cornerRadius = frame.height/2
        selector.backgroundColor = selectorColor
        addSubview(selector)
        // Create a StackView
        let stackView = UIStackView.init(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0.0
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        // layer.cornerRadius = frame.height/2
    }
    @objc func buttonTapped(button: UIButton) {
        for(buttonIndex, btn) in buttons.enumerated() {
                btn.setTitleColor(textColor, for: .normal)
                if btn == button {
                selectedSegmentIndex = buttonIndex
                        let  selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(buttonIndex)
                        UIView.animate(withDuration: 0.3, animations: {
                                self.selector.frame.origin.x = (selectorStartPosition == 0) ? 3 : selectorStartPosition
                })
                        btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
        sendActions(for: .valueChanged)
    }
    func updateSegmentedControlSegs(index: Int) {
        for btn in buttons {
            btn.setTitleColor(textColor, for: .normal)
        }
        let  selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(index)
        UIView.animate(withDuration: 0.3, animations: {
            self.selector.frame.origin.x = (selectorStartPosition == 0) ? 3 : selectorStartPosition
        })
        buttons[index].setTitleColor(selectorTextColor, for: .normal)
    }
    //    override func sendActions(for controlEvents: UIControlEvents) {
    //
    //        super.sendActions(for: controlEvents)
    //
    //        let  selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(selectedSegmentIndex)
    //
    //        UIView.animate(withDuration: 0.3, animations: {
    //
    //            self.selector.frame.origin.x = selectorStartPosition
    //        })
    //
    //        buttons[selectedSegmentIndex].setTitleColor(selectorTextColor, for: .normal)
    //
    //    }
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
