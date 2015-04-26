//
//  GameScene.swift
//  AartiParikh
//
//  Created by Aarti Parikh on 4/24/15.
//  Copyright (c) 2015 Aarti Parikh. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var lastUpdateTime: NSTimeInterval = 0
    let backgroundMovePointsPerSec: CGFloat = 30.0
    var dt: NSTimeInterval = 0
    var backgroundLayer = SKNode()
    var education = false
    var projects = false
    var interests = false
    var midpointx: CGFloat = 0
    var midpointy: CGFloat = 0
    
    var textView = UITextView( frame:CGRectMake(0, 20, 200, 40))
    var ellipse = SKShapeNode(path: CGPathCreateWithRoundedRect(CGRectMake(400, 250, 800, 600),4,4,nil))
    let tileLabel = SKLabelNode(fontNamed:"ThrowMyHandsUpintheAir")
    
    override func didMoveToView(view: SKView) {
        midpointx = self.size.width/2
        midpointy = self.size.height/2

        
        //textView for resume tiles
        textView = UITextView( frame:CGRectMake(midpointx, midpointy+20, 750, 390))
        textView.center = view.center
        textView.textColor = UIColor.blackColor()
        
        textView.font = UIFont(name: "Usherwood-Book", size: 25)

        textView.backgroundColor = UIColor(rgba: "#F6F6F6")
        
        ellipse = SKShapeNode(path: CGPathCreateWithRoundedRect(CGRectMake(midpointx - 400, midpointy-200, 800, 450),4,4,nil))
        ellipse.strokeColor = UIColor(rgba: "#FF6961")
        ellipse.lineWidth = 8
        ellipse.fillColor = UIColor(rgba: "#F6F6F6")
        ellipse.zPosition = 5
//        ellipse.alpha = 0.8
        ellipse.name = "tile"
        
        tileLabel.color = SKColor.whiteColor()
        tileLabel.fontSize = 40;
        tileLabel.fontColor = SKColor.redColor()
        tileLabel.position = CGPoint(x:CGRectGetMidX(self.frame) , y:CGRectGetMidY(self.frame)+200);
        
        
        // Sky
        let skyTexture = SKTexture(imageNamed: "sky")
        let sky = SKSpriteNode(texture: skyTexture)
        sky.name = "sky"
        sky.position = CGPoint(x: midpointx, y: midpointy )
        sky.zPosition = -1
        self.addChild(sky)
        
        // Bird Particles
        let birds: SKEmitterNode = SKEmitterNode(fileNamed: "birds")
        birds.position = CGPoint(x: 0, y:0)
        sky.addChild(birds)
        
        // Intro
        let myLabel = SKLabelNode(fontNamed:"ThrowMyHandsUpintheAir")
        myLabel.text = "Hello, This is Aarti!";
        myLabel.fontSize = 40;
        myLabel.fontColor = SKColor.redColor()
        myLabel.position = CGPoint(x:0 , y:300);
        myLabel.zPosition = 4
        sky.addChild(myLabel)
        
        // Parent node for all hills
        let hillsnode = SKNode()
        hillsnode.name = "hill"
        
        // Small Hill
        let shillTexture = SKTexture(imageNamed: "smallhill")
        var shill = SKSpriteNode(imageNamed: "smallhill" )
        shill.name = "shill\(0)"
        shill.position = CGPoint(x: CGFloat(0)*(-shillTexture.size().width), y: -shillTexture.size().height*0.8)
        shill.zPosition = 2
        
        // Cow on Small Hill
        var cow = SKSpriteNode(imageNamed: "cow" )
        cow.name = "cow\(0)"
        cow.position = CGPoint(x: 140 , y: 80)
        cow.zPosition = 2
        shill.addChild(cow)
        
        // Trees on Small Hill
        for i in 0...3 {
            var tree = SKSpriteNode(imageNamed: "tree" )
            tree.name = "tree\(i)"
            tree.position = CGPoint(x: 500+random() % 10*20, y: 80+random() % 10*10)
            tree.zPosition = 2
            shill.addChild(tree)
        }
        hillsnode.addChild(shill)
        
        // Flipped Small Hill for Parallax
        shill = SKSpriteNode(imageNamed: "flippedsmallhill" )
        shill.name = "shill\(1)"
        shill.position = CGPoint(x: CGFloat(1)*(shillTexture.size().width), y: -shillTexture.size().height*0.8)
        shill.zPosition = 2
        
        // school on flipped small hill
        var school = SKSpriteNode(imageNamed: "school" )
        school.name = "school\(0)"
        school.position = CGPoint(x: -400 , y: 80)
        school.zPosition = 2
        shill.addChild(school)
        hillsnode.addChild(shill)
        
        // Large hill
        let lhillTexture = SKTexture(imageNamed: "flippedlargehill")
        var lhill = SKSpriteNode(imageNamed: "largehill" )
        lhill.name = "lhill\(1)"
        lhill.position = CGPoint(x: CGFloat(0)*(-lhillTexture.size().width), y: -lhillTexture.size().height/2)
        lhill.zPosition = 1
        
        // Church on large hill
        var church = SKSpriteNode(imageNamed: "church" )
        church.name = "church"
        church.position = CGPoint(x: -1000, y: 200)
        church.zPosition = 2
        lhill.addChild(church)
        
        // Trees on large hill
        for i in 0...3 {
            var tree = SKSpriteNode(imageNamed: "tree" )
            tree.name = "tree\(i)"
            tree.position = CGPoint(x: 0+random() % 10*20, y: 200+random() % 10*10)
            tree.zPosition = 2
            lhill.addChild(tree)
        }
        
        hillsnode.addChild(lhill)
        
        // Large Flipped Hill
        lhill = SKSpriteNode(imageNamed: "flippedlargehill" )
        lhill.name = "lhill\(2)"
        lhill.position = CGPoint(x: CGFloat(1)*(lhillTexture.size().width), y: -lhillTexture.size().height/2)
        lhill.zPosition = 1
        hillsnode.addChild(lhill)
        sky.addChild(hillsnode)
        
        
        // The Train
        let trainScale = CGFloat(0.5)
        backgroundLayer.name = "train"
        backgroundLayer.position = CGPoint(x: midpointx, y: midpointy )
        backgroundLayer.zPosition = 2
        backgroundLayer.setScale(trainScale)
        
        self.addChild(backgroundLayer)
        
        // Layout tracks
        let m = SKTexture(imageNamed: "track")
        let noTracks = 6
        for i in 0...noTracks {
            var m1 = SKSpriteNode(texture: m)
            m1.name = "track\(i)"
            var xpos = CGFloat(i-noTracks/2) * (m.size().width)
            m1.position = CGPoint(x: xpos, y: (-midpointy/trainScale)+30)
            m1.zPosition = 1
            backgroundLayer.addChild(m1)
        }
        var m2 = SKTexture(imageNamed: "Engines")
        let engine = SKSpriteNode(texture: m2)
        engine.name = "Engines"
        engine.position = CGPoint(x: 400, y:-620)
        engine.zPosition = 1
        backgroundLayer.addChild(engine)
        
        m2 = SKTexture(imageNamed: "wheel")
        var m1 = SKSpriteNode(texture: m2)
        m1.name = "wheel1"
        m1.position = CGPoint(x: 0-100, y:0-70)
        m1.zPosition = 2
        m1.zRotation = CGFloat(M_PI)
        engine.addChild(m1)
        
        var m3 = SKSpriteNode(texture: m2)
        m3.name = "wheel2"
        m3.position = CGPoint(x: 0-15, y:0-70)
        m3.zPosition = 2
        m3.zRotation = CGFloat(M_PI)
        engine.addChild(m3)
        
        var cr = SKSpriteNode(imageNamed: "couplingrods")
        cr.name = "rods"
        cr.position = CGPoint(x: 0-9, y:0-62)
        cr.zPosition = 2
        engine.addChild(cr)
        
        
        let smoke1: SKEmitterNode = SKEmitterNode(fileNamed: "smoke")
        smoke1.position = CGPoint(x: 0+100, y:108)
        engine.addChild(smoke1)
        
        var cartext = ["Education", "Interests", "Projects"]
        // Train Cars
        for i in 0...2 {
            var car = SKSpriteNode(imageNamed: "car")
            car.name = "car\(i)"
            car.position = CGPoint(x: engine.position.x - engine.size.width+95-285*CGFloat(i), y:engine.position.y-40)
            car.xScale = 1.2
            car.yScale = 1.2
            var myLabel = SKLabelNode(fontNamed:"Usherwood-Book")
            myLabel.text = cartext[i]
            myLabel.name = car.name
            myLabel.fontSize = 40
            myLabel.fontColor = SKColor.whiteColor()
            myLabel.position = CGPoint(x:0 , y:-5)
            myLabel.zPosition = 4
            car.addChild(myLabel)
            backgroundLayer.addChild(car)
        }
        
        var caboose = SKSpriteNode(imageNamed: "caboose")
        caboose.name = "caboose"
        caboose.position = CGPoint(x: -750, y:engine.position.y-40)
        caboose.xScale = 1.2
        caboose.yScale = 1.2
        backgroundLayer.addChild(caboose)
        
        
        var rotate = SKAction.rotateByAngle(CGFloat(M_PI_4), duration:0.5 )
        let repeatAction = SKAction.repeatActionForever(rotate)
        m1.runAction(repeatAction, withKey: "rotate")
        m3.runAction(repeatAction, withKey: "rotate")
        
    }
    
    func moveMountains() {
        var backgroundVelocity =  CGPoint(x: -backgroundMovePointsPerSec, y: 0)
        var sky = self.childNodeWithName("sky") as! SKSpriteNode
        var hillnode = sky.childNodeWithName("hill") as SKNode?
        
        for i in 0...(hillnode!.children.count-1) {
            let n = hillnode!.children[i] as! SKSpriteNode
            var amountToMove = CGPoint( x: backgroundVelocity.x * CGFloat(dt), y: backgroundVelocity.y * CGFloat(dt) )
            leftToRight(n, amountToMove: amountToMove )
        }
    }
    
    func leftToRight(n:SKSpriteNode,amountToMove:CGPoint ) {
        n.position.x -= amountToMove.x
        n.position.y -= amountToMove.y
        if n.position.x >  (n.size.width) {
            n.position.x = -n.size.width + 45 // This is a hack- there is a gap due to timing issues
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            var node = self.nodeAtPoint(location)
            
            if ( education || interests || projects)
            {
                println( "Toggle Tile" )
                education = false
                interests = false
                projects = false
                textView.removeFromSuperview()
                self.childNodeWithName("tile")?.removeAllChildren()
                self.childNodeWithName("tile")?.removeFromParent()
            }
            else if (node.name == "car0" && !education){
                education = true
                var car0 = backgroundLayer.childNodeWithName("car0") as! SKSpriteNode
                tileLabel.text = "Education & Experience"
                ellipse.addChild(tileLabel)
                textView.text = "Co-Founder/CTO of KiteReaders\n\nFormer Sr. Engineer at Yahoo! on Advertising Platform\n\nWorked in Enterprise Healthcare at Mckesson\n\nBachelor of Electrical Engineering with Computer Science Minor\nCleveland State University, Magna Cum Laude\n\nCS Courses in Distributed Systems and Discrete Structures\nStanford University\n"
                textView.sizeToFit()

                view!.addSubview(textView)
                self.addChild(ellipse)
            }
            else if (node.name == "car1" && !interests ) {
                interests = true
                var car1 = backgroundLayer.childNodeWithName("car1") as! SKSpriteNode
                tileLabel.text = "Interests"
                ellipse.addChild(tileLabel)
                textView.text = "Reading: Children's books, biographies, history and science fiction.\n\nProgramming Languages: Learning new programming languages. I have programmed in Lua, Java, Ruby and am now ramping up on Swift. I had quite a bit of fun with SpriteKit while building this app.\n\nWriting: I blog about education and children's books.\n\nTeaching: Math & CS. Taught Lua programming to a few kids in my neighborhood Summer 2014"
                textView.sizeToFit()
                view!.addSubview(textView)
                self.addChild(ellipse)
            }
            else if (node.name == "car2" && !projects ) {
                projects = true
                var car2 = backgroundLayer.childNodeWithName("car2") as! SKSpriteNode
                ellipse.addChild(tileLabel)
                tileLabel.text = "Projects"
                textView.text = "Being Global: a tri-lingual children's app, won an Appy award in the Multicultural Category, beating Disney's Small Wonder app.\n\nKitePress: Platform for managing, distributing and creating fixed-layout ebooks\n\nDatastructures in Ruby: Presented to Silicon Valley Ruby meetup\n\nExercism: Started the Lua track and contributed to several exercises"
                textView.editable = false;
                textView.dataDetectorTypes = UIDataDetectorTypes.Link;
                textView.sizeToFit()
                view!.addSubview(textView)
                self.addChild(ellipse)
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else {
            dt = 0
        }
        lastUpdateTime = currentTime
        moveMountains()
    }
}
