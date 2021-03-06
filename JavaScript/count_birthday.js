/**
 * 誕生日を表示する人の名前の配列です。
 * localStorageの'name'に保存します。
 */
let nameList=[];
/**
 * 表示する誕生日の配列です。2次元配列になっていて[[年,月,日],[年,...],...]のようになります。
 * localStorageの'date'に保存します。
 */
let dateList=[];
if(localStorage.getItem('date')) {
    dateList=JSON.parse(localStorage.getItem('date'));
}
if(localStorage.getItem('name')) {
    nameList=JSON.parse(localStorage.getItem('name'));
}
nameList[0]="ポテトタイム君";
dateList[0]=[2005,12,20];
/**
 * 誕生日の表示を更新する関数です。
 * nameList,dateListからHTMLを生成し、LocalStrageのデータの更新も行います。
 */
function setBirth(){
    let e=document.getElementById("birth");
    let str="";
    for(let i=0;i<nameList.length;i++){
        let nowdate=new Date();
        let age=0;
        let birth=new Date(dateList[i][0],dateList[i][1]-1,dateList[i][2],0,0,0);
        str+='<h1>'+i+'番 - '+nameList[i]+' - '+(birth.toLocaleDateString())+'</h1>';
        while(birth<nowdate){birth.setFullYear(birth.getFullYear()+1);age++;}
        str+='<p>次の誕生日まであと'+(parseInt((birth-nowdate)/86400000)+1)+'日です。</p>';
        str+='<p>現在'+(age-1)+'歳です。</p>';
    }
    e.innerHTML=str;
    localStorage.setItem('name',JSON.stringify(nameList, undefined, 1));
    localStorage.setItem('date',JSON.stringify(dateList, undefined, 1));
}
document.getElementById("set").addEventListener("click",function(){
    let tx=document.getElementById("text");
    let dt=document.getElementById("date");
    nameList[nameList.length]=tx.value;
    let st=dt.value;
    dateList[dateList.length]=[parseInt(st.substring(0,4)),parseInt(st.substring(5,7)),parseInt(st.substring(8,10))];
    setBirth();
})
document.getElementById("clall").addEventListener("click",function(){
    nameList=[];
    dateList=[];
    nameList[0]="ポテトタイム君";
    dateList[0]=[2005,12,20];
    setBirth();
})
document.getElementById("clnm").addEventListener("click",function(){
    let i=document.getElementById("nm").value;
    if(i>0 && i<nameList.length){
        nameList.splice(i,1);
        dateList.splice(i,1);
        setBirth();
    }
})
setBirth();
/**
 * 実行時の時刻から日付が変わるまでの時間(ミリ秒)を返します。
 */
let tom = () => (new Date().setHours(0,0,0,0)+24*60*60*1000)-new Date()
setTimeout(() => {setBirth();},tom()) //日付が変わる際にsetBirth関数を実行します。