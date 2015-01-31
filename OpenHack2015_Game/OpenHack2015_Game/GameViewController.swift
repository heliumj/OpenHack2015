//
//  GameViewController.swift
//  OpenHack2015_Game
//
//  Created by He Jiang on 1/30/15.
//  Copyright (c) 2015 Team ECHA. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            let skView = self.view as SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            // swipe
            skView.presentScene(scene)
            var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
            swipeRight.direction = UISwipeGestureRecognizerDirection.Right
            self.view.addGestureRecognizer(swipeRight)
            
            var swipeDown = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
            swipeDown.direction = UISwipeGestureRecognizerDirection.Down
            self.view.addGestureRecognizer(swipeDown)
            
            var swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
            swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
            self.view.addGestureRecognizer(swipeLeft)
            
            var swipeUp = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
            swipeUp.direction = UISwipeGestureRecognizerDirection.Up
            self.view.addGestureRecognizer(swipeUp)


        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    // swipe
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                println("Swiped right")
            case UISwipeGestureRecognizerDirection.Down:
                println("Swiped down")
            case UISwipeGestureRecognizerDirection.Left:
                println("Swiped left")
            case UISwipeGestureRecognizerDirection.Up:
                println("Swiped up")
            default:
                break
            }
        }
    }
    
    class Player{
    // initiate coordinates
    var corX: Int
    var corY: Int
    }
    
    // movement
    
    func moveRight (){
        if (corX+1)<8  { // teleport implementation
            corX=corX+1
        }
        else {
            // play warning
        }
    
    func moveLeft (){
        if (corX-1)>0  { // teleport implementation
            corX=corX-1
        }
        else {
            // play warning
        }
    
    func moveUp (){
        if (corY+1)<8  { // teleport implementation
            corY=corY+1
        }
        else {
            // play warning
        }
    
    func moveDown (){
        if (corY-1)>0  { // teleport implementation
            corY=corY-1
        }
        else {
            // play warning
        }
    
    func distance(corX


    
        )
    }
}

