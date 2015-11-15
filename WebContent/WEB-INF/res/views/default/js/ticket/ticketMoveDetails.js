$(function() {
	var departmentId = $('.departmentId').val();
	var userId = $(".userId").val();
	$('.reject').click(function() {
		$.sobox.pop({
			popTarget : 'div.so-reject-popbox',
			wrapTarget : false,
			maskClick : false,
			title : "驳回",
		});
	})
	$('.distribution').click(function() {
		var data = {};
		data.departmentId = departmentId;
		var url = "getUser";
		$.post(url, data, function(data) {
			if (data.state == "1") {
				var html = "";
				var list = data.list;
				for (var i = 0; i < list.length; i++) {
					html += "<option value=" + list[i].uuid + ">"
							+ list[i].realName + "</option>";
				}
				$(".selectUser").append(html);
			}
		}, "json");
		$.sobox.pop({
			popTarget : 'div.so-distribution-popbox',
			wrapTarget : false,
			maskClick : false,
			title : "分配",
		});
	})
	$(".pass").click(function() {
		var data = {};
		data.uuid = $(".uuid").val();
		var url = "passTicketMove";
		$.post(url, data, function(data) {
			if (data.state == '1') {
				window.location.href ='getTicketMoveList?audtId=' + userId + '&titleNo=3';
			} else {
				alert("审核失败!");
			}

		}, 'json');
	})

})