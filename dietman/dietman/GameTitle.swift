//
//  GameScene.swift
//  test
//
//  Created by MacUser on H30/10/26.
//  Copyright © 平成30年 tanaka. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit

let title = SKSpriteNode(imageNamed: "title")
let leaderboardId = "dietmanleaderboard"

var selectplayer:AVAudioPlayer!

class GameTitle: SKScene,GKGameCenterControllerDelegate {

    let url = Bundle.main.path(forResource: "select04", ofType: "mp3")

    override func didMove(to view: SKView) {
        
        do{
            try selectplayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
            selectplayer.prepareToPlay()
        }catch{
            print(error)
        }
        
        let startlabel = SKLabelNode(fontNamed: "Chalkduster")
        startlabel.fontSize = 45
        startlabel.zPosition = 3
        startlabel.fontColor = SKColor.black
        let howtolabel = startlabel.copy() as! SKLabelNode
        startlabel.text = "スタート"
        startlabel.name = "start"
        howtolabel.text = "遊び方"
        howtolabel.name = "howto"
        startlabel.position = CGPoint(x: -50,y: -20)
        howtolabel.position = CGPoint(x: 200,y: -20)
        
        let gamecenterlabel = startlabel.copy() as! SKLabelNode
        gamecenterlabel.text = "gamecenter"
        gamecenterlabel.name = "gamecenter"
        gamecenterlabel.position = CGPoint(x: 65,y: -90)

        
        title.zPosition = 2
        self.addChild(title)
        self.addChild(startlabel)
        self.addChild(howtolabel)
        self.addChild(gamecenterlabel)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        let touchnodes = self.nodes(at: pos)
        for tnode in touchnodes{
            if tnode.name == "start"{
                selectplayer.play()
                if let gamescene = GameScene(fileNamed: "GameScene") {
                    // Set the scale mode to scale to fit the window
                    gamescene.scaleMode = .fill
                    
                    // Present the scene
                    self.view?.presentScene(gamescene)
                }
            }
            if tnode.name == "howto"{
                selectplayer.play()
                if let howto = Howto(fileNamed: "Howto") {
                    // Set the scale mode to scale to fit the window
                    howto.scaleMode = .fill
                    
                    
                    // Present the scene
                    self.view?.presentScene(howto)
                }
            }
            if tnode.name == "gamecenter"{
             let vc = GKGameCenterViewController()
                vc.gameCenterDelegate = self
                vc.viewState = .leaderboards
                vc.leaderboardIdentifier = leaderboardId
                self.view?.window?.rootViewController?.present(vc, animated: true, completion: nil)
            }
        }
    }

    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
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
