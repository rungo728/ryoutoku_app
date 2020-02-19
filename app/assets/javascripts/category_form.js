$(document).on('turbolinks:load', function(){

  function appendOption(category){
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }

  //子カテゴリのhtml
  function appendChildrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `
                       <select class='category-child select-default add-category' name='event[child]' id='child_category'>
                         <option value='---' data-category='---'>---</option>
                          ${insertHTML}
                       </select>
                      `;
    $('.category-add').append(childSelectHtml);
  }

  //孫カテゴリのhtml
  function appendGrandchildBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `
                            <select class='category-grandchild select-default add-category' name='event[category_id]' id='grandchild_category'>
                             <option value='---' data-category='---'>---</option>
                              ${insertHTML}
                            </select>
                           `;
    $('.category-add').append(grandchildSelectHtml);
  }


  //親カテゴリを選択した時
  $("#parent-form").on("change", function(){
    // 親ボックスのidを取得してそのidをAjax通信でコントローラーへ送る
    var parentValue = document.getElementById("parent-form").value;
    $('.category-child').remove();
    $('.category-grandchild').remove();
    $('.detail-add-content').empty();
    $('.detail-add-content2').empty();
    //("parent-form")は親ボックスのid属性
    $.ajax({
      url: '/events/events/get_category_children',//eventコントローラーのget_category_childrenに送る
      type: "GET",
      data: {parent_id: parentValue //親ボックスの値をparent_idという変数にする。
       },
      dataType: 'json'
    })
    //Ajax通信が成功した(done)ときに
    .done(function(children){

      $('.category-child').remove();
      $('.category-grandchild').remove();
      $('.detail-add-content').empty();
      $('.detail-add-content2').empty();

      var insertHTML = '';
      children.forEach(function(child){
        insertHTML += appendOption(child);
      });
      appendChildrenBox(insertHTML);
    })
  });

  //子カテゴリを選択した時
  $(".event-images-category").on("change", "#child_category", function(){
    // 子ボックスのidを取得してそのidをAjax通信でコントローラーへ送る
    var childValue = document.getElementById("child_category").value;
    $('.category-grandchild').remove();
    $('.detail-add-content2').empty();
    //("event-images__category")は子ボックスのclass属性
    if (childValue != "---"){
      $.ajax({
        url: '/events/events/get_category_grandchildren',//eventコントローラーのget_category_grandchildrenに送る
        type: 'GET',
        data: { child_id: childValue },//子ボックスの値をchild_idという変数にする。
        dataType: 'json'
      })
      //Ajax通信が成功した(done)ときに
      .done(function(grandchildren){

        $('.category-grandchild').remove();
        $('.detail-add-content').empty();

        var insertHTML = '';
        grandchildren.forEach(function(grandchild){
          insertHTML += appendOption(grandchild);
        });
        appendGrandchildBox(insertHTML);
      })
    }else{
      $('.category-grandchild').remove();
      $('.detail-add-content').empty();
    }
  });
})