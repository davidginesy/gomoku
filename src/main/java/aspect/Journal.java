import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import javafx.stage.Stage;
import core.Player;
import core.model.*;
import core.GridChangeListener;
import ui.App;
import javafx.scene.paint.Color;

public aspect Journal {
	String filename = "Journal.txt";
	ArrayList<Integer> xList = new ArrayList<Integer>();
	ArrayList<Integer> yList = new ArrayList<Integer>();
	
	pointcut captureCallParameters(int x, int y, Player player) : 
	      call(void Grid.placeStone(int,int,Player)) && 
	      args(x,y,player);
	
	   // Advice declaration
	   before(int x,int y, Player player) : captureCallParameters(x,y,player)
	   {
		   // System.out.println("Le joueur " + player.getName() + " a joué en " + x + ", " + y);
		   xList.add(x);
		   yList.add(y);
		   try
		   {
		      
		       FileWriter fw = new FileWriter(filename,true); //the true will append the new data
		       fw.write("Le joueur " + player.getName() + " a joué en " + x + ", " + y +"\n");//appends the string to the file
		       fw.close();
		   }
		   catch(IOException ioe)
		   {
		       System.err.println("IOException: " + ioe.getMessage());
		   }
	   }
	   
	 pointcut gameOver(Player player) :
			call(void GridChangeListener.gameOver(Player)) && args(player);
	 
	 after(Player player) : gameOver(player){
		 try
		   {
		       FileWriter fw = new FileWriter(filename,true); //the true will append the new data
		       fw.write("Game Over ------> "+player.getName() + " played : ");//appends the string to the file
		       for(int i = 0; i < xList.size(); i++) {
				fw.write(xList.get(i)+","+yList.get(i)+" ; ");
		       }
		       fw.write("\n");
		       fw.close();
		   }
		   catch(IOException ioe)
		   {
		       System.err.println("IOException: " + ioe.getMessage());
		   }
	 }
	 
	 pointcut clearFile() :
		 call(Player.new(String,Color));
	 
	 before() : clearFile(){
		 try {
			new FileWriter(filename).close();
			
		}  catch(IOException ioe)
		   {
		       System.err.println("IOException: " + ioe.getMessage());
		   }
	 }
	 
}

