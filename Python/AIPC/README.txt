1.はじめに

AIPC(AI Potatokun Controller)とは、このフォルダに含まれるコード郡を指します
AIPCはMITライセンスのOSSです(要するに、自由に使っていいということです)
AIPCを元にしたプログラムを公開する場合、READMEなどの分かりやすい場所に

AIPC build by PotatoTimeKun | MIT Licence | https://github.com/PotatoTimeKun/programming/blob/main/LICENSE.md

を記載してください、コードを公開せずに運用するだけの場合は特に要りません

-------------------------------------------

2.使い方

Bot用Misskeyアカウントを用意し、トークンを発行してメモしておきます(トークンで許可する必要があるものをすべて列挙するのは大変(というか、分からない)ので全部許可でいいです、乗っ取り等が心配ならアカウントの削除とか(あったっけ)あたりの機能は無効化しておけばいいと思います)

AIPCのAIPCsetting.jsonを以下のようにいじります

misskeySserverの項目をBotアカウントのあるサーバのドメインにする
AIPC項目のschedule項目にスケジュールを書き込む

スケジュールの書き方は2種類あります

{
    "function": "イベント名",
    "type": "interval",
    "timer": 分単位でのインターバル
    "startAt": [ 開始時 , 開始分 ]
}
この書き方の場合、毎日startAtに指定した時刻からtimerの間隔だけ開けて何度も実行します

{
    "function": "イベント名",
    "type": "once",
    "startAt": [ 開始時 , 開始分 ]
}
この書き方の場合、毎日startAtに指定した時刻に1度だけ実行します

イベント名一覧はあとに書いておきます
それぞれのサーバやアカウントに設定を合わせる必要があると思うので、イベント名一覧とともに設定すべき項目も書いておきます

設定が終わったらあとはPythonでAIPC_CUI.pyを動かせば使えます、使っているライブラリが幾つかあるのでインポートエラーが出たらその都度インストールしてください
最初はトークンを入力する必要があります、そのあとにトークンの暗号化用のパスワードも入力します
トークンはSHA256で暗号化されて./tokenに保存されます、保存場所を変えたい場合はAIPCsetting.jsonのAIPC > tokenFileをいじってください
2回目以降の起動ではパスワードを入れれば使えるようになります

参考までに、開発時点ではAIポテト君のスケジュールは以下の用になっています
        "schedule": [
            {
                "function": "note-generation",
                "type": "interval",
                "timer": 90,
                "startAt": [
                    0,
                    0
                ]
            },
            {
                "function": "note-generation",
                "type": "interval",
                "timer": 90,
                "startAt": [
                    0,
                    30
                ]
            },
            {
                "function": "575-generation",
                "type": "interval",
                "timer": 90,
                "startAt": [
                    1,
                    0
                ]
            },
            {
                "function": "clip-add",
                "type": "once",
                "startAt": [
                    22,
                    10
                ]
            },
            {
                "function": "uranai-generation",
                "type": "once",
                "startAt": [
                    12,
                    20
                ]
            },
            {
                "function": "weathercast-generate",
                "type": "once",
                "startAt": [
                    10,
                    10
                ]
            },
            {
                "function": "taigigo-generate",
                "type": "once",
                "startAt": [
                    21,
                    10
                ]
            },
            {
                "function": "reaction-send",
                "type": "interval",
                "timer": 30,
                "startAt": [
                    0,
                    15
                ]
            },
            {
                "function": "wordcloud-generation",
                "type": "interval",
                "timer": 30,
                "startAt": [
                    0,
                    10
                ]
            },
            {
                "function": "reversi-game",
                "type": "once",
                "startAt": [
                    20,
                    0
                ]
            }
        ]


-------------------------------------------

3. イベント名一覧


イベント名
  note-generation
機能名
  ノート生成機能
コード
  function.py > makeNote
設定項目(AIPCsetting.json)
  なし
詳細
  マルコフ連鎖でノートを生成し、投稿します
  LTLの直近100ノートから拾った投稿を元にしています


イベント名
  575-generation
機能名
  575生成機能
コード
  function.py > make575
設定項目(AIPCsetting.json)
  なし
詳細
  川柳を生成し、投稿します
  LTLの直近100ノートから拾った投稿を元にしています


イベント名
  clip-add
機能名
  人気ノートクリップ機能
コード
  function.py > clipMake
設定項目(AIPCsetting.json)
  clipBorder : この数以上のノートをクリップ対象にします
詳細
  自分のノートの中からリアクション数の多いノートをクリップします
  サーバの規模などによってリアクション数の多い・少ないは変わるのでそれに合わせてclipBorderを調整する必要があります


イベント名
  uranai-generation
機能名
  占い生成機能
コード
  function.py > makeUranai
設定項目(AIPCsetting.json)
  uranaiBase : 占いを書き込む下敷きになる画像、自作のものにしてもいいがその場合画像サイズや位置を合わせる必要があります
  uranaiSave : 占い結果の画像を保存しておく場所、アップロード後はローカル保存された画像は消してもいいです(消す機能は付いてない)
  uranaiFont : 占いの画像に書き込む文字のフォント、その環境で使えるフォント指定する必要があります
