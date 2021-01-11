//
//  GameScene.swift
//  test
//
//  Created by MacUser on H30/11/01.
//  Copyright © 平成30年 tanaka. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

var water      = SKSpriteNode()
var fountain   = SKSpriteNode(imageNamed: "fountain")
var none       = SKSpriteNode(imageNamed: "none")
var machine    = SKSpriteNode(imageNamed: "machine")
var background = SKSpriteNode(imageNamed: "background")
var backbackground = SKSpriteNode(imageNamed: "background")
var item       = SKSpriteNode(imageNamed: "item")
var player     = SKSpriteNode(imageNamed: "player")

var day = 0
var daydigits = 0
var daycounter = 0

//run = 1 drink = 2
var moderunning = 0
//machine = 1
var machinedrinking = 0
var drinkingcoutner = 0

var selectedobject = 0

var gameover = 0

class GameScene: SKScene {
    
    var avplayer:AVAudioPlayer!
    
    let url = Bundle.main.path(forResource: "nc147497", ofType: "wav")
    
    override func didMove(to view: SKView) {
        
        do{
            try avplayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
            avplayer.prepareToPlay()
        }catch{
             print(error)
        }
        
        gameover = 0
        
        moderunning = 1
        machinedrinking = 0
        drinkingcoutner = 0
        
        selectedobject = -1
        
        thirsty = 0
        playerlifemax = 200
        
        playermode = 1
        playermovecounter = 0
        playerspeed = 5
        
        weight = 8000
        weightdigits = 3
        day = 0
        daydigits = 1
        daycounter = 0
        
        //start = 0
        objectdigits = 0
        objectsetcounter = 0
        
        background.position.x = 0
        background.zPosition = 2
        backbackground.zPosition = 2
        
        item.zPosition  = 4
        //fountain.zPosition = 3
        
        item.position.y = background.size.height/2 - item.size.height/2
        backbackground.position.x = background.size.width
        
        let playerrect = CGRect(x: 0, y: 0, width: 150, height: 200)
        player = imagetonode(imagename: "player.png", triming: playerrect)
        //point
        player.zPosition = 4
        player.position.x = -200
        player.position.y = 0
        
        objectlist = []
        
        //fountain = 1
        objectset(object: &objectlist, objectset: machine,objectnumber: 2, i: objectdigits, positionX: background.size.width/2, positionY: 0, Zposition: 3)
        objectdigits += 1
        
        //playerpicture
        for i in 0..<7{
            let playerdemo:SKSpriteNode
            let playerrect = CGRect(x: 150*i, y: 0, width: 150, height: 200)
            playerdemo = imagetonode(imagename: "player.png", triming: playerrect)
            //point
            playerdemo.zPosition = 4
            playerdemo.position.x = -200
            playerdemo.position.y = 0
            playerdemo.name = "player"
            playermodemovenode.append(playerdemo)
        }
        //numberpicture 0から9の10個
        for i in 1..<11{
            let numberdemo:SKSpriteNode
            let numberrect = CGRect(x: 40*(i-1), y: 0, width: 40, height: 60)
            numberdemo = imagetonode(imagename: "number.png", triming: numberrect)
            //point
            numberdemo.zPosition = 3
            numberdemo.position.x = 0
            numberdemo.position.y = 0
            numbernode.append(numberdemo)
        }
        //weightnumberinit
        for i in 0..<weightdigits{
            let numbernodecopy = numbernode[0].copy() as! SKSpriteNode
            weightnumbers.append(numbernodecopy)
            addChild(weightnumbers[i])
        }
        //daynumberinitmax=2
        for i in 0..<daydigits{
            let numbernodecopy = numbernode[0].copy() as! SKSpriteNode
            daynumbers.append(numbernodecopy)
            addChild(daynumbers[i])
        }
        
        addChild(player)
        addChild(background)
        addChild(backbackground)
        addChild(item)
        addChild(objectlist[0])
        
        avplayer.numberOfLoops = -1
        avplayer.play()
        
        //SKAudioNode
        /*if #available(iOS 9.0, *){
            let music = SKAudioNode(fileNamed: "backgroundmusic")
            addChild(music)
        }else{
            let music = SKAction.playSoundFileNamed("backgroundmusic", waitForCompletion: true)
            let repeatmusic = SKAction.repeat(music, count: 10000)
            self.run(repeatmusic)
        }*/
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        let touchnodes = self.nodes(at: pos)
        
        for tnode in touchnodes{
            if tnode.name == "player"/*tnode.name?.hasPrefix("player") tnode.name?.hasSuffix("san") == true*/            {
                for i in 0..<objectdigits {
                    if abs(player.position.x - objectlist[i].position.x)<(player.size.width/2){
                        if objectlist[i].name == Optional("fountain"){
                            selectedobject = i
                            objectlist[i].zPosition = 0
                            moderunning = 2
                            machinedrinking = 0
                            playerspeed = 0
                            removeChildren(in: [player])
                            playermode = 6
                            playermove(playermovemode: &playermode)
                            addChild(player)
                            objectlist[i].name = "usedfountain"
                        }
                    }
                }
            }
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
        //water flont
        if thirsty < playerlifemax {
            removeChildren(in: [water])
            let imagerect = CGRect(x: 0, y: 0, width: playerlifemax-thirsty, height: 60)
            water = imagetonode(imagename: "water.png", triming: imagerect)
            water.zPosition = 3
            water.position.y = background.size.height/2 - water.size.height/2
            water.position.x = -18
            addChild(water)
            water.position.x = water.position.x - thirsty/2
        }
        ///////////////////////////////////////////////////////////////////////
        //weightnumber
        for c in 0..<weightdigits{
            removeChildren(in: [weightnumbers[c]])
        }
        let tempweight = Int(weight/10)
        numberstore(numbers: tempweight, digits: weightdigits)
        weightnumbers = []
        for c in 0..<weightdigits{
            drawnumbers(numbers:&weightnumbers,i:c,number:numbersstore[c], positionX:-(CGFloat)(280+45*c), positionY:160, Zposition:3)
        }
        for c in 0..<weightdigits{
            addChild(weightnumbers[c])
        }
        
        //machineselect
        if ((thirsty/playerlifemax) * 100) > 90 {
            for i in 0..<objectdigits {
                if abs(player.position.x - objectlist[i].position.x)<(player.size.width/2){
                    if objectlist[i].name == Optional("machine"){
                        if thirsty > 20{
                            selectedobject = i
                            objectlist[i].zPosition = 0
                            moderunning = 2
                            machinedrinking = 1
                            playerspeed = 0
                            removeChildren(in: [player])
                            playermode = 5
                            playermove(playermovemode: &playermode)
                            addChild(player)
                            objectlist[i].name = "usedmachine"
                        }
                    }
                }
            }
        }
    
        //drinking
            if moderunning == 2{
                thirsty -= 1
                //machine
                if machinedrinking == 1{
                    weight += 1
                    if weight >= 9999{
                        weight = 9999
                    }
                }
                if thirsty <= 0 {
                    objectlist[selectedobject].zPosition = 3
                    objectlist[selectedobject].position.x = player.position.x
                    thirsty = 0
                    moderunning = 1
                    playermode = 1
                    playerspeed = 5
                }
            }
 
        //daynumber
        for c in 0..<daydigits{
            removeChildren(in: [daynumbers[c]])
        }
        if day>9{
            daydigits = 2
        }
        if day>99{
            daydigits = 3
        }
        if day>999{
            daydigits = 4
        }
        if day>9999{
            daydigits = 5
        }
        numberstore(numbers: day, digits: daydigits)
        daynumbers = []
        for c in 0..<daydigits{
            drawnumbers(numbers:&daynumbers,i:c,number:numbersstore[c], positionX:(CGFloat)(320-45*c), positionY:160, Zposition:3)
        }
        for c in 0..<daydigits{
            addChild(daynumbers[c])
        }
        daycounter += 1
        if daycounter > 50 {
            day += 1
            daycounter = 0
        }

        //gameovergoal
        //not100daynomove
        if day > 9999{
            avplayer.stop()
            if let gameresult = GameResult(fileNamed: "GameResult") {
                // Set the scale mode to scale to fit the window
                gameresult.scaleMode = .fill
                gameover = 1
                // Present the scene
                self.view?.presentScene(gameresult)
            }
        }
        
       ///////////////////////////////////////////////////////////////////
        //playerunning
        if moderunning == 1{
            //playermove
            if playermovecounter > playerspeed{
                removeChildren(in: [player])
                playermove(playermovemode: &playermode)
                addChild(player)
                //thirstyweightdown
                if ((thirsty/playerlifemax) * 100) > 50 && ((thirsty/playerlifemax) * 100) < 80 {
                    playermovecounter = 0
                    weight -= 2
                    thirsty += 1
                    
                }else
                if ((thirsty/playerlifemax) * 100) >= 80 {
                    playermovecounter = 0
                    weight -= 5
                    thirsty += 1
                    
                }else{
                    playermovecounter = 0
                    weight -= 1
                    thirsty += 1
                }
            }
            playermovecounter += 1
            objectsetcounter += 1
        }
        
       
        
        //backgroundmove
        background.position.x -= (CGFloat)(playerspeed)
        backbackground.position.x -= (CGFloat)(playerspeed)
        if background.position.x <= -(background.size.width){
            background.position.x = 0
            backbackground.position.x = background.size.width
        }
        //objectstart
        for i in 0..<objectdigits {
            objectlist[i].position.x -= (CGFloat)(playerspeed)
        }
        if objectlist[0].position.x <= -((background.size.width)/2+(objectlist[0].size.width/2)){
            removeChildren(in: [objectlist[0]])
            objectdigits -= 1
            objectlist.remove(at: 0)
        }
        if objectsetcounter > 50{
            var objectnumber = 0
            objectnumber = Int(arc4random()%3)
            //onone 1fountain 2machine
            randomobject(object: &object, randomnumber: objectnumber)
            objectset(object: &objectlist, objectset: object,objectnumber:objectnumber, i: objectdigits, positionX: background.size.width/2, positionY: 0, Zposition: 3)
            addChild(objectlist[objectdigits])
            objectdigits += 1
            objectsetcounter = 0
        }
        
        
        //playermove
        //goal
        if weight < 6990{
            weight = 6990
            avplayer.stop()
            if let gameresult = GameResult(fileNamed: "GameResult") {
                // Set the scale mode to scale to fit the window
                gameresult.scaleMode = .fill
                gameover = 0
                // Present the scene
                self.view?.presentScene(gameresult)
            }
        }
        
    }
}
