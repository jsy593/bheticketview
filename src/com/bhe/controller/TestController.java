package com.bhe.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedCaseInsensitiveMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bhe.develop.web.CachePool;
import com.bhe.util.HttpUtil;

/**
 * 测试
 * @author 陈建伟
 * @datetime 2015年9月12日上午10:31:41
 */
@Controller
public class TestController extends BaseController{
	
	@RequestMapping("/index")
	public String jumpIndex(){
		//抓取后台数据
		HttpUtil util = new HttpUtil();
		Map<String,String> map = new HashMap<String, String>();
		map.put("username", "张三");
		String path = this.servicePath;
		Map<String, Object> result = util.sendGetRequest(CachePool.baseProp.get("servicePath")+"/SRTreasure/userLogin.htm");
		Object object = result.get("respContent");
		System.out.println(result.size());
		return ".user.index";
		//return "/default/user/index";
	}
}
