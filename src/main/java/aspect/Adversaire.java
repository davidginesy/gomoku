import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;

import core.Player;
import javafx.scene.paint.Color;

@Aspect
public class Adversaire {
	
	private Player playerRed = new Player("Mr. Red", Color.RED);
	private Player playerGreen = new Player("Mr. Green", Color.GREEN);
	private boolean  bool = true ;
	
	
	@Around("execution (Player ui.App.getCurrentPlayer())")
	public Player getCurrentPlayer() {
					if(bool) {
						
						bool = false;
						return playerRed;
			
					}else {
						
						bool = true;
						return playerGreen;
					}
			}

}
