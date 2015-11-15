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
public class KnowledgeBaseController extends BaseController {

	HttpUtil util = new HttpUtil();

	/**
	 * 查询所有知识库列表
	 * 
	 * @param data
	 * @param model
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getKnowledgeBaseList")
	public String getKnowledgeBaseList(@RequestParam Map<String, String> data, Model model, HttpSession session,String titleNo) {
		List<Map<String, Object>> listmap = null;
		int state = -1;
		
		model.addAttribute("titleNo", titleNo);
		data.remove("titleNo");
		
		if (CommonUtil.isEmpty(data.get("pageIndex"))) {
			data.put("pageIndex", "1");
		}
		
		
		if (CommonUtil.isEmpty(data.get("pageSize"))) {
			data.put("pageSize", "15");
		}
		
		if (!CommonUtil.isEmpty(data.get("content"))) {
			model.addAttribute("content", data.get("content"));
		}
		
		Map<String, Object> userInfo = (Map<String, Object>) session.getAttribute("userinfo");
		Map<String, Object> departmentInfo = (Map<String, Object>) session.getAttribute("departmentinfo");
//		Map<String, Object> dataMap =  (Map<String, Object>) departmentInfo.get("data");
		
		data.put("systemIndex", userInfo.get("systemIndex").toString());
		data.put("departmentId", departmentInfo.get("uuid").toString());
		
		if (!CommonUtil.isEmpty(data.get("status"))) {
			model.addAttribute("status", data.get("status"));
			Integer status = Integer.parseInt(data.get("status").toString());
			
			if (status == -1) {
				data.remove("status");
			}
		}
		
		Map<String, Object> result = super.getResult("/selectKnowledgeBaseList", data);
		
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
		
		model.addAttribute("pageIndex", data.get("pageIndex"));
		model.addAttribute("knowledgeBaseList", result);

		return ".knowledgeBase.knowledgeBase";
	}

	/**
	 * 跳转添加知识库
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/toAddKnowledgeBase")
	public String toAddKnowledgeBase(@RequestParam Map<String, String> data, Model model) {
		List<Map<String, Object>> listmap = null;
		int state = -1;
		
		model.addAttribute("titleNo", data.get("titleNo"));
		data.remove("titleNo");
		// 获取问题分类列表
		Map<String, Object> result = super.getResult("/selectQuestionTypeList", data);
		
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
		model.addAttribute("questionTypeList", result);
		
		return ".knowledgeBase.addKnowledgeBase";
	}

	/**
	 * jsy 添加知识库
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/addKnowledgeBase", method = RequestMethod.POST)
	@ResponseBody
	public String addKnowledgeBase(@RequestParam Map<String, String> data, Model model, HttpSession session) {
		int state = -1;
		
		// 获取systemIndex
		Map<String, Object> userInfo = (Map<String, Object>) session.getAttribute("userinfo");
		Map<String, Object> departmentInfo = (Map<String, Object>) session.getAttribute("departmentinfo");
		
		if(!CommonUtil.isEmpty(departmentInfo.get("data"))){
			Map<String, Object> dataMap = (Map<String, Object>) departmentInfo.get("data");
			data.put("departmentId", dataMap.get("uuid").toString());
		}
		
		data.put("userId", userInfo.get("uuid").toString());
		data.put("systemIndex", userInfo.get("systemIndex").toString());
		
		if (!CommonUtil.isEmpty(data.get("questionTypeId"))) {
			String questionTypeId = data.get("questionTypeId").toString();
			if ("-1".equals(questionTypeId)) {
				data.remove("questionTypeId");
			}
		}
		
		Map<String, Object> result = super.getResult("/insertKnowledgeBase", data);
		
		state = Integer.parseInt(result.get("state").toString());

		// 根据state值判断返回页面和
		if (state == 0 || state == -1) {
			return errorPage();
		}
		
		String str = String.valueOf(state);
		
		return str;
	}

	/**
	 * jsy 修改知识库
	 * 
	 * @return
	 */
	@RequestMapping(value = "/updateKnowledgeBase", method = RequestMethod.POST)
	@ResponseBody
	public String updateKnowledgeBase(@RequestParam Map<String, String> data, Model model) {
		int state = -1;

		Map<String, Object> result = super.getResult("/updateKnowledgeBase", data);
		
		state = Integer.parseInt(result.get("state").toString());

		// 根据state值判断返回页面和
		if (state == 0 || state == -1) {
			return errorPage();
		}
		
		String str = String.valueOf(state);
		
		return str;
	}

	/**
	 * jsy 查看知识库详情
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getKnowledgeBaseDetails")
	public String getKnowledgeBaseDetails(@RequestParam Map<String, String> data, Model model, HttpSession session, String titleNo) {
		Map<String, Object> map = null;
		int state = -1;
		
		model.addAttribute("titleNo", titleNo);
		data.remove("titleNo");
		
		Map<String, Object> userInfo = (Map<String, Object>) session.getAttribute("userinfo");
		data.put("systemIndex", userInfo.get("systemIndex").toString());
		
		Map<String, Object> result = super.getResult("/selectKnowledgeBaseOne", data);
		state = Integer.parseInt(result.get("state").toString());
		map = (Map<String, Object>) result.get("data");

		// 根据state值判断返回页面和
		if (state == 0 || state == -1) {
			return errorPage();
		} else if (state == 1) {
			if (!CommonUtil.isEmpty(map)) {
				timeToDate(map);
			}
		}
		
		model.addAttribute("knowledgeBase", map);
		
		return ".knowledgeBase.knowledgeBaseDetails";
	}
}
