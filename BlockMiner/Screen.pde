void Screen() { //<>// //<>//

  if (screen_mode == -1) {
    error();
    return;
  }
  Screens[screen_mode].main();
}
