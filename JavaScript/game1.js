let stage=[
    [[5, 1, 5],[1, 3, 1],[5, 1, 5]],
    [[3, 4, 3],[4, 0, 4],[4, 1, 4]],
    [[6, 2, 7, 5],[6, 7, 2, 6],[2, 8, 2, 7],[7, 2, 8, 3]],
    [[6, 11, 6, 8],[10, 5, 12, 6],[9, 7, 5, 11],[9, 6, 11, 6]],
    [[4, 12, 7, 5],[11, 4, 11, 10],[8, 11, 5, 9],[9, 6, 7, 9]],
    [[-1, -1, 2],[3, -1, -2],[-2, -2, 3],[1, 2, -2]],
    [[-2, 3, 1, 1, -2, 1],[4, -7, -2, 3, -3, 2],[-2, 3, 2, -3, 3, -2]],
    [[9, 12, 11, 8, 10],[9, 8, 12, 12, 8],[13, 8, 8, 12, 11],[8, 14, 9, 7, 12],[10, 9, 9, 13, 8]],
    [[4, 8, 7, 7, 5],[8, 3, 4, 9, 4],[7, 8, 5, 3, 9],[4, 8, 4, 9, 4]],
    [[5, 5, 9, 5, 7],[8, 4, 5, 6, 2],[6, 8, 3, 9, 8],[6, 6, 8, 3, 7]],
    [[18, 23, 17, 22, 21, 19],[22, 17, 23, 23, 16, 18],[22, 19, 20, 18, 20, 23],[19, 20, 14, 25, 17, 22],[19, 23, 24, 16, 25, 17],[20, 19, 18, 24, 14, 23]],
    [[19, 23, 19, 21, 23, 19],[21, 22, 20, 26, 8, 19],[20, 9, 26, 12, 21, 25],[23, 24, 15, 27, 18, 22],[14, 23, 21, 17, 27, 17],[23, 17, 20, 26, 8, 25]],
    [[8, 13, 9],[13, 8, 10],[9, 10, 10]],
    [[11, 9, 11, 7],[3, 13, 6, 12],[12, 7, 9, 7],[10, 8, 8, 11]],
    [[2, 6, 5, 2],[6, 0, 6, 5],[5, 6, 1, 6],[1, 7, 4, 2],[6, 3, 0, 7]],
    [[12, 15, 13, 15, 14],[12, 10, 18, 7, 12],[14, 18, 7, 14, 16],[16, 6, 14, 14, 11],[11, 16, 16, 8, 16]],
    [[14, 13, 7, 16, 10],[12, 6, 19, 10, 16],[10, 18, 6, 11, 8],[15, 9, 17, 8, 18],[11, 11, 15, 10, 10]],
    [[14, 17, 6, 15, 10],[10, 0, 24, 8, 16],[9, 22, 9, 9, 8],[18, 7, 18, 7, 17],[10, 12, 13, 9, 12]],
    [[3, 7, 3, 2],[3, 2, 7, 3],[6, 2, 6, 6],[5, 3, 3, 3]],
    [[28, 43, 24],[34, 22, 42],[39, 30, 35]],
    [[9, 10, 9],[7, -1, 4],[0, 13, 10],[10, 8, 5]],
    [[10, 11, 9, 11, 13, 3],[8, 3, 14, 3, 7, 13],[12, 8, 7, 8, 12, 9],[6, 11, 11, 12, 5, 11],[11, 10, 6, 6, 13, 7],[7, 10, 10, 11, 7, 9]],
    [[9, 13, 12, 13, 14, 9],[13, 10, 12, 6, 12, 10],[14, 7, 9, 12, 12, 8],[9, 15, 6, 15, 8, 14],[17, 0, 16, 15, 12, 12],[7, 16, 15, -1, 16, 9]],
    [[12, 14, 20, 12, 15],[18, 20, 9, 17, 13],[15, 10, 16, 20, 16],[16, 15, 17, 11, 14],[12, 20, 11, 18, 14]],
    [[11, 12, 22, 15, 13],[20, 23, 7, 10, 16],[13, 9, 19, 22, 17], [20, 10, 17, 14, 12],[11, 22, 8, 18, 14]],
    [[17, 18, 19, 16],[12, 20, 15, 16],[20, 20, 15, 20],[17, 13, 18, 16]],
    [[12, 19, 13],[19, 3, 16],[12, 19, 13]],
    [[-1, 4, -1],[4, -2, 4],[0, 1, 0]],
    [[3, 5, 6, 0],[2, 6, 4, 6],[6, 0, 5, 5],[4, 5, 5, 2]],
    [[2, 7, 4, 1],[7, 1, 3, 8],[2, 7, 3, 3]],
    [[3, 4, 3, 3, 3],[4, -2, 4, 3, 4],[1, 7, 2, 4, 0],[4, 4, 2, 3, 4]],
    [[5, 1, 5, 5, 4],[3, 2, 2, -3, 3],[-2, 6, 5, 7, 1],[5, 4, 0, 1, 5],[3, 3, 5, 1, 4]],
    [[8, 4, 8],[5, 6, 4],[6, 5, 8]],
    [[9, 8, 9, 9],[5, 11, 6, 6],[11, 5, 7, 10],[6, 11, 6, 9]],
    [[14, 9, 14, 8],[7, 11, 15, 11],[11, 13, 7, 12],[15, 7, 9, 12],[10, 12, 12, 11]],
    [[28, 32, 28, 29, 31],[32, 32, 32, 34, 25],[29, 24, 30, 29, 33],[32, 34, 29, 25, 33],[29, 28, 33, 30, 29]],
    [[-2, 2, -2, 1, 1, 1, -2],[1, 1, -1, 3, -4, 1, 2],[1, 2, -5, -1, 2, 1, -2],[-3, 2, 0, -2, 2, 1, -2],[1, 2, -3, 3, -4, 1, 1],[2, -4, 3, 0, 1, 2, 0],[-2, 3, -3, 1, 2, -6, 2]],
    [[49, 54, 49, 51],[53, 48, 56, 49],[54, 51, 45, 55],[48, 52, 52, 50]],
    [[62, 62, 64],[64, 68, 58],[67, 55, 68],[58, 68, 61],[63, 67, 62],[64, 59, 64]],
    [[6, 1, 7, 2],[2, 7, 0, 6],[4, 6, 5, 5],[2, 3, 6, 2]],
    [[61, 79, 59],[80, 65, 75],[57, 76, 69]],
    [[10, 8, 12, 9, 8],[8, 13, 10, 13, 9],[13, 6, 12, 6, 13],[8, 12, 11, 13, 8],[9, 12, 8, 9, 10]],
    [[6, 9, 9, 5, 11, 6],[10, 8, 9, 11, 4, 11],[5, 11, 5, 6, 11, 5],[11, 4, 12, 5, 9, 10],[6, 11, 5, 10, 9, 6]],
    [[-1, 3, -1, -1, 3, 0],[3, 1, 2, 3, 2, -1],[-2, 3, 4, -3, 3, 4],[3, -1, -6, 5, -1, -4],[3, 3, 4, 2, 3, 3],[-4, 1, -1, -1, -2, 3],[5, -2, 3, 4, 3, -2],[-2, 4, 4, -6, 3, 3],[3, -1, 0, 1, 3, -1]],
    [[0, 4, 0, 1],[4, 3, 4, 4],[0, 0, 0, 0],[4, 3, 4, 4],[0, 4, 0, 1]],
    [[2, 2, -1, 3, 1],[-2, 4, -1, -2, 3],[4, -2, 3, 4, -2],[0, 0, 3, -2, 3]],
    [[3, 8, 4, 4],[8, 3, 3, 7],[4, 3, 8, 6],[4, 8, 3, 4]],
    [[17, 15, 18, 19, 15],[14, 16, 15, 10, 16],[13, 19, 18, 20, 18],[17, 19, 15, 10, 16],[14, 16, 15, 20, 15]],
    [[-3, 0, 0, 0, 1, -2],[0, 1, -4, -3, -2, -2],[1, -5, 1, 2, -2, 1],[-4, 1, 1, -3, -5, 1],[0, 2, -5, 4, -5, 1],[1, -7, 3, -2, -4, 1]],
    [[30, 38, 28],[37, 21, 37],[31, 34, 33],[32, 28, 35],[35, 29, 32]]
]
let nowstage=Math.floor(Math.random()*stage.length),corrected=0,finished=[];
for(let i=0;i<stage.length;i++)finished[i]=false;
let point=stage[nowstage];
document.getElementById('now').textContent='stage '+nowstage;
document.getElementById('cor').textContent+=String(stage.length);
let point_old=[];
for(let i=0;i<point.length;i++){point_old[i]=point[i].slice(0,point[i].length);}
document.getElementById('set').addEventListener('click',function(){
    nowstage=Math.floor(Math.random()*(33+1));
    point=stage[nowstage];
    setbutton();
    point_old=[];
    for(let i=0;i<point.length;i++){point_old[i]=point[i].slice(0,point[i].length);}
    document.getElementById('now').textContent='stage '+nowstage;
});
document.getElementById('howto').addEventListener('click',function(){alert('数字を押すと周りの数字に1が分けられます。全てのマスを同じ数字にして「回答」を押しましょう。')});
document.getElementById('back').addEventListener('click',function (){
    for(let i=0;i<point_old.length;i++){point[i]=point_old[i].slice(0,point_old[i].length);}
    setbutton();
});
function setbutton(){
    let s='<table border="1">';
    for(let i=0;i<point.length;i++){
        s+='<tr>'
        for(let j=0;j<point[i].length;j++){
            s+='<td id="'+(i*point[i].length+j)+'">'+point[i][j]+'</td>';
        }
        s+='</tr>'
    }
    s+='</table>'
    let e=document.getElementById('t');
    e.innerHTML=s;
    for(let i=0;i<point.length;i++){
        for(let j=0;j<point[i].length;j++){
            let bt=document.getElementById(String(i*point[i].length+j));
            if(i==0 && j==0){
                bt.addEventListener('click',function(){
                    for(let i=0;i<point.length;i++){point_old[i]=point[i].slice(0,point[i].length);}
                    point[0][1]++;
                    point[1][0]++;
                    point[0][0]-=2;
                    setbutton();
                });
            }
            if(j>0 && j<point[0].length-1 && i==0){
                bt.addEventListener('click',function(){
                    for(let i=0;i<point.length;i++){point_old[i]=point[i].slice(0,point[i].length);}
                    point[i][j-1]++;
                    point[i][j+1]++;
                    point[i+1][j]++;
                    point[i][j]-=3;
                    setbutton();
                });
            }
            if(j==point[0].length-1 && i==0){
                bt.addEventListener('click',function(){
                    for(let i=0;i<point.length;i++){point_old[i]=point[i].slice(0,point[i].length);}
                    point[i][j-1]++;
                    point[i+1][j]++;
                    point[i][j]-=2;
                    setbutton();
                });
            }
            if(i>0 && i<point.length-1 && j==0){
                bt.addEventListener('click',function(){
                    for(let i=0;i<point.length;i++){point_old[i]=point[i].slice(0,point[i].length);}
                    point[i+1][j]++;
                    point[i-1][j]++;
                    point[i][j+1]++;
                    point[i][j]-=3;
                    setbutton();
                });
            }
            if(i>0 && i<point.length-1 && j>0 && j<point[0].length-1){
                bt.addEventListener('click',function(){
                    for(let i=0;i<point.length;i++){point_old[i]=point[i].slice(0,point[i].length);}
                    point[i+1][j]++;
                    point[i-1][j]++;
                    point[i][j+1]++;
                    point[i][j-1]++;
                    point[i][j]-=4;
                    setbutton();
                });
            }
            if(i>0 && i<point.length-1 && j==point[0].length-1){
                bt.addEventListener('click',function(){
                    for(let i=0;i<point.length;i++){point_old[i]=point[i].slice(0,point[i].length);}
                    point[i+1][j]++;
                    point[i-1][j]++;
                    point[i][j-1]++;
                    point[i][j]-=3;
                    setbutton();
                });
            }
            if(i==point.length-1 && j==0){
                bt.addEventListener('click',function(){
                    for(let i=0;i<point.length;i++){point_old[i]=point[i].slice(0,point[i].length);}
                    point[i-1][j]++;
                    point[i][j+1]++;
                    point[i][j]-=2;
                    setbutton();
                });
            }
            if(i==point.length-1 && j>0 && j<point[0].length-1){
                bt.addEventListener('click',function(){
                    for(let i=0;i<point.length;i++){point_old[i]=point[i].slice(0,point[i].length);}
                    point[i-1][j]++;
                    point[i][j-1]++;
                    point[i][j+1]++;
                    point[i][j]-=3;
                    setbutton();
                });
            }
            if(i==point.length-1 && j==point[0].length-1){
                bt.addEventListener('click',function(){
                    for(let i=0;i<point.length;i++){point_old[i]=point[i].slice(0,point[i].length);}
                    point[i-1][j]++;
                    point[i][j-1]++;
                    point[i][j]-=2;
                    setbutton();
                });
            }
        }
    }
}
setbutton();
document.getElementById('ans').addEventListener('click',function(){
    let mistake=false;
    for(let i=0;i<point.length;i++){
        for(let j=0;j<point[i].length;j++){
            if(point[0][0]!=point[i][j])mistake=true;
        }
    }
    if(!mistake){
        alert('正解!');
        if(!finished[nowstage])corrected++;
        finished[nowstage]=true;
        document.getElementById('cor').textContent='クリア '+corrected+'/'+stage.length;
    }
});