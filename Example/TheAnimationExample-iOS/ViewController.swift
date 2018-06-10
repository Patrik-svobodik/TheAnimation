//
//  ViewController.swift
//  TheAnimationExample
//
//  Created by marty-suzuki on 2018/05/12.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import UIKit
import QuartzCore
import TheAnimation

class ViewController: UIViewController {

    let circleLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        let size = CGSize(width: view.bounds.size.width,
                          height: view.bounds.size.width)

        ConfigureCircleLayer: do {
            let y = (view.bounds.height - size.height) / 2
            circleLayer.frame = CGRect(x: 0, y: y, width: size.width, height: size.height)
            circleLayer.fillColor = UIColor.green.cgColor
            circleLayer.needsDisplayOnBoundsChange = true
            view.layer.addSublayer(circleLayer)
        }

        Animation: do {
            let startSize = CGSize(width: 100, height: 100)
            let inset = (size.width / 2) - (startSize.width / 2)
            let startRect = circleLayer.bounds.insetBy(dx: inset, dy: inset)
            let startPath = UIBezierPath(ovalIn: startRect).cgPath
            circleLayer.path = startPath

            let pathAnimation = BasicAnimation(keyPath: .path, layer: circleLayer)
            pathAnimation.toValue = UIBezierPath(ovalIn: CGRect(origin: .zero, size: size)).cgPath
            pathAnimation.duration = 2
            pathAnimation.timingFunction = .easeOut
            pathAnimation.fillMode = .forwards
            pathAnimation.isRemovedOnCompletion = false

            let fadeOutAnimation = BasicAnimation(keyPath: .opacity, layer: circleLayer)
            fadeOutAnimation.fromValue = 1
            fadeOutAnimation.toValue   = 0
            fadeOutAnimation.duration  = 1
            fadeOutAnimation.beginTime = 2

            let animationGroup = AnimationGroup(layer: circleLayer)
            animationGroup.duration = pathAnimation.duration + fadeOutAnimation.duration
            animationGroup.repeatCount = .infinity
            animationGroup.animations = [pathAnimation, fadeOutAnimation] as! [AnyAnimation]
            animationGroup.fillMode = .forwards
            animationGroup.isRemovedOnCompletion = false
            animationGroup.startAnimating()

            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(7)) {
                animationGroup.stopAnimationg()
            }
        }
    }
}
