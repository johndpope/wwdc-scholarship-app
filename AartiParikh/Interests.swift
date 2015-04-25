//
//  Interests.swift
//  AartiParikh
//
//  Created by Aarti Parikh on 4/24/15.
//  Copyright (c) 2015 kitereaders. All rights reserved.
//


import Foundation
import SpriteKit


class InterestsScene: SKScene {
    
    init(size: CGSize, won:Bool) {
        
        super.init(size: size)

        // 1
        backgroundColor = UIColor(rgba: "#FF6961")
        // 2
        var message = won ? "You Won!" : "You Lose :["
        
        // 3
        let label = SKLabelNode(fontNamed: "ThrowMyHandsUpintheAir")
        label.text = message
        label.fontSize = 40
        label.fontColor = SKColor.blackColor()
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(label)
        
        // 4
        runAction(SKAction.sequence([
            SKAction.waitForDuration(3.0),
            SKAction.runBlock() {
                // 5
                let reveal = SKTransition.flipHorizontalWithDuration(0.5)
                let scene = GameScene(size: size)
                self.view?.presentScene(scene, transition:reveal)
            }
            ]))
        
    }
    
    // 6
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
