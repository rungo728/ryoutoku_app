// レベルをプルダウンで選んで、計算ボタンを押した時に割引料金が表示される処理
function cooking_waribiki(ele, select_id) {
  var element = document.getElementById(select_id);
  var str = element.value;
  var cooking_id = "cooking_" + select_id;
  document.getElementById(cooking_id).textContent = str;
}
// ここがまだ不完全↓
// 割引額の合計を <div class="event_middle-row__profit">に表示させる
window.addEventListener('DOMContentLoaded', function(e){
  var val_a=parseInt(document.querySelector('span#cooking_waribiki').textContent);
  var val_b=parseInt(document.querySelector('span#cooking_waribiki2').textContent);
  document.querySelector('span#result').textContent=val_a+val_b;
});
$(document).on('turbolinks:load', function(){
  // ここもまだ不完全↓
  // 一つめで選んだレベルは２つ目では選べないようにする処理
  $('select').change(function () {
    $('select option[value="0"]').show()
    $('select').each(function (index, sel) {
      var disableValue = $(sel).val();
      $('select option[value="0"]:contains(' +disableValue+ ')').hide()
    })
  });

  // $(function () {
  //   var opt=$('select#waribiki2 option[value="0"]').clone();
  //   $("select#waribiki").on('change',function(){
  //     var str = $(this).val();
  //     if(str=="0"){
  //       $('select#waribiki2 option:first').before(opt);
  //     }else{
  //       $('select#waribiki2 option[value="300"]').hide();
  //     }
  //   });
  // });



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