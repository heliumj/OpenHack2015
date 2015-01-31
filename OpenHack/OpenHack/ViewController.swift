//
//  ViewController.swift
//  OpenHack
//
//  Created by Eric Ma on 7/26/14.
//  Copyright (c) 2015 ECHA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var helpLabel: UILabel!
    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var turnsLabel: UILabel!
    
    let BOARD_SIZE:Int = 10
    var board:Board
    var squareLabels:[SquareLabel] = []
    
    var turns:Int = 0 {
        didSet {
            if (turns % 2 == 1) {
                self.turnsLabel.text = "Player 1 Turn: \((turns + 1) / 2)"
            }
            else {
                self.turnsLabel.text = "Player 2 Turn : \(turns / 2)"}
            
            
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
        let player2 = Player(row:board.size-1, col:board.size-1)
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
        // swipe
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

    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            let player = players[turns%2]
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                if (player.row<board.size-1) {
                    player.moveRight()
                } else {
                    //alert
                    return
                }
            case UISwipeGestureRecognizerDirection.Left:
                if (player.row>0) {
                    player.moveLeft()
                }  else {
                    //alert
                    return
                }
            case UISwipeGestureRecognizerDirection.Up:
                if (player.col>0) {
                    player.moveUp()
                }  else {
                    //alert
                    return
                }
            case UISwipeGestureRecognizerDirection.Down:
                if (player.col<board.size-1) {
                    player.moveDown()
                }  else {
                    //alert
                    return
                }
            default:
                break
            }
            
            OnSwiped();
        }
    }
    
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

        /* if (distance == 0 || (turns == 30)){
            gameOver() */
        if (distance == 0) {
            self.helpLabel.text = "Player 1 wins!"
            gameOver()
        }
        else if (turns == 30) {
            self.helpLabel.text = "Player 2 wins!"
            gameOver()
        }
        else {
            //alert for distance
            var alert = UIAlertController(title: "Distance", message: "\(distance)", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        

    }

    func gameOver() {
        //alert
        /* var alert = UIAlertController(title: "Game over", message: "Click to continune", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil) */
        performSegueWithIdentifier("nextView", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "nextView") {
            //get reference
            var svc = segue!.destinationViewController as LastViewController;
            
            svc.toPass = helpLabel.text
            
        }
    }

   }

