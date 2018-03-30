
import java.util.ArrayList;
import java.util.List;
import core.Player;
import core.model.Grid;
import core.model.Spot;

/*
import java.util.ArrayList;
import java.util.List;
import core.Player;
import core.model.Grid;
import core.model.Spot;
 */


public aspect FinJeuWonList {
	

	 
	 pointcut listWon(int x, int y, int dx, int dy, Player player, Grid grid) : 
	 call(boolean core.model.Grid.isWonBy(int, int, int, int, Player)) 
	 && args(x, y, dx, dy, player)
	 && target(grid);
	 
	 before(int x, int y, int dx, int dy, Player player, Grid grid) : listWon(x, y, dx, dy, player, grid){
	 
	 	
	 // consecutive places occupied by the given player
	 		
	 		final List<Spot> row = new ArrayList<>(5);
	 		int size = 15;

	 		// check left/lower side of (x,y)
	 		int sx = x; // starting x and y
	 		int sy = y; // i.e., (sx, sy) <----- (x,y)
	 		while (!(dx > 0 && sx < 0) && !(dx < 0 && sx >= size) && !(dy > 0 && sy < 0) && !(dy < 0 && sy >= size)
	 				&& grid.isOccupiedBy(sx, sy, player) && row.size() < 5) {
	 			row.add(grid.at(sx, sy));
	 			sx -= dx;
	 			sy -= dy;
	 		}

	 		// check right/higher side of (x,y)
	 		int ex = x + dx; // ending x and y
	 		int ey = y + dy; // i.e., (x,y) -----> (ex, ey)
	 		while (!(dx > 0 && ex >= size) && !(dx < 0 && ex < 0) && !(dy > 0 && ey >= size) && !(dy < 0 && ey < 0)
	 				&& grid.isOccupiedBy(ex, ey, player) && row.size() < 5) {
	 			row.add(grid.at(ex, ey));
	 			ex += dx;
	 			ey += dy;
	 		}

	 		if (row.size() >= 5) {
	 			System.out.println("Winning sequence: "+row);
	 		}
	 		
	 	
	 }
	 
	 
	
}
