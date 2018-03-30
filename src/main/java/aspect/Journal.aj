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
	ArrayList<Integer> xListRed = new ArrayList<Integer>();
	ArrayList<Integer> yListRed = new ArrayList<Integer>();
	ArrayList<Integer> xListGreen = new ArrayList<Integer>();
	ArrayList<Integer> yListGreen = new ArrayList<Integer>();
	
	pointcut captureCallParameters(int x, int y, Player player) : 
	      call(void Grid.placeStone(int,int,Player)) && 
	      args(x,y,player);
	
	   // Advice declaration
	   before(int x,int y, Player player) : captureCallParameters(x,y,player)
	   {
		   System.out.println("Le joueur " + player.getName() + " a joue en " + x + ", " + y);
		   if(player.getName().equals("Mr. Red")){
			   xListRed.add(x);
			   yListRed.add(y);
		   }
		   else if(player.getName().equals("Mr. Green")) {
			   xListGreen.add(x);
			   yListGreen.add(y);
		   }
		   
		   try
		   {
		      
		       FileWriter fw = new FileWriter(filename,true); //the true will append the new data
		       fw.write("Le joueur " + player.getName() + " a joue en " + x + ", " + y +"\n");//appends the string to the file
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
		       fw.write("Game Over ------> Mr. Green played : ");
		       for(int i = 0; i < xListGreen.size(); i++) {
				fw.write(xListGreen.get(i)+","+yListGreen.get(i)+" ; ");
		       }
		       fw.write("\n");
		       fw.write("Game Over ------> Mr. Red played : ");
		       for(int i = 0; i < xListRed.size(); i++) {
				fw.write(xListRed.get(i)+","+yListRed.get(i)+" ; ");
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

