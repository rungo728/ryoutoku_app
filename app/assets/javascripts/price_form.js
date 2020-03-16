// レベルをチェックボックスで選んで、割引料金欄に合計額が表示される処理
discount=new Array();//チェックの有無を格納する配列
discount[2]=500;
discount[3]=1000;
discount[4]=1500;
discount[5]=2000;
discount[6]=2500;
function keisan(){
goukei=0;
for(i=0;i<=6;i++){
if(document.cooking_details.elements[i].checked==true){
goukei=goukei+discount[i];
}
}
document.cooking_details.total.value=goukei;
}
// チェックボックスを２つ選んだらそれ以上チェックできないようにする処理
var limit =2; //チェックできる数
Flag = new Array(); //チェックの有無を格納する配列

function Climit(){
  var v=0; //チェックの合計
  var Myname = document.getElementsByName("c2");// 指定したnameの要素をすべて取得
  for (i=0; i<Myname.length; i++){//Myname.lengthはc2の数、その数だけiを繰り返してc2のそれぞれの情報をMyname[i] に格納します。
      Flag[i]=i; // 配列Flagを初期化
  if(Myname[i].checked){Flag[i]="chk"; // チェックが入っていれば文字列 "chk" を代入
  v++;}//チェックの合計数を 1 増やします
  }
  if(v>=limit){ //チェックの合計数が制限数になれば
  alert("チェックは"+limit+"つまでです")
  for (i=0; i<Myname.length; i++){
  if(Flag[i]=="chk"){Myname[i].disabled =false;}//チェックの数が制限数になればチェックが入っていれば有効化
  else{Myname[i].disabled = true;}// その他はすべて無効化にします
  }
  }
  else{for (i=0; i<Myname.length; i++)
  Myname[i].disabled =false;}//（入力可能 有効）
}

// 割引価格を差し引いた金額をイベント予約価格に反映させる処理
function update_price(){
    
  var result = $('#price').val() - $('#discount').val();
  // ビューに表示させるため
  $('#total').text(result);
  // ビューのvalueで受け取るため
  document.getElementById("result").value = result;
  // $('.update').data('sample')

}


$(function() {
$('input[type="text"]').on('keyup change', function() {
  update_price();
});
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