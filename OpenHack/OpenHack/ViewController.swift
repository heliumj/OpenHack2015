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
    
    var players :[Player] = []
    
    var portals : [Int:Int] = [13:32,87:46]
    
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
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startNewGame(){
        // Initialize Players
        let player1 = Player(row:0, col:0)
        let player2 = Player(row:board.size, col:board.size)
        players.append(player1)
        players.append(player2)

        takeTurn()
    }
    
    func updateBoard() {
        
        // iterates through each button and resets the text to the default value
        for squareLabel in self.squareLabels {
            squareLabel.setTitle("  ", forState: .Normal)
        }
        // see who's turn it is
        // get that player's location
        // redraw
        for (oneEnd,Another) in portals {
            self.squareLabels[oneEnd].setTitle(" # ", forState: .Normal)
            self.squareLabels[Another].setTitle(" * ", forState: .Normal)

        }
        self.squareLabels[(players[turns%2].row+players[turns%2].col*board.size)].setTitle(" O ", forState: .Normal)
    }
    
    func takeTurn(){
        updateBoard();
        // wait for swipe
    }
    
    //four swipe input handler with boundry check
    
    // decide who's turn and call the corresponding move

    
    func OnSwiped() {
        //player.Move();
        checkTeleport();
        updateBoard();
        calculateDistance();
        turns++;
        takeTurn();
    }
    
    func checkTeleport(){
        for (oneEnd,Another) in portals {
            for player in players {
                if (player.row + player.col*board.size == oneEnd){
                    player.row = Another%board.size
                    player.col = Another/board.size
                }
            }
        }
    }
    
    func calculateDistance() {
        // Calculate distance
        let rowDistance = abs(players[0].row - players[1].row)
        let colDistance = abs(players[0].col - players[1].col)
        let distance = rowDistance + colDistance

        if (distance == 0){
            gameOver()
        } else {
            //alert for distance
        }
    }
    
    func gameOver() {
    
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
    

    
//    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
//        //start new game when the alert is dismissed
//        self.startNewGame()
//    }
    
    
    
}

