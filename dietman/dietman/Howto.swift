//
//  howto.swift
//  testA
//
//  Created by Owner on 10/23/1397 AP.
//  Copyright © 1397 AP tanaka. All rights reserved.
//

//
//  GameScene.swift
//  test
//
//  Created by MacUser on H30/10/26.
//  Copyright © 平成30年 tanaka. All rights reserved.
//

import SpriteKit
import GameplayKit

let fontsize:CGFloat = 25
let weightfont:CGFloat = 80
let thirstyfont:CGFloat = 80
let fountainfont:CGFloat = -10
let howto = SKSpriteNode(imageNamed: "howto")

class Howto: SKScene {
    
    
    override func didMove(to view: SKView) {
        howto.zPosition = 2
        let howtoweight = SKLabelNode(fontNamed: "Chalkduster")
        howtoweight.fontSize = fontsize
        howtoweight.zPosition = 3
        howtoweight.fontColor = SKColor.black
        let howtoweight2 = howtoweight.copy() as! SKLabelNode
        let howtothirsty = howtoweight.copy() as! SKLabelNode
        let howtofountaindrinking = howtoweight.copy() as! SKLabelNode
        let howtomachinedrinking = howtoweight.copy() as! SKLabelNode
        let howtomachinedrinking2 = howtoweight.copy() as! SKLabelNode
        let howtomachinedrinking3 = howtoweight.copy() as! SKLabelNode
        howtoweight.text = "体重６０台"
        howtoweight2.text = "を目指そう"
        howtothirsty.text = "水分を減らすと体重が早く落ちる"
        howtofountaindrinking.text = "キャラにタップで水飲み"
        howtomachinedrinking.text = "水分が少なすぎると"
        howtomachinedrinking2.text = "ジュースを勝手に飲む"
        howtomachinedrinking3.text = "体重が戻るぞ"
        
        howtoweight.position = CGPoint(x: -300,y: weightfont)
        howtoweight2.position = CGPoint(x: -300,y: weightfont-fontsize)
        
        howtothirsty.position = CGPoint(x: 60, y: thirstyfont)
        
        howtofountaindrinking.position = CGPoint(x: 30, y: fountainfont)
        howtomachinedrinking.position = CGPoint(x: 30, y: fountainfont-fontsize)
        howtomachinedrinking2.position = CGPoint(x: 30, y: fountainfont-fontsize*2)
        howtomachinedrinking3.position = CGPoint(x: 30, y: fountainfont-fontsize*3)
        
        self.addChild(howto)
        self.addChild(howtoweight)
        self.addChild(howtoweight2)
        self.addChild(howtothirsty)
        self.addChild(howtofountaindrinking)
        self.addChild(howtomachinedrinking)
        self.addChild(howtomachinedrinking2)
        self.addChild(howtomachinedrinking3)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let gametitle = GameTitle(fileNamed: "GameTitle") {
            // Set the scale mode to scale to fit the window
            gametitle.scaleMode = .fill
            
            
            // Present the scene
            self.view?.presentScene(gametitle)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
