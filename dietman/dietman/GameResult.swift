//
//  result.swift
//  testA
//
//  Created by MacUser on H31/01/01.
//  Copyright © 平成31年 tanaka. All rights reserved.
//


import SpriteKit
import GameplayKit
import AVFoundation
import GameKit

let backgroundresult = SKSpriteNode(imageNamed: "result")
let clear = SKSpriteNode(imageNamed: "clear")
let fail = SKSpriteNode(imageNamed: "fail")

class GameResult: SKScene {
    
    var successplayer:AVAudioPlayer!
    var gameoverplayer:AVAudioPlayer!
    
    let successurl = Bundle.main.path(forResource: "success", ofType: "mp3")
    let gameoverurl = Bundle.main.path(forResource: "nc155023", ofType: "mp3")
    
    
    override func didMove(to view: SKView) {
        
        do{
            try successplayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: successurl!))
            successplayer.prepareToPlay()
        }catch{
            print(error)
        }
        do{
            try gameoverplayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: gameoverurl!))
            gameoverplayer.prepareToPlay()
        }catch{
            print(error)
        }
        backgroundresult.zPosition = 0
        
        clear.zPosition = 1
        clear.position.x = -200
        fail.zPosition = 1
        fail.position.x = -200
        
        self.addChild(backgroundresult)
        if gameover == 0 {
            successplayer.play()
            self.addChild(clear)
        }else{
            gameoverplayer.play()
            self.addChild(fail)
        }
        //daynumber
        for c in 0..<daydigits{
            removeChildren(in: [daynumbers[c]])
        }
        numberstore(numbers: day, digits: daydigits)
        daynumbers = []
        for c in 0..<daydigits{
            drawnumbers(numbers:&daynumbers,i:c,number:numbersstore[c], positionX:(CGFloat)(175-45*c), positionY:0, Zposition:3)
        }
        for c in 0..<daydigits{
            addChild(daynumbers[c])
        }
        
        sendscore(dayscore: day)
    }
    
    func sendscore(dayscore:Int){
        let score = GKScore(leaderboardIdentifier: leaderboardId)
        score.value = Int64(dayscore)
        GKScore.report([score]){ error in
            guard error == nil else{
                print("error")
                return
            }
            print("done")
        }
        
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
