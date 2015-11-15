$(function() {
	var parentId = $(".parentId").val();
	var departmentId = $(".departmentId").val();
	var systemIndex =  $(".systemIndex").val();
	init();
	function init() {
		// 得到大分类列表
		var data = {};
		data.departmentId = departmentId;
		data.parentId = "0";
		$
				.post(
						"getQuestionType",
						data,
						function(data) {
							var html = "";
							if (data.state == '1') {
								var list = data.list;
								for (var i = 0; i < list.length; i++) {
									html += "<ul>";
									html += "<li><a href='getSmallQuestionTypeList?titleNo=2&parentId="
											+ list[i].uuid
											+ "'>"
											+ list[i].typeName + "</a></li>";
									html += "</ul>";
								}
							}
							$(".systemList").append(html);
						});

	}

	var option = {
		theme : 'vsStyle',
		expandLevel : 1,
		beforeExpand : function($treeTable, id) {

			// 判断id是否已经有了孩子节点，如果有了就不再加载，这样就可以起到缓存的作用
			if ($('.' + id, $treeTable).length) {
				return;
			}

			// 获取数据
			var thisData = {};
			thisData.questionTypeId = id;
			thisData.status = 1;
			var url = "getQuestionTypeToUser";
			$.post(url,thisData,function(data) {
			var html = '';
			var list = data.list;
			if (data.state == "1") {
				for (var i = 0; i < list.length; i++) {
					html += '<tr id=' + list[i].uuid+ ' pId="' + id + '">';
					html += '<td>处理人员</td>';
					html += '<td>' + list[i].realName+ '</td>';
					html += '<td></td>';
					html += '<td><a href="#" id='+ list[i].uuid+ ' class="delQuestionToUser"" >删除</a></td>';
					html += '</tr>';
				}
			}
			$treeTable.addChilds(html);
		}, "json");
		},
		onSelect : function($treeTable, id) {
			window.console && console.log('onSelect:' + id);
		}
	}
	$('#treeTable').treeTable(option);

	// 删除分类对应关系
	$(document).on("click", ".delQuestionToUser", function() {
		var uuid = $(this).attr("id");
		var data = {}
		data.uuid = uuid;
		var url = "updateQuestionTypeForUser";
		data.status = 0;
		$.post(url, data, function(data) {
			if (data.state == 1) {
				$("#" + uuid).remove();
			}
		}, "json");
	});
	// 	// 停用&& 启用 分类对应关系
	$(document).on("change", ".userCheckBox", function() {
			var data = {};
			data.userId = $(this).val();
			data.questionTypeId = $(".js-questionId").val();
			data.systemIndex=systemIndex;
			if ($(this).prop("checked")) {
				data.status = 1;
			} else {
				//停用
				data.status = 0;
			}
			changeQuestionForUserState(data);
	});
	
	//改变 关系
	function changeQuestionForUserState(data){
		var url = 'updateQuestionTypeForUser';
		$.post(url, data, function(data){
			if(data.state != '1'){
				alert('修改失败!');
			}
		}, "json");
	}
	
	
	// 添加分类管理人员
	$('.addUser').click(function() {
		$(".js-questionId").val($(this).attr("data-questionId"))
		$.ajaxSetup({
			async : false
		});
		var departmentId = $(this).attr("data-departmentId");
		var data = {};
		data.departmentId = departmentId;
		$.post('getUser',data,function(data) {
			var html = "";
			$(".so-popbox-user").empty();
			if (data.state == '1') {
				
				var list = data.list;
				for (var i = 0; i < list.length; i++) {
					html += "<input type=checkbox class=userCheckBox value="
							+ list[i].uuid
							+ ">"
							+ list[i].realName
							+ "  ";
				}
			}
			$(".so-popbox-user").append(html);
		}, "json");

		var thisData = {};
		thisData.questionTypeId = $(this).attr(
				'data-questionId');
		thisData.status = 1;
		var url = "getQuestionTypeToUser";
		$.post(url, thisData, function(data) {
			if (data.state == '1') {
				var list = data.list;
				var $userCheckBox = $(".userCheckBox");
				var array = [];
				for (var i = 0; i < list.length; i++) {
					array.push(list[i].userId);
				}
				$userCheckBox.val(array);
			}
		}, "json");

		$.sobox.pop({
			popTarget : 'div.so-addUser-popbox',
			wrapTarget : false,
			maskClick : false,
			title : "添加人员",
		});
	});

	// 停用&& 启用 分类
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
				if (parentId == '' || parentId == "-1") {
					alert('请选择大分类！');
					return false;
				}
				// 获取 职员列表
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
					popTarget : 'div.so-addQuestion-popbox',
					wrapTarget : false,
					maskClick : false,
					title : "添加分类",
				});
			})

});
