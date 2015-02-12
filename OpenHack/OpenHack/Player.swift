//
//  Player.swift
//  OpenHack
//
//  Created by Eric MA on 31/1/15.
//  Copyright (c) 2015 ECHA. All rights reserved.
//

import Foundation

class Player {
    var row:Int
    var col:Int
    
    
    init(row:Int,col:Int) {
        self.row = row
        self.col = col
    }
    
    func moveRight(){
        row++
    }
    
    func moveLeft(){
        row--
    }
    
    func moveUp(){
        col--
    }
    
    func moveDown(){
        col++
    }
    
    
}