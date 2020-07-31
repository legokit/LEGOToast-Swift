//
//  LEGOToastView.swift
//  lego-camera-ios
//
//  Created by 杨庆人 on 2020/7/27.
//  Copyright © 2020 杨庆人. All rights reserved.
//

import UIKit
import SnapKit

public enum LEGOToastPosition: Int {
    case center = 0
    case top
    case bottom
}

public var legoToastGlobalWindow = UIApplication.shared.keyWindow

public class LEGOToastView: UIView {
    
    lazy var contentLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center

        if let font = legoToastGlobalManager.font {
            label.font = font
        }
        else {
            label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
        }
        
        if let textColor = legoToastGlobalManager.textColor {
            label.textColor = textColor
        }
        else {
            label.textColor = UIColor.white
        }
                
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setToastView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setToastView() -> Void {
        
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = true;
        
        if let backgroundColor = legoToastGlobalManager.backgroundColor {
            self.backgroundColor = backgroundColor
        }
        else {
            self.backgroundColor = UIColor.init(red: 42/255.0, green: 42/255.0, blue: 42/255.0, alpha: 1)
        }
        
        self.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.edges.equalTo(UIEdgeInsets.init(top: 21, left: 37, bottom: 21, right: 37))
        }
    }
    
    public class func showByMessage(text: String) {
        self.showByMessage(text: text, position: LEGOToastPosition.center)
    }
    
    public class func showByMessage(text: String, position: LEGOToastPosition) -> Void {
        
        let toast = LEGOToastView()
        
        let attriString = NSMutableAttributedString.init(string: text)
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = 5;
        paragraphStyle.alignment = NSTextAlignment.center
        let range = NSRange.init(location: 0, length: text.count)
        attriString.addAttributes([NSAttributedString.Key.paragraphStyle : paragraphStyle], range: range)
        toast.contentLabel.attributedText = attriString

        if let window = legoToastGlobalWindow {
            window.addSubview(toast)
            
            let superview = toast.superview!
            let leftRightSpacing = 20.0
            let maxWidth = Double(superview.frame.size.width) - leftRightSpacing * 2
            
            if LEGOToastPosition.top == position {
                let center = superview.frame.size.height / 2.0 / 3.0;
                toast.snp.makeConstraints { (make) in
                    make.centerX.equalTo(superview.snp.centerX)
                    make.top.equalTo(superview.snp.top).offset(center)
                    make.width.lessThanOrEqualTo(maxWidth)
                }
            }
            else if LEGOToastPosition.bottom == position {
                let center = superview.frame.size.height / 2.0 / 3.0;
                toast.snp.makeConstraints { (make) in
                    make.centerX.equalTo(superview.snp.centerX)
                    make.bottom.equalTo(superview.snp.bottom).offset(-center)
                    make.width.lessThanOrEqualTo(maxWidth)
                }
            }
            else {
                toast.snp.makeConstraints { (make) in
                    make.center.equalTo(superview)
                    make.width.lessThanOrEqualTo(maxWidth)
                }
            }
        }

        toast.alpha = 0
        UIView.animate(withDuration: 0.2, animations: {
            toast.alpha = 1
        }) { (finish) in
            UIView.animate(withDuration: 0.2, delay: 1, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                toast.alpha = 0
            }, completion: {(finish) in
                toast.removeFromSuperview()
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.5) {
            if toast.superview != nil {
                toast.removeFromSuperview()
            }
        }
    }
    
}

public let legoToastGlobalManager = LEGOToastParameter()

public class LEGOToastParameter: NSObject {
    public var font: UIFont?
    public var textColor: UIColor?
    public var backgroundColor: UIColor?
}
