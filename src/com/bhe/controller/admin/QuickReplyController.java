package com.bhe.controller.admin;

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
public class QuickReplyController extends BaseController {

	HttpUtil util = new HttpUtil();

	/**
	 * 查询所有知识库列表
	 * 
	 * @param data
	 * @param model
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getQuickReplyList")
	public String knowledgeBase(@RequestParam Map<String, String> data, Model model, HttpSession session,String titleNo) {
		List<Map<String, Object>> listmap = null;
		int state = -1;
		
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
		
		model.addAttribute("titleNo", titleNo);
		data.remove("titleNo");
		
		Map<String, Object> userInfo = (Map<String, Object>) session.getAttribute("userinfo");
		data.put("userId", userInfo.get("uuid").toString());
		
		if (!CommonUtil.isEmpty(data.get("status"))) {
			Integer status = Integer.parseInt(data.get("status").toString());
			if (status == -1) {
				data.remove("status");
			}
		}
		Map<String, Object> result = super.getResult("/selectQuickReplyList", data);
		
		state = Integer.parseInt(result.get("state").toString());
		listmap = (List<Map<String, Object>>) result.get("list");

		// 根据state值判断返回页面
		if (state == 0 || state == -1) {
			return errorPage();
		} else if (state == 1) {
			if (!CommonUtil.isEmpty(listmap)) {
				for (Map<String, Object> map : listmap) {
					timeToDate(map);
				}
			}
		}
		model.addAttribute("pageIndex", data.get("pageIndex"));
		model.addAttribute("quickReplyList", result);
		
		return ".quickReply.quickReply";
	}

	/**
	 * 跳转添加快捷回复
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toAddQuickReply")
	public String toAddQuickReply(@RequestParam Map<String, String> data, Model model) {
		model.addAttribute("titleNo", data.get("titleNo"));
		return ".quickReply.addQuickReply";
	}

	/**
	 * jsy 添加快捷回复
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/addQuickReply", method = RequestMethod.POST)
	@ResponseBody
	public String addQuickReply(@RequestParam Map<String, String> data, Model model, HttpSession session) {
		int state = -1;
		
		Map<String, Object> userInfo = (Map<String, Object>) session.getAttribute("userinfo");
		
		data.put("userId", userInfo.get("uuid").toString());
		data.put("status", "1");
		
		Map<String, Object> result = super.getResult("/insertQuickReply", data);
		
		state = Integer.parseInt(result.get("state").toString());

		// 根据state值判断返回页面
		if (state == 0 || state == -1) {
			return errorPage();
		}
		
		String str = String.valueOf(state);
		
		return str;
	}

	/**
	 * jsy 修改快捷回复
	 * 
	 * @return
	 */
	@RequestMapping(value = "/updateQuickReply", method = RequestMethod.POST)
	@ResponseBody
	public String updateQuickReply(@RequestParam Map<String, String> data, Model model) {
		int state = -1;

		Map<String, Object> result = super.getResult("/updateQuickReply", data);
		
		state = Integer.parseInt(result.get("state").toString());

		// 根据state值判断返回页面
		if (state == 0 || state == -1) {
			return errorPage();
		}
		
		String str = String.valueOf(state);
		
		return str;
	}

	/**
	 * jsy 删除快捷回复
	 * 
	 * @return
	 */
	@RequestMapping(value = "/deleteQuickReply", method = RequestMethod.POST)
	@ResponseBody
	public String deleteQuickReply(@RequestParam Map<String, String> data, Model model) {
		int state = -1;

		Map<String, Object> result = super.getResult("/deleteQuickReply", data);
		
		state = Integer.parseInt(result.get("state").toString());

		// 根据state值判断返回页面
		if (state == 0 || state == -1) {
			return errorPage();
		}
		
		String str = String.valueOf(state);
		
		return str;
	}

	/**
	 * jsy 查看快捷回复详情
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getQuickReplyDetails")
	public String quickReplyDetails(@RequestParam Map<String, String> data, Model model, HttpSession session,String titleNo) {
		int state = -1;
		
		model.addAttribute("titleNo", titleNo);
		data.remove("titleNo");
		
		Map<String, Object> userInfo = (Map<String, Object>) session.getAttribute("userinfo");
		
		data.put("userId", userInfo.get("uuid").toString());
		Map<String, Object> map = null;
		
		Map<String, Object> result = super.getResult("/selectQuickReplyOne", data);
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
		
		model.addAttribute("quickReply", map);
		
		return ".quickReply.quickReplyDetails";
	}

	/**
	 * 修改快捷回复状态
	 * 
	 * @return
	 */
	@RequestMapping(value = "/checkQuickReply", method = RequestMethod.POST)
	@ResponseBody
	public String checkQuickReply(@RequestParam Map<String, String> data, Model model) {
		int state = -1;

		Map<String, Object> result = super.getResult("/updateQuickReply", data);
		state = Integer.parseInt(result.get("state").toString());

		// 根据state值判断返回页面和
		if (state == 0 || state == -1) {
			return errorPage();
		}
		
		String str = String.valueOf(state);
		
		return str;
	}
}
