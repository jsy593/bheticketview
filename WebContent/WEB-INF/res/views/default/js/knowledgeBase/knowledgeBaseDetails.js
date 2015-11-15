function changeStatus(state, uuid, systemIndex) {
	$.post('updateKnowledgeBase', {
		status : state,
		uuid : uuid,
		systemIndex : systemIndex
	}, function(data) {
		console.info(data)
		if (data == '1') {
			window.location.href = "getKnowledgeBaseList?titleNo=1";
		} else {
			alert('修改失败');
		}
	})
}