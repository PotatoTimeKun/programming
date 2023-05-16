function numberToDate(number){
    let monthDay=[31,28,31,30,31,30,31,31,30,31,30,31];
    number%=365;
    date=[1,1];
    for(let i=0;i<12;i++){
        if(number-monthDay[i]<=0){
            date[0]=i+1;
            date[1]=number;
            break;
        }
        number-=monthDay[i];
    }
    return date;
}

function sortDates(dateList){
    for(let i=0;i<dateList.length-1;i++){
        for(let j=i;j<dateList.length;j++){
            if(31*dateList[i][0]+dateList[i][1]>31*dateList[j][0]+dateList[j][1]){
                let tmp=dateList[i];
                dateList[i]=dateList[j];
                dateList[j]=tmp;
            }
        }
    }
}

function sameAsMine(n){
    let pow=1.0;
    for(let i=0;i<n-1;i++)pow*=364.0/365.0;
    return 1.0-pow;
}

function sameDate(n){
    if(n>365)return 1.0;
    let mul=1.0;
    for(let i=364;i>364-(n-1);i--)mul*=i/365.0;
    return 1.0-mul;
}

let run=document.getElementById("showTable");
run.addEventListener("click",function(){
    let table=document.getElementById("resultTable");
    let date=document.getElementById("date").valueAsDate;
    let myBirthday=[date.getMonth()+1,date.getDate()];
    let n=parseInt(document.getElementById("peopleNumber").value);
    let birthdays=[];
    for(let i=0;i<n-1;i++){
        birthdays[i]=numberToDate(Math.floor(Math.random()*365)+1);
    }
    birthdays[n-1]=myBirthday;
    sortDates(birthdays);
    let tableInner="<tbody>";
    for(let i=0;i<birthdays.length/10;i++){
        tableInner+="<tr>";
        for(let j=0;j<10 && 10*i+j<birthdays.length;j++){
            let tag="<td ";
            let now=String(birthdays[10*i+j])
            let before=10*i+j==0?"none":String(birthdays[10*i+j-1]);
            let next=10*i+j==n-1?"none":String(birthdays[10*i+j+1]);
            if(now==String(myBirthday))
                tag+='style="background-color:rgb(255,100,100)"';
            else if(now==before || now==next)
                tag+='style="background-color:rgb(100,100,255)"';
            tag+=">";
            tableInner+=tag+birthdays[10*i+j].join("/")+"</td>";
        }
        tableInner+="</tr>";
    }
    tableInner+="</tbody>";
    table.innerHTML=tableInner;
    let text=document.getElementById("probability");
    text.innerText="自分と同じ誕生日がいる確率: 1-(364/365)^(n-1) = "+String((sameAsMine(n)*100).toFixed(3))+"%";
    text.innerText+="\n同じ誕生日の組が存在する確率: 1 (n>365) , 1-364!/((364-(n-1))!365^(n-1)) (n<=365) = "+String((sameDate(n)*100).toFixed(3))+"%";
});