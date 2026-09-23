static class Command{

  static String Input = "";


  static void run(){
    
    draw();
    update();


  }
  
  private static void draw(){
    

    p.fill(255, 125);
    p.rect(0, 0, p.width, 30);

    int textSize = 16;
    p.textFont(p.createFont("meiryo", 1), 1);
    p.fill(0); // 白文字
    p.textAlign(LEFT, CENTER);
    p.textSize(textSize);
    p.noStroke();
    
    p.text(Input, 10, textSize/2 + 3);
  }
  
  private static void update(){
  
  }
  
  public static void input(int keyCode, char key){
  

    
    switch (keyCode){
    case BACKSPACE:
      Input = Input.substring(0, Input.length()-1);
      break;
    case ENTER:
      execute();
      break;
    case SHIFT:
    
      break;
    default:
      Input = new String(Command.Input + key);  
    }
    
    if(Input.length() == 0) {
      command = false;
      return;
    }
  }
  
  private static void execute(){
    Input = Input.substring(1, Input.length());
    String[] part = split(Input, ' ');
      if (part.length < 2) {
        error();
        return;
      }
      String variable = part[0];
      String val = part[1];
    
      switch (variable){
      case "speed":
        game.ball.speed = float(val);
        break;
      case "gravity":
        ball.gravity = float(val);
        break;
      case "1":
        game.ball.speed = float(val);
        break;
      case "2":
        game.ball.speed = float(val);
        break;
      case "3":
        game.ball.speed = float(val);
        break;
      case "4":
        game.ball.speed = float(val);
        break;
      case "5":
        game.ball.speed = float(val);
        break;
      
      }
    
    Input = new String();
    command = false;
    
  }
  
  private static void error(){
  
    
    Input = new String();
    command = false;  
  }
}
