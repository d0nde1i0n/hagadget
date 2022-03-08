//処理成功時に表示させるフラッシュメッセージの処理
$(function(){
  setTimeout("$('.success').fadeOut('nomal')", 2000);
});

// 処理失敗時に表示させるフラッシュメッセージの処理
$(function(){
  setTimeout("$('.failure').fadeOut('nomal')", 2000);
});
