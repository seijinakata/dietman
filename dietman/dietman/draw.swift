//
//  draw.swift
//  test
//
//  Created by MacUser on H30/11/06.
//  Copyright © 平成30年 tanaka. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

var weightnumbers:[SKSpriteNode] = []
var daynumbers:[SKSpriteNode] = []
var hournumbers:[SKSpriteNode] = []

var numbersstore:[Int] = []

var numbernode:[SKSpriteNode] = []

func imagetonode(imagename:String,triming:CGRect)->SKSpriteNode{
    let i = trimingimage(image: UIImage(named: imagename)!, trimingArea: triming)
    let texture = SKTexture(image: i)
    let trimNode = SKSpriteNode(texture: texture)
    return trimNode
}

func trimingimage(image:UIImage,trimingArea:CGRect)->UIImage{
    let imgRef = image.cgImage?.cropping(to: trimingArea)
    let trimImage = UIImage(cgImage: imgRef!, scale: image.scale, orientation: image.imageOrientation)
    return trimImage
}

func numberstore(numbers:Int,digits:Int){
    numbersstore = []
    var numberbasic = numbers
    var number = 0
    for _ in 0..<digits {
        number =  numberbasic%10
        numbersstore.append(number)
        numberbasic =  numberbasic/10
    }
}

func drawnumbers(numbers:inout [SKSpriteNode], i:Int,number:Int,positionX:CGFloat,positionY:CGFloat,Zposition:CGFloat){
    let numbernodecopy = numbernode[number].copy() as! SKSpriteNode
    numbers.append(numbernodecopy)
    numbers[i].position.x = positionX
    numbers[i].position.y = positionY
    numbers[i].zPosition = Zposition
}
