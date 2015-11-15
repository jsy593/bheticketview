$(function() {
	var systemIndex = $(".systemIndex").val();
	var departmentId;
	var systemAdminId = $(".systemAdminId").val();
	init(systemAdminId);
	function init(uuid) {
		// 得到系统列表
		var data = {};
		data.uuid = uuid;
		$.post("getSystemManager", data, function(data) {
			var html = "";
			if (data.state == '1') {
				var list = data.list;
				for (var i = 0; i < list.length; i++) {
					html += "<ul>";
					html += "<li><a href='getBigQuestionTypeList?titleNo=2&systemIndex="
							+ list[i].systemIndex + "'>" + list[i].systemName
							+ "</a></li>";
					html += "</ul>";
				}
			}
			$(".systemList").append(html);
		});

	}

	// 停用&& 启用
	$(".stop").click(function() {
		changeState(0, $(this).attr('data-uuid'));
	});
	$(".start").click(function() {
		changeState(1, $(this).attr('data-uuid'));
	});
	function changeState(status, uuid) {
		var data = {};
		data.status = status;
		data.uuid = uuid;
		var url = "updateQuestionType";
		$.post(url, data, function(data) {
			if (data.state == '1') {
				window.location.reload();
			}
		}, "json");
	}

	// 添加分类
	$('.addQuestionType').click(
			function() {
				if (systemIndex == '-1' || systemIndex == null) {
					alert('请选择系统！');
					return false;
				}
				// 获取 部门列表
				var data = {};
				data.systemIndex = systemIndex;
				$.post('getDepartmentManager', data, function(data) {
					var html = '';
					if (data.state == '1') {
						var list = data.list;
						for (var i = 0; i < list.length; i++) {
							html += '<option value=' + list[i].uuid + '>'
									+ list[i].name + '</option>';
						}
					}
					$(".selectQuestion").append(html);
				})
				$.sobox.pop({
					popTarget : 'div.so-addQuestion-popbox',
					wrapTarget : false,
					maskClick : false,
					title : "添加分类",
				});
			})

});
