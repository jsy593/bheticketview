$(function(){
	// 添加部门
	$('.addUser').click(function() {
		$.sobox.pop({
			popTarget : 'div.so-addUser-popbox',
			wrapTarget : false,
			maskClick : false,
			title : "添加职员",
		});
	})
})
