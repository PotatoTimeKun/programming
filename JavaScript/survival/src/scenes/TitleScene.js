export default class TitleScene extends Phaser.Scene {
    constructor() {
      super({ key: 'TitleScene' });
    }
  
    create() {
      // フェードイン (白からフェードインする場合)
      this.cameras.main.fadeIn(1000, 255, 255, 255);
  
      // BGM 再生 (ループ)
      this.bgm = this.sound.add('normal-bgm', { loop: true, volume: 0.5 });
      this.bgm.play();
  
      // 背景画像を中央に表示
      const { width, height } = this.cameras.main;
      const bg = this.add.image(width / 2, height / 2, 'title-back');
      bg.setDisplaySize(width, height); // 画面いっぱいに拡大 (画像サイズに合わせて調整)
  
      // ───────── ボタン配置 ─────────
      // （ボタン画像は単純に Image を使いつつ setInteractive() を呼んでいます）
  
      // 1) START ボタン
      const btnStart = this.add.image(160, 375, 'button');
      btnStart.setInteractive({ useHandCursor: true }); // カーソルを"手"アイコンに
      this.makeButtonEffect(btnStart);
  
      // ボタンの上にテキストを重ねる例
      const startText = this.add.text(btnStart.x, btnStart.y+5, '始めから', {
        fontSize: '20px',
        color: '#333',
        fontFamily: 'DotGothic16 , sans-serif',
        shadow: {
          offsetX: 1,
          offsetY: 1,
          color: '#ffffff',
          blur: 0,
          stroke: false,
          fill: true
        }
      }).setOrigin(0.5);
      startText.setPadding(0, 0, 10, 10);
  
      // ボタンを押したときの処理
      btnStart.on('pointerup', () => {
        // フェードアウト → MainScene へ
        this.cameras.main.fadeOut(500, 255, 255, 255);
        this.cameras.main.once('camerafadeoutcomplete', () => {
          // BGM 停止 or フェードアウト
          this.bgm.stop();
          // 次のシーンへ
          this.scene.start('MainScene');
        });
      });

      const btnRestart = this.add.image(440, 375, 'button');
      btnRestart.setInteractive({ useHandCursor: true }); // カーソルを"手"アイコンに
      this.makeButtonEffect(btnRestart);
  
      // ボタンの上にテキストを重ねる例
      const restartText = this.add.text(btnRestart.x, btnRestart.y+5, '続きから', {
        fontSize: '20px',
        color: '#333',
        fontFamily: 'DotGothic16 , sans-serif',
        shadow: {
          offsetX: 1,
          offsetY: 1,
          color: '#ffffff',
          blur: 0,
          stroke: false,
          fill: true
        }
      }).setOrigin(0.5);
      restartText.setPadding(0, 0, 10, 10);
  
      // ボタンを押したときの処理
      btnRestart.on('pointerup', () => {
        // フェードアウト → MainScene へ
        this.cameras.main.fadeOut(500, 255, 255, 255);
        this.cameras.main.once('camerafadeoutcomplete', () => {
          // BGM 停止 or フェードアウト
          this.bgm.stop();
          // 次のシーンへ
          this.scene.start('MainScene');
        });
      });
  
      // 2) 設定ボタン (押すとダイアログを出すなど)
      const btnConfig = this.add.image(160, 475, 'button');
      btnConfig.setInteractive({ useHandCursor: true });
      this.makeButtonEffect(btnConfig);

      const configText = this.add.text(btnConfig.x, btnConfig.y+5, '設定', {
        fontSize: '20px',
        color: '#333',
        fontFamily: 'DotGothic16 , sans-serif',
        shadow: {
          offsetX: 1,
          offsetY: 1,
          color: '#ffffff',
          blur: 0,
          stroke: false,
          fill: true
        }
      }).setOrigin(0.5);
      configText.setPadding(0, 0, 10, 10);
  
      btnConfig.on('pointerup', () => {
        // ダイアログクラスを使って表示するなど
        // 例： this.showConfigDialog();
        console.log('Open config dialog');
      });

      const btnCredit = this.add.image(440, 475, 'button');
      btnCredit.setInteractive({ useHandCursor: true });
      this.makeButtonEffect(btnCredit);

      const creditText = this.add.text(btnCredit.x, btnCredit.y+5, 'クレジット', {
        fontSize: '20px',
        color: '#333',
        fontFamily: 'DotGothic16 , sans-serif',
        shadow: {
          offsetX: 1,
          offsetY: 1,
          color: '#ffffff',
          blur: 0,
          stroke: false,
          fill: true
        }
      }).setOrigin(0.5);
      creditText.setPadding(0, 0, 10, 10);
  
      btnCredit.on('pointerup', () => {
        // ダイアログクラスを使って表示するなど
        // 例： this.showConfigDialog();
        console.log('Open config dialog');
      });
  
      // 3) 外部リンクボタン
      const btnLink = this.add.image(50, 550, 'link-developer');
      btnLink.setInteractive({ useHandCursor: true });
      this.makeButtonEffect(btnLink);
  
      btnLink.on('pointerup', () => {
        window.open('https://sushi.ski/@potatokun', '_blank');
      });

      const btnTwiLink = this.add.image(100, 550, 'link-twitter');
      btnTwiLink.setInteractive({ useHandCursor: true });
      this.makeButtonEffect(btnTwiLink);
  
      btnTwiLink.on('pointerup', () => {
        window.open('https://x.com/intent/tweet?text=%E3%83%9D%E3%83%86%E3%83%88%E5%90%9B%E3%81%AE%E3%82%B5%E3%83%90%E3%82%A4%E3%83%90%E3%83%AB%E3%82%B2%E3%83%BC%E3%83%A0&url=https://potatotimekun.github.io/programming/JavaScript/survival/', '_blank');
      });

      const btnMisLink = this.add.image(150, 550, 'link-misskey');
      btnMisLink.setInteractive({ useHandCursor: true });
      this.makeButtonEffect(btnMisLink);
  
      btnMisLink.on('pointerup', () => {
        window.open('https://misskeyshare.link/share.html?text=%E3%83%9D%E3%83%86%E3%83%88%E5%90%9B%E3%81%AE%E3%82%B5%E3%83%90%E3%82%A4%E3%83%90%E3%83%AB%E3%82%B2%E3%83%BC%E3%83%A0&url=https://potatotimekun.github.io/programming/JavaScript/survival/', '_blank');
      });
    }
  
    // ボタンに影をつけたり、押下時のエフェクトを付与するための簡易メソッド例
    makeButtonEffect(button) {
      // ボタンのデフォルト状態や影を表現したい場合、
      // ボタン画像に直接「影入りの画像」を用意するのがシンプルですが、
      // Phaser 上で実装するなら手書きやプラグインなどいろいろやり方があります。
      //
      // 以下は pointerdown / pointerover 時に少し拡大・縮小するサンプル
  
      // ホバー（カーソルが乗った）時
      button.on('pointerover', () => {
        this.tweens.add({
          targets: button,
          scale: 1.1,
          duration: 100,
          ease: 'Power1'
        });
      });
      // ホバー解除（カーソルが外れた）時
      button.on('pointerout', () => {
        this.tweens.add({
          targets: button,
          scale: 1,
          duration: 100,
          ease: 'Power1'
        });
      });
  
      // 押したとき
      button.on('pointerdown', () => {
        // 少し押し込んだように縮小
        button.setScale(0.95);
      });
      // 離したとき
      button.on('pointerup', () => {
        // 元に戻す
        button.setScale(1.1);
        // ※ pointerup の直後に pointerout が発生する場合があるので、
        //   そのあたりの挙動はゲームに合わせて調整してください
      });
    }
  
    // 例: 設定ダイアログを表示するメソッド（別クラスを呼ぶなど）
    // showConfigDialog() {
    //   const dialog = new ConfigDialog(this);
    //   dialog.show();
    // }
  
  }
  