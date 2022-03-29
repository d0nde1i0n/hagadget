// 処理成功時に表示させるフラッシュメッセージの処理
// 2秒後に表示させたメッセージを0.4秒かけて消す
$(function(){
  setTimeout("$('.notice').fadeOut('nomal')",2000);
});

// 処理失敗時に表示させるフラッシュメッセージの処理
// 5秒後に表示させたメッセージを0.4秒かけて消す
$(function(){
  setTimeout("$('.alert').fadeOut('nomal')",5000);
});
