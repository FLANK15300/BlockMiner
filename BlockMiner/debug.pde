void debugInfo(){
  ArrayList<String> debugtext = new ArrayList<String>();
  float debugX = 10;
  float debugY = 20;
  float lineHeight = 20; // textSizeに合わせて調整
  String temp = "";
  boolean nullflag = false;
  String temp2 = "";
  // 描画設定を一度だけ行う
  textFont(createFont("meiryo", 1), 1);
  fill(255); // 白文字
  textAlign(LEFT, TOP);
  textSize(16);
  noStroke();
  switch(debugMode){
    case 1:
      fill(0);
      rect(0,0, 200, 600);
      fill(255);
//      text("mouseX:" + mouseX + "\nmouseY:" + mouseY + "\nmouseButton:" + mouseButton + "\nMouse{\n    moving:" + mouse.moving + "\n    left.pressed: " + mouse.left.Pressed + "\n    left.Down: " + mouse.left.Down + "\n    left.Rleased: " + mouse.left.Released + "\n    left.Up: " + mouse.left.Up + "\n    left.state: " + mouse.left.holdTime + "\n    left.state: " + mouse.left.state + "\n}\n    key.y.state: " + keyState.getOrDefault("y", false) + "\n    key.left.state: " + keyState.getOrDefault("LEFT", false) + "\n    ball.blockPosx: " + ball.blockPos[0] + "\n    ball.blockPosy: " + ball.blockPos[1], 1, 16);
// draw()ループの中など、表示したい場所で

// --- デバッグ表示 ---
// 基準となる座標と、1行の高さを決める




// 1行描画するたびに、Y座標を下にずらしていく
text("--- MOUSE ---", debugX, debugY);
debugY += lineHeight; // Y座標を1行分下げる

text("Position: " + mouseX + ", " + mouseY, debugX, debugY);
debugY += lineHeight;

text("Moving: " + mouse.moving, debugX, debugY);
debugY += lineHeight;

text("Left.isPressed: " + mouse.left.Pressed, debugX, debugY);
debugY += lineHeight;

text("Left.isDown: " + mouse.left.Down, debugX, debugY);
debugY += lineHeight;

text("Left.isReleased: " + mouse.left.Released, debugX, debugY);
debugY += lineHeight;

debugY += lineHeight; // 少し間を空ける

text("--- KEY ---", debugX, debugY);
debugY += lineHeight;
text("key: " + key, debugX, debugY); // inputManagerを使う例
debugY += lineHeight;
text("Y Key Held: " + keyState.getOrDefault("y", false), debugX, debugY); // inputManagerを使う例
debugY += lineHeight;
text("SHIFT Key Held: " + keyState.getOrDefault("SHIFT", false), debugX, debugY); // inputManagerを使う例
debugY += lineHeight;
text("LEFT Key Held: " + keyState.getOrDefault("LEFT", false), debugX, debugY);
debugY += lineHeight;

debugY += lineHeight;

text("--- BALL ---", debugX, debugY);
debugY += lineHeight;
text("Pos: " + game.ball.x + ", " + game.ball.y, debugX, debugY);      
debugY += lineHeight;
text("Block Pos: " + ball.blockPos[0] + ", " + ball.blockPos[1], debugX, debugY);      
debugY += lineHeight;
text("Size: " + game.ball.size, debugX, debugY);      
debugY += lineHeight;
text("Speed: " + game.ball.speed, debugX, debugY);      
debugY += lineHeight;
text("Vector: " + game.ball.vec.x + ", " + game.ball.vec.y, debugX, debugY);      
debugY += lineHeight;
text("Moment: " + game.ball.vec.mag()/4, debugX, debugY);
debugY += lineHeight;
text("Attack Damage: " + abs(game.ball.strength * game.ball.strength_magnification * game.ball.vec.mag()/4), debugX, debugY);
debugY += lineHeight;
text("baseAcceleration: " + game.ball.baseAcceleration, debugX, debugY);
debugY += lineHeight;
text("Acceleration: " + game.ball.acceleration, debugX, debugY);
debugY += lineHeight;
text("onGround: " + game.ball.onGround, debugX, debugY);
debugY += lineHeight;
text("isShooted: " + game.isShooted, debugX, debugY);
debugY += lineHeight;

debugY += lineHeight;




nullflag = lastHit == null;
text("--- BLOCK ---", debugX, debugY);
debugY += lineHeight;
temp = (nullflag) ? "null" : str(lastHit_array[0]);
temp2 = (temp == "null") ? temp : str(lastHit_array[1]);
text("Array Index: " + temp + ", " + temp2, debugX, debugY);       //<>// //<>//
debugY += lineHeight;
temp = (nullflag) ? "null" : str(lastHit.blockPos[0]);
temp2 = (temp == "null") ? temp : str(lastHit.blockPos[1]);
text("Pos: " + temp + ", " + temp2, debugX, debugY);      
debugY += lineHeight;
temp = (nullflag) ? "null" : str(lastHit.absPos.x);
temp2 = (temp == "null") ? temp : str(lastHit.absPos.y);
text("absPos: " + temp  + ", " + temp2, debugX, debugY);      
debugY += lineHeight;text("Moment: " + game.ball.vec.y/4, debugX, debugY);      
      break;
    case 2:

      fill(0, 125);
      rect(0,0, 200, 300);
      fill(255);

main_game game = (main_game)Screens[2]; // Screen型のScreenの要素をmain_game型にキャストすることで、main_gameのメンバー変数を取得する

      text("--- INVENTORY ---", debugX, debugY);
      debugY += lineHeight;
      
      text("土:" + game.dirt, debugX, debugY);
      debugY += lineHeight;
      text("石:" + game.stone, debugX, debugY);
      debugY += lineHeight;
      text("鉄:" + game.iron, debugX, debugY);
      debugY += lineHeight;
      text("金:" + game.gold, debugX, debugY);
      debugY += lineHeight;
      text("トパーズ:" + game.topaz, debugX, debugY);
      debugY += lineHeight;
      text("アメジスト:" + game.amethyst, debugX, debugY);
      debugY += lineHeight;
      text("サファイア:" + game.sapphire, debugX, debugY);
      debugY += lineHeight;
      text("エメラルド:" + game.emerald, debugX, debugY);
      debugY += lineHeight;
      text("ルビー:" + game.ruby, debugX, debugY);
      debugY += lineHeight;
      text("ダイヤモンド:" + game.diamond, debugX, debugY);
      debugY += lineHeight;
      //text(debugtext, 1, 16);
  
  }
  
  
  textFont(F_pixel);
}
