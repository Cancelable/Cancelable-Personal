public class Pawn extends Piece {
  
  private int columnX;
  private int rowY;
  private String team;
  
  private boolean selected;
  
  public Pawn(int columnXSpot, int rowYSpot,String teamColor) {
    columnX = columnXSpot;
    rowY = rowYSpot;
    team = teamColor;
  }
  
  public void move(Piece[][] board) {
    // if white
    if (team==white) {
      if (board[columnX][rowY] == null) {
        
      }
    }
    
    // else if black
    else if (team==black) {
      
    }
  }
  
  //@Override
  public int getColX() {
    return columnX;
  }
  
  //@Override
  public int getRowY() {
    return rowY;
  }
  
  //@Override - idk if you need this in processing
  public String getTeam() {
    return team;
  }
  
  //@Override
  public String getLetter() {
    return "P";
  }
  
  //@Override
  public void setSelected() {
    selected = true;
  }
  
}
