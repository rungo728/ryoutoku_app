// レベルをチェックボックスで選んで、割引料金欄に合計額が表示される処理
discount=new Array();//チェックの有無を格納する配列
discount[0]=500;
discount[1]=1000;
discount[2]=1500;
discount[3]=2000;
discount[4]=2500;
function keisan(){
goukei=0;
for(i=0;i<=4;i++){
if(document.cooking_details.elements[i].checked==true){
goukei=goukei+discount[i];
}
}
document.cooking_details.total.value=goukei;
}
// チェックボックスを２つ選んだらそれ以上チェックできないようにする処理
checkbox=5;   //チェックボックスの数。
lim =2;   //チェックできる数
Limit = new Array();   //チェックの有無を格納する配列
function limit(){
v=0;   //チェックの合計
for (i=0; i<checkbox; i++){
Limit[i]=i;
if (document.cooking_details.elements[i].checked){Limit[i]="chk";　
v++;}
}
if(v>=lim){
for (i=0; i<checkbox; i++){
if(Limit[i]=="chk"){document.cooking_details.elements[i].disabled = "";}
else{document.cooking_details.elements[i].disabled = true;}
}
}
else{for (i=0; i<checkbox; i++)
document.cooking_details.elements[i].disabled = "";}

}
// ここがまだ不完全↓
// 割引額の合計を <div class="event_middle-row__profit">に表示させる
window.addEventListener('DOMContentLoaded', function(e){
  var val_a=parseInt(document.querySelector('span#cooking_waribiki').textContent);
  var val_b=parseInt(document.querySelector('span#cooking_waribiki2').textContent);
  document.querySelector('span#result').textContent=val_a+val_b;
});
$(document).on('turbolinks:load', function(){
  // $('#price-setting').ready(function(){
  //   var inputPrice = $('#price-setting').val();

  //   if(inputPrice  >= 300){
  //     $('.event_middle-row__profit').empty();
  //     $('.event_bottom-row__price').empty();
      
  //     var priceFee = Math.floor(inputPrice * 0.1)
  //     var profit = inputPrice - priceFee
      
  //     appendFee(priceFee)
  //     appendProfit(profit)
  //   }else{
  //     $('.value_middle-row__profit').empty();
  //     $('.value_middle-row__profit').append('-');
  //     $('.value_bottom-row__price').empty();
  //     $('.value_bottom-row__price').append('-');
  //   };
  // })
});