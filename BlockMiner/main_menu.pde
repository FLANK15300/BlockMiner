class main_menu extends Screen {
  //@オーバーライド
  main_menu() {
    Input = new keyInput_main_menu(this, int(LEFT), int(UP), int(DOWN), int(RIGHT), int(ENTER), int(BACK));
  }

  @Override
    void screen_update() {

    background(0, 0, 255);
    textSize(104);
    textAlign(LEFT);
    text("MAIN\nMENU", 20, 100);
  }
}
