//
//  object.swift
//  testA
//
//  Created by MacUser on H30/12/16.
//  Copyright © 平成30年 tanaka. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

var objectlist:[SKSpriteNode] = []
var objectdigits = 0
var objectsetcounter = 0

var object = SKSpriteNode()

func randomobject(object:inout SKSpriteNode,randomnumber:Int){
    var setobject = SKSpriteNode()
    if randomnumber == 0{
        setobject = SKSpriteNode(imageNamed: "none")
    }
    if randomnumber == 1{
        setobject = SKSpriteNode(imageNamed: "fountain")
    }
    if randomnumber == 2{
        setobject = SKSpriteNode(imageNamed: "machine")
    }
    object = setobject
}
func objectset(object:inout [SKSpriteNode],objectset:SKSpriteNode,objectnumber:Int,i:Int,positionX:CGFloat,positionY:CGFloat,Zposition:CGFloat){
    let numbernodecopy = objectset.copy() as! SKSpriteNode
    object.append(numbernodecopy)
    object[i].position.x = positionX
    object[i].position.y = positionY
    object[i].zPosition = Zposition
    if objectnumber == 0{
        object[i].name = "none"
    }
    if objectnumber == 1{
        object[i].name = "fountain"
    }
    if objectnumber == 2{
        object[i].name = "machine"
    }
    
}
