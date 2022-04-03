/**
 * 現在の色
 */
rgb=[255,0,0];
/**
 * 配列rgbのインデックス
 */
let now=0;
/**
 * 配列rgbの次のインデックス(環状に変化)
 */
let nextnow=1;
/**
 * ゲーミング処理を行うインターバルの番号
 */
let gaming_interval=setInterval(()=>{
    /**
     * 右のヘッダー自体
     */
    let e=document.querySelector('body > div.application.js-app.is-condensed > header > div');
    /**
     * 右のヘッダーの中身
     */
    let e2=document.querySelectorAll('body > div.application.js-app.is-condensed > header > div *');
    /**
     * 上のヘッダー
     */
    let e3=document.querySelectorAll('.js-column-header');
    nextnow=(now+1)%3;
    if(rgb[nextnow]!=255){rgb[nextnow]+=5;}
    else if(rgb[now]>0 && rgb[nextnow]==255){rgb[now]-=5;}
    else if(rgb[now]==0){now=nextnow;}
    e.style.backgroundColor="rgb("+rgb[0]+","+rgb[1]+","+rgb[2]+")";
    for(a=0;a<e2.length;a++)e2[a].style.backgroundColor="rgb("+rgb[0]+","+rgb[1]+","+rgb[2]+")";
    for(a=0;a<e3.length;a++)e3[a].style.backgroundColor="rgb("+rgb[0]+","+rgb[1]+","+rgb[2]+")";
},100)
//clearInterval(gaming_interval);
//↑ゲーミング処理を消す処理