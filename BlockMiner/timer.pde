// 一つのタイマーの機能を管理するクラス
class Timer {
  long startTime;
  long duration;
  long progress;
  boolean isRunning = false;

  // コンストラクタは空でOK
  Timer() {}

  // タイマーを開始する
  void start(float seconds) {
    this.duration = (long)(seconds * 1000); // 秒をミリ秒に変換
    this.startTime = millis();
    this.isRunning = true;
  }

  // タイマーが完了したかどうかをチェックする
  // ★完了を一度だけ通知し、自動で停止するのがポイント
  boolean isFinished() {
    if (!this.isRunning) {
      return false;
    }
    
    if (millis() - startTime >= duration) {
      //progress = map((millis() - startTime), duration, 0, 1);
      this.isRunning = false; // タイマーを停止
      return true;           // 完了を通知
    }
    
    return false; // まだ実行中
  }
}


// 複数の名前付きタイマーを一元管理するクラス
class TimerManager {
  
  // キーがタイマー名(String)、値がGameTimerオブジェクトのHashMap
  HashMap<String, Timer> timers = new HashMap<String, Timer>();

  // 指定した名前のタイマーをセット（またはリセット）する
  void set(String timerName, float durationInSeconds) {
    // もしその名前のタイマーがまだなければ、新しく作る
    if (!timers.containsKey(timerName)) {
      timers.put(timerName, new Timer());
    }
    // タイマーを取得してスタートさせる
    timers.get(timerName).start(durationInSeconds);
    println("タイマー「" + timerName + "」を" + durationInSeconds + "秒でセットしました。");
  }

  // 指定した名前のタイマーが完了した「瞬間」かどうかをチェックする
  boolean isFinished(String timerName) {
    if (timers.containsKey(timerName)) {
      return timers.get(timerName).isFinished();
    }
    return false; // そもそもそんなタイマーは存在しない
  }
  
  // 指定した名前のタイマーが現在作動中か（クールダウン中かなど）をチェックする
  boolean isRunning(String timerName) {
    if (timers.containsKey(timerName)) {
      return timers.get(timerName).isRunning;
    }
    return false;
  }
}
