$(function() {
	// 冻结 、 启用
	$(".stop").click(function() {
		var data = {};
		data.uuid = $(this).attr("data-uuid");
		data.status = 2;
		changeStatus(data);
	})
	$(".start").click(function() {
		var data = {};
		data.uuid = $(this).attr("data-uuid");
		data.status = 1;
		changeStatus(data);
	})

	function changeStatus(data) {
		var url = "updateSystemStatus";
		$.post(url, data, function(data) {
			if (data.state == "1") {
				window.location.reload();
			}
		})
	}
	$(".addSystem").click(function(){
		$.sobox.pop({
			popTarget:'div.so-popbox',
			wrapTarget:false,
			maskClick : false,
			title:"添加系统",
		});
	});
})
