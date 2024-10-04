word2vecの学習済みモデル(model/word2vec)は
https://qiita.com/Hironsan/items/513b9f93752ecee9e670
より
感情分析の事前学習モデルは
https://huggingface.co/tohoku-nlp/bert-base-japanese-whole-word-masking
より
感情分析の学習用データセットは
https://huggingface.co/datasets/tyqiangz/multilingual-sentiments
より
使わせていただきました(word2vecのモデルはそのまま、以降2つは学習後のモデルのみmodel/bertに保存しています)

ソースコードはMITライセンスとして公開しています(同封するモデルは上記のライセンスに従ってください)
ソースコードは
https://github.com/PotatoTimeKun/programming/tree/main/Python/analyze_note
にあります
(ライセンスには詳しくないので、僕のプログラムのソースコード部分は自由に使っていいということです)

モデルは大きいのでGitHub上には上げていません、ソフトのダウンロード時にダウンロードしてください(配布場所などをまとめた情報はホームページのここhttps://potatotimekun.github.io/web/#gに掲載する予定です)
アップデートする可能性もあります(多分アップデートしたら前のバージョンは消します、容量が重いので)アップデートしたときは同じくホームページに載せます