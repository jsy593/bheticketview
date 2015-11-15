package com.bhe.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.bhe.develop.web.CachePool;
import com.bhe.util.CommonUtil;
import com.bhe.util.DateUtil;
import com.bhe.util.HttpUtil;
import com.bhe.util.JsonUtil;

/**
 * 基础controller
 * 
 * @author 陈建伟
 * @datetime 2015年9月12日上午10:35:13
 */

public class BaseController {

	/**
	 * 字符集 UTF-8
	 */
	public static final String UTF8 = "UTF-8";

	/**
	 * service系统路径
	 */
	protected String servicePath = "";

	public BaseController() {
		// this.servicePath = CachePool.baseProp.get("servicePath");
		Map<String, String> map = CachePool.baseProp;
		if (null != map) {
			this.servicePath = map.get("servicePath");
		}
	}

	public String errorPage() {
		return "error/404";
	}
	/**
	 * 得到跳转路径
	 * 
	 * @param targetUrl
	 * @return
	 * @author 陈建伟
	 *         <ul>
	 *         <li>陈建伟 2015年9月12日上午10:51:53 新建该方法</li>
	 *         </ul>
	 */
	// protected String getViewPath(String targetUrl) {
	//
	// return CachePool.baseProp.get("themeName") + "/" + targetUrl;
	// }

	/**
	 * 初始化路径,存入全局变量
	 * 
	 * @param request
	 * @param response
	 * @param model
	 */
	@ModelAttribute
	public void initPath(HttpServletRequest request, HttpServletResponse response, ModelMap model) {
		String base = request.getContextPath();

		String fullPath = request.getScheme() + "://" + request.getServerName() + base;
		model.addAttribute("base", base);
		model.addAttribute("fullPath", fullPath);
	}

	/**
	 * 将 map 里面的Date时间 转换为 String
	 * 
	 * @param result
	 */
	@SuppressWarnings("unchecked")
	public void string2Data(Map<String, Object> result) {
		if ("1".equals(result.get("state").toString())) {
			if (!CommonUtil.isEmpty(result.get("list"))) {
				List<Map<String, Object>> listmap = (List<Map<String, Object>>) result.get("list");
				
				for (Map<String, Object> map : listmap) {
					String datestr = DateUtil.getDateString(map.get("createTime"), DateUtil.YYYY_MM_DD_HH_MM);
					map.put("createTime", datestr);
				}
			}

			if (!CommonUtil.isEmpty(result.get("data"))) {
				Map<String, Object> map = (Map<String, Object>) result.get("data");
				
				String datestr = DateUtil.getDateString(map.get("createTime"), DateUtil.YYYY_MM_DD_HH_MM);
				map.put("createTime", datestr);
			}
		}
	}

	/**
	 * 性别转汉字
	 * 
	 * @param dataMap
	 */
	public void sexToStr(Map<String, Object> dataMap) {
		if (!CommonUtil.isEmpty(dataMap)) {
			if ("0".equals(dataMap.get("sex") + "")) {
				dataMap.put("sex", "女");
			} else if ("1".equals(dataMap.get("sex") + "")) {
				dataMap.put("sex", "男");
			}
		}
	}

	/**
	 * 时间转日期
	 * 
	 * @param dataMap
	 */
	public void timeToDate(Map<String, Object> dataMap) {
		if (!CommonUtil.isEmpty(dataMap) && dataMap.containsKey("createTime")) {
			String datestr = DateUtil.getDateString(dataMap.get("createTime"), DateUtil.YYYY_MM_DD_HH_MM);
			dataMap.put("createTime", datestr);
		}
	}

	public Map<String, Object> getResult(String path, Map<String,String> data){
		HttpUtil util = new HttpUtil();
		Map<String, Object> sendPostMapRequest = util.sendPostMapRequest(servicePath + path, data, UTF8);
		Map<String, Object> result = JsonUtil.readJson2Map(sendPostMapRequest.get("respContent").toString());
		return result;
	}
}
