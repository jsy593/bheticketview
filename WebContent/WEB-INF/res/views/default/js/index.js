$(function() {
	$(".btnlogin").click(function() {
		var username = $(".txtlogin:first").val();
		var password = $(".txtlogin:last").val();
		if ("" != username && "" != password) {
			var url = "login";
			var data = {};
			data.username = username;
			data.password = password;
			console.info(data)
			$.post(url, data, function(data) {
				if (data.state == "1") {
					var roleInfo = data.roleInfo;
					if(roleInfo.code == 'superAdmin'){
						location.href = "getAdminList?titleNo=0";
					}else if(roleInfo.code == 'systemAdmin'){
						location.href = "getSystemManagerList?titleNo=0";
					}else if(roleInfo.code == 'departmentAdmin'){
						location.href = "getTicketList?titleNo=0";
					}else if(roleInfo.code == 'staff'){
						location.href = "getTicketList?titleNo=0";
					}
				}
				if (data.state == "4") {
					alert("用户不存在！");
				}
				if (data.state == "5") {
					alert("密码错误！");
				}
				if (data.state == "6") {
					alert("权限不足！");
				}
				if (data.state == "7") {
					alert("账号异常！");
				}
			});
		} else {
			alert("账号或密码不能为空!!");
		}
	});
	for ( var map in null) {
		alert("1")
	}
	console.info("123")
})