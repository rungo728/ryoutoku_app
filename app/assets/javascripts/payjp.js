// $(document).on('turbolinks:load', function(){
// カード情報登録
document.addEventListener(
  "DOMContentLoaded", e => {
    if (document.getElementById("token_submit") != null) {//token_submitというidがnullの場合、下記コードを実行しない
      Payjp.setPublicKey("pk_test_6ad853c00546da3289e5579b");// payjp.jsの初期化（公開鍵を設定）

      //IDがtoken_submitのボタンが押下された場合
      let btn = document.getElementById("token_submit");//IDがtoken_submitの場合に取得される
      btn.addEventListener("click", e => {//ボタンが押されてイベント発火
        e.preventDefault();

        //入力されたデータを取得しカード情報を生成する
        let card = {
          number: document.getElementById("card_number").value,
          cvc: document.getElementById("cvc").value,
          exp_month: document.getElementById("exp_month").value,
          exp_year: document.getElementById("exp_year").value
        };
        console.log(card)

        //入力されたデータを取得
        // トークンを生成する
        Payjp.createToken(card, function(status, response) {
          if (status === 200) {
            // HTTPステータスが200の場合（成功の場合）
            $("#card_number").removeAttr("name");
            $("#cvc").removeAttr("name");
            $("#exp_month").removeAttr("name");
            $("#exp_year").removeAttr("name");//データを自サーバに保存しないようにname属性を削除

            // IDがcard_tokenの子要素の末尾にを追加する
            $("#card_token").append(
              $('<input type="hidden" name="payjp-token">').val(response.id)
            );

            //取得したトークンをcontroler側に送信する
            document.inputForm.submit();
            alert("登録が完了しました"); //確認用
          } else {
            // エラーがある場合処理しない。
            alert("カード情報が正しくありません。"); //確認用
          }
        });
      });
    }
  },
  false
);
// });