詳細
  誕生月占いを画像として生成し、投稿します
  LTLの直近100ノートから拾った投稿を元にしています
  文字化けする場合はuranaiFontを適切に設定すれば直るかもしれません


イベント名
  weathercast-generate
機能名
  占い生成機能
コード
  function.py > weathercast
設定項目(AIPCsetting.json)
  なし
詳細
  天気予報を生成します
  デフォルトでは東京と大阪の予報です、変える場合はコードを直接いじる必要があります
  使用しているAPIはhttps://weather.tsukumijima.net/です、これによると、気象庁のホームページを元にしているようです


イベント名
  taigigo-generate
機能名
  対義語生成機能
コード
  function.py > makeTaigigo
設定項目(AIPCsetting.json)
  geminiAPIToken : GeminiのAPIキー
詳細
  対義語ネタを生成し、投稿します
  Geminiを使っているので、GeminiのAPIキーを作る必要があります
  1日1回程度なら無料プランでも動きます


イベント名
  reaction-send
機能名
  リアクション機能
コード
  function.py > sendReaction
設定項目(AIPCsetting.json)
  reactionUser : リアクションを許可したユーザのIDがここに保存されます、手動で設定する必要はありません
  sensitiveReactionUser : センシティブの付いたリアクションを許可したユーザはここにも保存されます、手動で設定する必要はありません
  reactionPerUser : 毎回ユーザごとにここに指定した数だけのノートを選んでリアクションします
  reaction_notePerUser : ユーザから読み込むノートの数です、reactionPerUser以上である必要があります
  reaction_ignoreCategory : ここに指定したカテゴリの絵文字は使用しなくなります
  ignoreReaction : ここに指定したリアクション(:は必要ない)は使用しなくなります
  sensitiveReaction : ここに指定したリアクションは、サーバー側でセンシティブと設定しているかどうかに関わらずセンシティブリアクションとして扱います、サーバ側でセンシティブと判定されているリアクションを書く必要はありません
  mentionReadCount : リアクション許可・拒否のメンションを読み込む数です(他の用途の自分向けメンションも拾います)、実行時に拾いきれないと漏れたユーザの設定が反映されなくなります
詳細
  許可されたユーザにリアクションを送ります
  ユーザ自身がメンションで
  「リアクション有効」と言うとリアクションが送られるようになります
  「リアクション無効」で送られなくなります
  「センシティブリアクション有効」と言うとセンシティブの付いたリアクションも送るようになります
  「センシティブリアクション無効」でセンシティブの付いたリアクションは送られなくなります(センシティブの付いていないリアクションは送られ続けます)


イベント名
  wordcloud-generation
機能名
  ワードクラウド生成機能
コード
  function.py > makeWordcloud
設定項目(AIPCsetting.json)
  mentionReadCount : ワードクラウド生成のメンションを読み込む数です(他の用途の自分向けメンションも拾います)、実行時に拾いきれないと漏れたノートにリプライがされなくなります
  wordcloudMask : ワードクラウドのマスクに使う画像です、白黒にし、黒い部分に文字が入ります、画像のサイズは幅750px高さ600pxにしてください
  wordcloudSave : 生成したワードクラウドの保存場所です、アップロード後は消してもいいです(消す機能は付いてないです)
  wordcloudFont : ワードクラウドに書き込む文字のフォントです、文字化けする場合は別のフォントに設定してください
詳細
  メンションで「ワードクラウド」を含んだ投稿をしたユーザにそのユーザのワードクラウド画像を生成してリプライします


イベント名
  reversi-game
機能名
  ワードクラウド生成機能
コード
  reversiFunc.py (スタートはstartReversi関数)
設定項目(AIPCsetting.json)
  reversiStart : リバーシを始める時間です、時単位の指定になります、スケジュールのstartAtと対応させないと投稿文と実際の時間にズレがでます
  reversiEnd : リバーシが終了する時間です
詳細
  指定した時間の間、リバーシをBotが行います
  起動時にはリバーシができる時間と難易度を投稿します


イベントを自作する場合は、その関数をAIPC_CUI.pyのeventRun関数に追加してください、APIを扱うMisskeyAPIクラスやノートの分析を行うtextAnalizerモジュールも用意してるのでそれも活用してみてください、上の標準機能のコードが使い方の参考になると思います

----------------------------------------------------

4.その他

AIPCは自由に使用したり改変したりすることができます
AIPCを使う際は、Misskeyインスタンスのサーバ管理者やユーザの迷惑にならないよう適切に調整するようにお願いします、その結果起きたことに僕は一切の責任を追いません
エンタメAIとして開発したものなので、是非みんなが笑って迎え入れてくれるようなAIにしてあげてください

----------------------------------------------------

5.バージョン情報

1.0
最初のリリース
1.1
デバッグ - リアクションの排除が一部機能しない
1.2
デバッグ - リアクション機能でノートを読み込めない(アカウント削除など)ユーザがいたときにリアクションの送信が止まる
1.3
変更 - Playの投稿を削除対象に追加
変更 - LTLの読み込み関数にCWの付いたノートを排除できる引数を追加
変更 - マルコフ連鎖のノート生成で150字を超えるノートをCWするように