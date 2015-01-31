# OpenHack2015
Microsoft Open Hack 2015 USC vs. UCLA @ Microsoft LA Office

```
class Player: SomeSprite {
	int x;
	int y;
	bool visible;
	move...
};



//entry
initGame(){
	// Initialize Players
	// Define Grids
	// intialize turnCounter
	takeTurn()
}

updateUI(){
	// see who's turn it is
	// get that player's location
	// redraw 
}

takeTurn(){
	UpdateUI();
	// wait for swipe
}

OnSwipe() {
	// decide who's turn
	player.Move();
	checkTeleport();	
	calculateDistance(); 
	turnCounter++;
	takeTurn();
}

checkTeleport(){
	// Do nothing for now
}

calculateDistance() {
	// Calculate distance
	// if 0, gameOver()
	// alert on screen
}


main(){
	initGame();	

}

```