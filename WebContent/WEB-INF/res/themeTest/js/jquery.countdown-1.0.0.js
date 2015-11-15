;$(function ($){
	$.fn.countdown = function (options){
		
		var setting = {
			time:60, // 倒计时时间，默认为60秒
			interval:1000, // 间隔时间默认为1000毫秒 即是1秒
			execMethod:$.noop, // 倒计时中 执行方法
			endMethod:$.noop // 倒计时执行完成的方法
		};
		
		setting = $.extend(setting,options);
		
		var tempTime = setting.time;
		exec(tempTime);
		
		
		function exec(time){
			if (tempTime == 0){
				tempTime = setting.time;
				setting.endMethod();
			}else {
				tempTime--;
				setting.execMethod(tempTime);
				setTimeout(function (){
					exec(tempTime);
				},setting.interval);
			}
		};
		
	};
}(jQuery));