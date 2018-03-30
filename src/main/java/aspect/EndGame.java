import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;

import core.Player;
import core.model.Grid;
import javafx.scene.paint.Color;

@Aspect
public class EndGame {
	
	
	 @Around("execution (void core.model.Grid.placeStone(int, int, Player)) && target(grid)")
	 public void checkEnd(ProceedingJoinPoint thisJoinPoint, Grid grid){
		 if( !(grid.isGameOver()) )
		 {
			 thisJoinPoint.proceed();
		 }
	 }

}
