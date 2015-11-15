function addQuickReply(){
	var title = $(".js_title").val();
	var content = $(".js_content").val();
	var data = {};
	if($.trim(title) !="" && $.trim(title) != undefined ){
		data.title = title;
	}
	if($.trim(content) !="" && $.trim(content) != undefined){
		data.content = content;
	}
	$.ajax({
		type : "post",
		url : "addQuickReply",
		data : data,
		dataType :"json",
		success : function(state) {
			if(state == 1){
				alert("添加成功!");
				window.location.href='getQuickReplyList?titleNo=2';
			}else{
				alert("添加失败!");
			}
		}
	});
}