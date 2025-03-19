export default class LoadingScene extends Phaser.Scene {
    constructor() {
        super({ key: 'LoadingScene' });
    }

    preload() {
        // ───────────── 1. ロゴ画像のみ先にロード ─────────────
        // ロード画面用のロゴ（最初に表示するアセット）
        // ここだけは事前にパスを直接指定し、表示用に確保しておく
        this.load.image('logo', 'assets/logo.png');

        // ───────────── 2. マニフェストをロード ─────────────
        // ※ Manifest.json に記載された全アセットへのパスを一括取得するため
        this.load.json('manifest', 'assets/manifest.json');

        // ロード進捗を表示したい場合は下記のようなイベントリスナーを使ってバーを描画するなども可能
        // this.load.on('progress', (value) => { ... });
    }

    create() {
        this.cameras.main.setBackgroundColor('#ffffff');
        // ───────────── ロゴ表示（フェードイン） ─────────────
        const { width, height } = this.cameras.main;
        // ロゴを画面中央に配置、最初は非表示 (alpha=0)
        const logo = this.add.image(width / 2, height / 2, 'logo');
        logo.setAlpha(0);

        // フェードイン用 Tween
        this.tweens.add({
        targets: logo,
        alpha: 1,         // フェードインで透明度を 0 → 1
        duration: 1000,   // 1秒かける
        onComplete: () => {
            // ロードが完了していなければ、ここで manifest 読み込み待ち等を行う
            // すでに manifest は preload で読み込めているので、このタイミングでさらにロード開始
            this.loadAssetsFromManifest();
        },
        });
    }

    loadAssetsFromManifest() {
        // ───────────── マニフェスト内容を取得 ─────────────
        const manifest = this.cache.json.get('manifest');
        if (!manifest) {
        console.error('manifest.json が読み込めませんでした');
        this.finishLoading(); // 強制的に次へ進める or エラー画面へ遷移
        return;
        }

        // 画像のロード
        if (manifest.images) {
        manifest.images.forEach((img) => {
            this.load.image(img.key, `assets/${img.path}`+'?ver=' + Date.now());
        });
        }

        // 画像のロード
        if (manifest.ui) {
        manifest.ui.forEach((img) => {
            this.load.image(img.key, `assets/${img.path}`+'?ver=' + Date.now());
        });
        }

        // オーディオのロード
        if (manifest.audio) {
        manifest.audio.forEach((aud) => {
            this.load.audio(aud.key, `assets/${aud.path}`);
        });
        }

        // スプライトシートのロード
        if (manifest.spritesheets) {
        manifest.spritesheets.forEach((sheet) => {
            this.load.spritesheet(
            sheet.key,
            `assets/${sheet.path}`,
            sheet.frameConfig
            );
        });
        }

        // ロード完了時のイベント
        this.load.once('complete', () => {
        // 全アセットの読み込みが完了したので、画面上に「キーorクリックでスタート」の文字を表示
        this.showStartMessage();
        });

        // ここでマニフェスト内の全アセットロードを開始
        this.load.start();
    }

    showStartMessage() {
        const { width, height } = this.cameras.main;
        const startText = this.add.text(width / 2, height * 0.8, 'キーを押すかクリックでスタート', {
        fontSize: '15px',
        fontFamily: 'DotGothic16 , sans-serif',
        color: '#000000',
        }).setOrigin(0.5);
        startText.setPadding(0, 0, 0, 10);

        // キー入力 or マウスクリックに反応して次のシーンへ遷移
        this.input.keyboard.once('keydown', () => {
        this.startNextScene();
        });
        this.input.once('pointerdown', () => {
        this.startNextScene();
        });
    }

    startNextScene() {
        // フェードアウトして次のシーンへ
        this.cameras.main.fadeOut(1000, 255, 255, 255);
        this.cameras.main.once('camerafadeoutcomplete', () => {
        this.scene.start('TitleScene'); // 次のシーンへ
        });
    }
}