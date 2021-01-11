//
//  player.swift
//  test
//
//  Created by MacUser on H30/11/30.
//  Copyright © 平成30年 tanaka. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

var playermodemovenode:[SKSpriteNode] = []
var playermode = 0
//6thin 0fat
var playermovecounter = 0
var playerspeed = 0

var weight = 0
var weightdigits = 0

var thirsty:CGFloat = 0
var playerlifemax:CGFloat = 0

func playermove(playermovemode:inout Int){
    
    //fat
    if playermovemode == 0{
        player = playermodemovenode[playermovemode]
    }else
    if playermovemode == 1{
        player = playermodemovenode[playermovemode]
        playermovemode += 1
    }else
    if playermovemode == 2{
        player = playermodemovenode[playermovemode]
        playermovemode += 1
    }else
    if playermovemode == 3{
        player = playermodemovenode[playermovemode]
        playermovemode += 1
    }else
    if playermovemode == 4{
        player = playermodemovenode[playermovemode]
        playermovemode = 1
    }else
    if playermovemode == 5{
        player = playermodemovenode[playermovemode]
    }else
    if playermovemode == 6{
        player = playermodemovenode[playermovemode]
    }
}
