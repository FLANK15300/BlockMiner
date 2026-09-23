class button{ // 配置可能ボタンクラス
  float x, y, w, h;
  color normal, slide;
  String text;
  String Tag = "";
  boolean isMouseOnButton = false, pre_isMouseOnButton;
  boolean Down = false, Pressed = false;
  int holdTime = 0;
  int delay = 20;
  boolean run = false;
  int drawMode = 0;
  PImage image = createImage(0,0,0);
  PApplet p;
  Runnable code;
  SoundFile onSlide = null, press = null;
  
  
  button(float x, float y, float w, float h, String text, String Tag){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.text = text;
    this.normal = color(255, 255, 255);
    this.slide = color(220, 220, 220);
    this.Tag = Tag;
    drawMode = 0;
  }

  button(float x, float y, float w, float h, PImage image, String Tag){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.image = image;
    this.image.resize(int(this.w), int(this.h));
    this.normal = color(255, 255, 255);
    this.slide = color(220, 220, 220);
    this.Tag = Tag;
    drawMode = 1;
  }
  

  button(float x, float y, float w, float h, String text, SoundFile onSlide, SoundFile press, String Tag){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.text = text;
    this.onSlide = onSlide;
    this.press = press;
    this.normal = color(255, 255, 255);
    this.slide = color(220, 220, 220);
    this.Tag = Tag;
    drawMode = 0;
  }
  
  button(float x, float y, float w, float h, PImage image, SoundFile onSlide, SoundFile press, String Tag){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.image = image;
    this.image.resize(int(this.w), int(this.h));
    this.onSlide = onSlide;
    this.press = press;
    this.normal = color(255, 255, 255);
    this.slide = color(220, 220, 220);
    this.Tag = Tag;
    drawMode = 1;
  }

  button(float x, float y, float w, float h, String text, String Tag, ImageData a){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.text = text;
    this.normal = color(255, 255, 255);
    this.slide = color(220, 220, 220);
    this.Tag = Tag;
  }

  
  button(float x, float y, float w, float h, String text, color normal, color slide){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.text = text;
    this.normal = normal;
    this.slide = slide;
  }
  
  
  void main(){
    run = false;
    this.update();
    this.draw();
    
    if (isMouseOnButton){
      if(!pre_isMouseOnButton && onSlide != null) onSlide.play();
      onSlide();
      cursor(HAND);
    }
    



    if(!(mouse.left.Down || mouse.left.Pressed)){ 
      this.Down = false;
      this.Pressed = false;
      this.holdTime = 0;        
    }
    
    if (isMouseOnButton && (mouse.left.Down || ((holdTime > 60) && holdTime % delay == 0))) {
      if(press != null) press.play();
      run = true;
      onClick();
      return;
    }
  }

  
  void draw(){

    
    
    switch (drawMode){
      case 0:
    
        if (isMouseOnButton && mouse.left.Released) fill(this.normal);
        else fill(this.slide);
        stroke(0);
        strokeWeight(2);
        rect(this.x, this.y, this.w, this.h);
      
        fill(0);
        float textSize = this.w / (this.text.length() + 2);
        textSize = (textSize > this.h) ? this.h /2 : textSize;
        textSize(textSize);
        textAlign(CENTER, CENTER);
        text(text, this.x + this.w/2, this.y + this.h/2);
        break;
      case 1:
        image(image, this.x, this.y);
        if (isMouseOnButton && mouse.left.Released) {
          fill(0, 0, 0, 100);
          rect(this.x, this.y, image.width, image.height);
        }
      }
  }
  
  void update(){
    
    pre_isMouseOnButton = isMouseOnButton;
    isMouseOnButton = isOverlap(mouse.x, mouse.y, 0, 0, this.x, this.y, this.w, this.h);

    if (mouse.left.Down) this.holdTime = 1;
    if (mouse.left.Pressed) this.holdTime++;
    if(mouse.left.Down){
      this.Down = true;
      this.Pressed = false;
    }else if (this.holdTime > 1 && mouse.left.Pressed) {
      this.Down = false;
      this.Pressed = true;
    }

    if(!mouse.left.Down && !mouse.left.Pressed){
      this.Down = false;
      this.Pressed = false;
    }  
  }
  
  
  void onClick(){
      
    delay = 20;
    if(holdTime > 180) delay = 10;
    if(holdTime > 180*2) delay = 5;
      
    // ボタン押したときの処理はスクリーンクラス側ですべてのボタンの.Downステートを取得して関数を実行
    
}

  void onSlide(){
    

  }
}
