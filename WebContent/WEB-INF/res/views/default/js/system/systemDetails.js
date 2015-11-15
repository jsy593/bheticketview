function changeStatus(state){
		var data = {};
		var uuid = $(".js_uuid").val();
		var systemName = $(".js_systemName").val();
		var status = state;
		data.status = state;
		data.uuid=uuid;
		data.systemName = systemName;
		$.ajax({
			type : "post",
			url : "checkSystem",
			data : data,
			success : function(state) {
				if(state == 1){
					alert("审核成功!");
					window.location.href="getSystemList?titleNo=1";
				}else{
					alert("审核失败!");
				}
			},
	});
}

function startSystem(state) {
	var url = "updateSystemStatus";
	var data = {};
	var uuid = $(".js_uuid").val();
	var status = state;
	data.status = state;
	data.uuid=uuid;
	
	if(confirm("确认吗?")){
		$.post(url, data, function(data) {
			if (data.state == "1") {
				alert("审核成功!");
				window.location.reload();
			}else{
				alert("审核失败!");
				
			}
		})
	}
}