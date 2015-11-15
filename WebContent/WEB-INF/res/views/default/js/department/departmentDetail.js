$(function() {
	$.ajaxSetup({
		async : false
	});

	var departmentId = $(".departmentId").val()
	var systemIndex = $(".systemIndex").val();
	// 初始化
	init();

	function init() {
		getDeptUser();
	}

	function getDeptUser() {
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
				$(".deptUser").append(html);
			}
		}, "json");

		// 查询当前部门管理员
		var userData = {};
		userData.departmentId = departmentId;
		$.post("getDeptAdmin", userData, function(data) {
			if (data.state == "1") {
				$(".deptUser").val([ data.data.uuid ]);
			}
		}, "json");
	}

	// 变更部门管理员
	$(".deptUser").change(function() {
		var uuid = $(this).val();
		var data = {};
		data.uuid = uuid;
		data.departmentId = departmentId;
		var url = "updateDeptAdmin";
		$.post(url, data, function(data) {
			if (data.state == "1") {

			}
		}, "json");
	});
	//停用&& 启用
	$(".stop").click(function(){
		changeState(0);
	});
	$(".start").click(function(){
		changeState(1);
	});
	function changeState(status){
		var data = {};
		data.status = status;
		data.uuid = departmentId;
		var url = "updateDept";
		$.post(url, data, function(data){
			if (data.state == '1') {
				alert("修改成功!");
				window.location.href = "toDepartmentManager?systemIndex=" + systemIndex + "&titleNo=1";
			} else {
				alert("修改失败!");
			}
		},"json");
	}
})