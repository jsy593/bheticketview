package com.bhe.controller.admin;

import java.lang.ProcessBuilder.Redirect;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bhe.controller.BaseController;
import com.bhe.util.CommonUtil;
import com.bhe.util.HttpUtil;
import com.bhe.util.JsonUtil;

@Controller
public class SystemController extends BaseController {

	HttpUtil util = new HttpUtil();

	/**
	 * 跳转添加系统
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toAddSystem", method = RequestMethod.POST)
	public String toAddSystem(@RequestParam Map<String, String> data, Model model) {

		return "default/system/addSystem";
	}

	/**
	 * jsy 添加系统
	 * 
	 * @return
	 */
	@RequestMapping(value = "/addSystem", method = RequestMethod.POST)
	public String addSystem(@RequestParam Map<String, String> data, Model model) {
		Map<String, Object> result = super.getResult("/insertSystem", data);
		
		model.addAttribute("result", result);
		
		return "redirect:getSystemManagerList?userId=" + data.get("userId") + "&titleNo=0";
	}

	/**
	 * yc 系统管理员维护部门
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getSystemManagerList")
	public String getSystemManagerList(Model model, @RequestParam Map<String, String> data, String titleNo,HttpSession session) {
		model.addAttribute("titleNo", titleNo);
		data.remove("titleNo");
		
		data.remove("base");
		data.remove("fullPath");
		
		//获取当前用户的uuid
		Map<String, Object> userInfo = (Map<String, Object>) session.getAttribute("userinfo");
		String userId = userInfo.get("uuid").toString();
		data.put("userId", userId);
		
		if(CommonUtil.isEmpty(data.get("pageIndex"))){
			data.put("pageIndex", "1");
		}
		
		if(CommonUtil.isEmpty(data.get("pageSize"))){
			data.put("pageSize", "15");
		}
		
		Map<String, Object> result = super.getResult("/selectSystemList", data);
		
		if ("1".equals(result.get("state"))) {
			string2Data(result);
		}
		
		model.addAttribute("data", result);
		model.addAttribute("pageIndex", data.get("pageIndex"));
		
		return ".system.systemManagement";
	}

	/**
	 * yc 系统管理员维护部门
	 * 
	 * @return
	 */
	@RequestMapping(value = "/getSystemManager")
	@ResponseBody
	public Map<String, Object> getSystemManager(Model model, String uuid) {
		Map<String, String> data = new HashMap<String, String>();
		
		data.put("userId", uuid);

		Map<String, Object> result = super.getResult("/selectSystemList", data);
		
		if ("1".equals(result.get("state"))) {
			string2Data(result);
		}
		
		return result;
	}

	/**
	 * 审核系统
	 * 
	 * @return
	 */
	@RequestMapping(value = "/checkSystem", method = RequestMethod.POST)
	@ResponseBody
	public String checkSystem(@RequestParam Map<String, String> data, Model model) {
		int state = -1;

		Map<String, Object> result = super.getResult("/checkSystem", data);
		state = Integer.parseInt(result.get("state").toString());

		// 根据state值判断返回页面和
		if (state == 0 || state == -1) {
			return errorPage();
		}
		
		String str = String.valueOf(state);
		
		return str;
	}

	/**
	 * jsy 跳转系统列表页面
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getSystemList")
	public String getSystemList(@RequestParam Map<String, String> data, Model model, String titleNo) {
		List<Map<String, Object>> listmap = null;
		int state = -1;
		
		model.addAttribute("titleNo", titleNo);
		data.remove("titleNo");
		
		if (!CommonUtil.isEmpty(data.get("content"))) {
			model.addAttribute("content", data.get("content"));
		}
		
		if (!CommonUtil.isEmpty(data.get("status"))) {
			model.addAttribute("status", data.get("status"));
		}
		
		if (CommonUtil.isEmpty(data.get("pageIndex"))) {
			data.put("pageIndex", "1");
		}
		
		if (CommonUtil.isEmpty(data.get("pageSize"))) {
			data.put("pageSize", "15");
		}


		if (!CommonUtil.isEmpty(data.get("status"))) {
			Integer status = Integer.parseInt(data.get("status").toString());
			if (status == -1) {
				data.remove("status");
			}
		}
		Map<String, Object> result = super.getResult("/selectSystemList", data);
		state = Integer.parseInt(result.get("state").toString());
		listmap = (List<Map<String, Object>>) result.get("list");

				// 根据state值判断返回页面和
		if (state == 0 || state == -1) {
			return errorPage();
		} else if (state == 1) {
			if (!CommonUtil.isEmpty(listmap)) {
				for (Map<String, Object> map : listmap) {
					timeToDate(map);
				}
			}
		}
			
		
		model.addAttribute("systemList", result);
		model.addAttribute("pageIndex", data.get("pageIndex"));
		
		return ".system.system";

	}

	/**
	 * yc 修改系统状态
	 * 
	 * @return
	 */
	@RequestMapping(value = "/updateSystemStatus", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> changeSystemStatus(@RequestParam Map<String, String> data, Model model) {
		Map<String, Object> result = super.getResult("/updateSystemStatus", data);
		
		return result;
	}

	/**
	 * yc 部门管理员列表
	 * 
	 * @return
	 */
	@RequestMapping(value = "/selectDeptAdminList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> selectDeptAdminList(@RequestParam Map<String, String> data, Model model) {
		Map<String, Object> result = super.getResult("/selectDeptAdminList", data);
		
		return result;
	}

	/**
	 * jsy 跳转系统详情
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getSystemDetails")
	public String adminDetails(@RequestParam Map<String, String> data, Model model, String titleNo) {
		Map<String, Object> map = null;
		int state = -1;
		
		model.addAttribute("titleNo", titleNo);
		data.remove("titleNo");
		
		Map<String, Object> result = super.getResult("/selectSystemOne", data);

		state = Integer.parseInt(result.get("state").toString());
		map = (Map<String, Object>) result.get("data");

		// 根据state值判断返回页面
		if (state == 0) {
			return errorPage();
		} else if (state == 1) {
			if (!CommonUtil.isEmpty(map)) {
				timeToDate(map);
			}
		}
		model.addAttribute("system", map);
		
		return ".system.systemDetails";
	}

}
