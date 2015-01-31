//
//  ViewController.swift
//  Mineswifter
//
//  Created by Benjamin Reynolds on 7/26/14.
//  Copyright (c) 2014 MakeGamesWithUs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var turnsLabel: UILabel!
    
    let BOARD_SIZE:Int = 10
    var board:Board
    var squareLabels:[SquareLabel] = []
    
    var turns:Int = 0 {
        didSet {
            self.turnsLabel.text = "Turns: \(turns)"
            self.turnsLabel.sizeToFit()
        }
    }
    
    
    //MARK: Initialization
    
    required init(coder aDecoder: NSCoder)
    {
        self.board = Board(size: BOARD_SIZE)
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.initializeBoard()
        self.startNewGame()
    }
    
    func initializeBoard() {
        for row in 0 ..< board.size {
            for col in 0 ..< board.size {
                
                let square = board.squares[row][col]
                
                let squareSize:CGFloat = self.boardView.frame.width / CGFloat(BOARD_SIZE)
                
                let squareLabel = SquareLabel(squareModel: square, squareSize: squareSize);
                    squareLabel.setTitle("   ", forState: .Normal)

                squareLabel.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
                //squareLabel.addTarget(self, action: "squareLabelPressed:", forControlEvents: .TouchUpInside)
                self.boardView.addSubview(squareLabel)
                
                self.squareLabels.append(squareLabel)
            }
        }
    }
    
    func updateBoard() {
        // see who's turn it is
        // get that player's location
        // redraw
        
        // resets the board with new mine locations & sets isRevealed to false for each square
        self.board.resetBoard()
        // iterates through each button and resets the text to the default value
        for squareLabel in self.squareLabels {
                squareLabel.setTitle("  ", forState: .Normal)
        }
        self.squareLabels[0].setTitle(" O ", forState: .Normal)
        self.squareLabels[(board.size)*(board.size)-1].setTitle(" O ", forState: .Normal)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startNewGame(){
        // Initialize Players
        // Define Grids
        // intialize turnCounter
        self.updateBoard()

        takeTurn()
    }
    
    func takeTurn(){
        updateBoard();
        // wait for swipe
    }
    
    func OnSwipe() {
        // decide who's turn
        //player.Move();
        checkTeleport();
        calculateDistance();
        turns++;
        takeTurn();
    }
    
    func checkTeleport(){
        // Do nothing for now
    }
    
    func calculateDistance() {
        // Calculate distance
        // if 0, gameOver()
        // alert on screen
    }

    //MARK: Button Actions
    
//    @IBAction func newGamePressed() {
//        println("new game")
//        self.startNewGame()
//    }
//    
//    func squareLabelPressed(sender: SquareLabel) {
//        //        println("Pressed row:\(sender.square.row), col:\(sender.square.col)")
//        //        sender.setTitle("", forState: .Normal)
//        
//        if !sender.square.isRevealed {
//            sender.square.isRevealed = true
//            sender.setTitle("\(sender.getLabelText())", forState: .Normal)
//            self.turns++
//        }
//        
//        if sender.square.isMineLocation {
//            self.minePressed()
//        }
//    }
    

    
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        //start new game when the alert is dismissed
        self.startNewGame()
    }
    
    
    
}

