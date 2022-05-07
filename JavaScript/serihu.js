/**
 * セリフを渡すと倒れそうな感じのセリフに変換されます。  
 * ,と、と。は変換時に消します。  
 * セリフは日本語のみの方が上手くいくと思います。
 * @param {String} sentence 
 * @returns String
 */
function taoresou(sentence) {
    /**
     * 倒れそうな言葉達です。  
     * 0\~4:ノーマル  
     * 5\~6:末尾用  
     * 7\~8:末尾用ランダム
     */
    var word=['...','ｯ!','...ｸﾞﾊｯ!','...','...ｸｯ!','ッ...!','...','ﾊﾞﾀｯ','ﾊﾞﾀﾝ'];
    /**
     * 結果格納用
     */
    var ret="";
    /**
     * 0:前回word配列から文字列を置いたかどうか  
     * 1:回数制限用
     */
    var placed=[false,false];
    for(i=0;i<sentence.length;i++){
        if(placed[0] && !placed[1])placed[0]=false;
        if(placed[1])placed[1]=false;
        if(!(sentence[i]==',' || sentence[i]=='。' || sentence[i]=='、')){
            // ,や、や。ではない
            ret+=sentence[i];
        }
        if((parseInt(Math.random()*5)==0 || (sentence[i]==',' || sentence[i]=='。' || sentence[i]=='、') )&& i!=sentence.length-1 && !placed[0]){
            // (1/5の確率で当たった または ,と、と。のどれかがある) かつ 末尾ではない かつ 前回置いてない
            ret+=word[parseInt(Math.random()*5)];
            placed=[true,true];
        }
        if(i==sentence.length-1 && !placed[0]){
            // 末尾である かつ 前回置いてない
            ret+=word[5+parseInt(Math.random()*2)];
            if(parseInt(Math.random()*3)==0)ret+=word[7+parseInt(Math.random()*2)]; // 1/3の確率でwordから7か8を置く
        }
    }
    return ret;
}
/**
 * ABC逆から読んでもCBA
 * @param {String} sentence ABC
 * @param {String} split_str 逆から読んでもの両端につける文字列、デフォルトは""
 */
function gyaku(sentence,split_str=""){
    var ret=sentence;
    ret+=split_str+"逆から読んでも"+split_str;
    ret+=sentence.split("").reverse().join("");
    return ret;
}
/**
 * 進次郎構文を作成します。  
 * 構文番号表  
 * |番号|構文|
 * |---|---|
 * |-1|ランダムに決定|
 * |0|～と思います。だからこそ～と思っている|
 * |1|～です。なぜなら、～だからです。|
 * |2|～したいということは、～しているというわけではないです。|
 * |3|～ということは、～ということです。|
 * |4|～とは、～という意味です。|
 * |5|～です。なので、～です。|
 * |6|～を見て下さい、～があります。|
 * @param {String} sentence 
 * @param {String} sentence2 任意、２回目の文(デフォルトは1回目の文)
 * @param {num} kobun 任意、構文番号(デフォルトはランダム)
 * @returns String
 */
function sinjiro(sentence,{sentence2="",kobun=-1}){
    var word=[
        ['と思います。だからこそ','と思っている'],
        ['です。なぜなら、','だからです。'],
        ['したいということは、','しているというわけではないです。'],
        ['ということは、','ということです。'],
        ['とは、','という意味です。'],
        ['です。なので、','です。'],
        ['を見て下さい、','があります。']
    ];
    if(sentence2=="")sentence2=sentence;
    if(kobun==-1)kobun=parseInt(Math.random()*word.length);
    return sentence+word[kobun][0]+sentence2+word[kobun][1];
}