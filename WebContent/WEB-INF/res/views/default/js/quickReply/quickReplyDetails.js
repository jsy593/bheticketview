function changeStatus(state){
	
		var data = {};
		var uuid = $(".js_uuid").val();
		var status = state;
		data.status = state;
		data.uuid=uuid;
		$.ajax({
			type : "post",
			url : "checkQuickReply",
			data : data,
			success : function(state) {
				if(state == 1){
					alert("修改成功!");
					window.location.href="getQuickReplyList?titleNo=2";
				}else{
					alert("修改失败!");
				}
			},
	});
	
}