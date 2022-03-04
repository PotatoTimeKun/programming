document.getElementById("bt").addEventListener("click",function(){document.getElementById("bt").textContent="changed text";});
document.getElementById("con").addEventListener("click",function(){
    console.log(document.getElementById("inp").value);
});
document.getElementById("ch").addEventListener("change",function(){
    if(document.getElementById("ch").checked)console.log("checked");
});