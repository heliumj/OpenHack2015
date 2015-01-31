//
//  GameScene.swift
//  OpenHack2015_Game
//
//  Created by He Jiang on 1/30/15.
//  Copyright (c) 2015 Team ECHA. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        self.scaleMode = .ResizeFill
        
        // Draw the board
        drawBoard()
        // Add a game piece to the board
        /* if let square = squareWithName("a1") {
            let gamePiece = SKSpriteNode(imageNamed: "Spaceship")
            gamePiece.size = CGSizeMake(24, 24)
            square.addChild(gamePiece)
        }
        if let square = squareWithName("h8") {
            let gamePiece = SKSpriteNode(imageNamed: "Spaceship")
            gamePiece.size = CGSizeMake(24, 24)
            square.addChild(gamePiece)
        } */
    }
    func drawBoard() {
        // Board parameters
        let numRows = 8
        let numCols = 8
        let squareSize = CGSizeMake(32, 32)
        let xOffset:CGFloat = 50
        let yOffset:CGFloat = 50
        // Column characters
        let alphas:String = "abcdefgh"
        // Used to alternate between white and black squares
        var toggle:Bool = false
        for row in 0...numRows-1 {
            for col in 0...numCols-1 {
                // Letter for this column
                let colChar = Array(alphas)[col]
                // Determine the color of square
                // let color = toggle ? SKColor.whiteColor() : SKColor.blackColor()
                let color = SKColor.whiteColor()
                let square = SKSpriteNode(color: color, size: squareSize)
                square.position = CGPointMake(CGFloat(col) * squareSize.width + xOffset,
                    CGFloat(row) * squareSize.height + yOffset)
                // Set sprite's name (e.g., a8, c5, d1)
                square.name = "\(colChar)\(8-row)"
                self.addChild(square)
                toggle = !toggle
            }
            toggle = !toggle
        }
        
    }
    func squareWithName(name:String) -> SKSpriteNode? {
        let square:SKSpriteNode? = self.childNodeWithName(name) as SKSpriteNode?
        return square
    }   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
