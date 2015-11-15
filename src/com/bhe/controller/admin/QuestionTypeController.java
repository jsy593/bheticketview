package com.bhe.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.websocket.server.PathParam;

import org.apache.jasper.tagplugins.jstl.core.Redirect;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bhe.controller.BaseController;
import com.bhe.util.CommonUtil;
import com.bhe.util.DateUtil;
import com.bhe.util.HttpUtil;
import com.bhe.util.JsonUtil;
import com.sun.org.glassfish.gmbal.ParameterNames;

/**
 * 用户
 * 
 * @author 易川
 * @datetime 2015年9月12日上午10:31:41
 */
@Controller
public class QuestionTypeController extends BaseController {

	HttpUtil util = new HttpUtil();

	/**
	 * yc 跳转到问题分类list(大)
	 * 
	 * @return
	 */
	@RequestMapping(value = "/getBigQuestionTypeList")
	public String getBigQuestionTypeList(Model model, @RequestParam Map<String, String> data, String titleNo) {
		model.addAttribute("titleNo", titleNo);
		
		data.remove("titleNo");
		data.remove("base");
		data.remove("fullPath");
		
		if (CommonUtil.isEmpty(data.get("systemIndex"))) {
			data.put("systemIndex", "-1");
		}
		
		if (CommonUtil.isEmpty(data.get("pageIndex"))) {
			data.put("pageIndex", "1");
		}
		
		if (CommonUtil.isEmpty(data.get("pageSize"))) {
			data.put("pageSize", "15");
		}

		data.put("parentId", "0");
		
		Map<String, Object> result = super.getResult("/selectQuestionTypeList", data);
		
		string2Data(result);
		
		model.addAttribute("systemIndex", data.get("systemIndex"));
		model.addAttribute("pageIndex", data.get("pageIndex"));
		model.addAttribute("data", result);

		return ".questionType.questionTypeManager";
	}

	/**
	 * yc 跳转到问题分类list(小)
	 * 
	 * @return
	 */
	@RequestMapping(value = "/getSmallQuestionTypeList")
	public String getSmallQuestionTypeList(Model model, @RequestParam Map<String, String> data, String titleNo) {
		model.addAttribute("titleNo", titleNo);
		
		data.remove("titleNo");
		data.remove("base");
		data.remove("fullPath");
		
		if (CommonUtil.isEmpty(data.get("parentId"))) {
			data.put("parentId", "-1");
		}
		
		if (CommonUtil.isEmpty(data.get("pageIndex"))) {
			data.put("pageIndex", "1");
		}
		
		if (CommonUtil.isEmpty(data.get("pageSize"))) {
			data.put("pageSize", "15");
		}

		Map<String, Object> result = super.getResult("/selectQuestionTypeList", data);
		
		string2Data(result);
		
		model.addAttribute("data", result);
		model.addAttribute("parentId", data.get("parentId"));
		model.addAttribute("pageIndex", data.get("pageIndex"));
		
		return ".questionType.questionTypeManagerSmall";
	}

	/**
	 * yc 跳转到问题分类单挑
	 * 
	 * @return
	 */
	@RequestMapping(value = "/getQuestionTypeDetail")
	public String getQuestionTypeDetail(Model model, String uuid, String titleNo) {
		Map<String, String> data = new HashMap<String, String>();
		
		model.addAttribute("titleNo", titleNo);
		
		data.put("uuid", uuid);

		Map<String, Object> result = super.getResult("/selectQuestionTypeOne", data);
		
		model.addAttribute("data", result.get("data"));

		return ".questionType.questionTypeDetail";
	}

	/**
	 * yc 添加问题分类
	 * 
	 * @return
	 */
	@RequestMapping(value = "/addQuestionType")
	public String addQuestionType(Model model, @RequestParam Map<String, String> dataMap) {

		Map<String, Object> result = super.getResult("/insertQuestionType", dataMap);
		
		model.addAttribute("data", result);

		return "redirect:getBigQuestionTypeList?titleNo=2&systemIndex=" + dataMap.get("systemIndex").toString();
	}

	/**
	 * yc 添加问题分类(小)
	 * 
	 * @return
	 */
	@RequestMapping(value = "/addQuestionTypeSmall")
	public String addQuestionTypeSmall(Model model, @RequestParam Map<String, String> dataMap) {

		Map<String, Object> result = super.getResult("/insertQuestionType", dataMap);
		
		model.addAttribute("data", result);

		return "redirect:getSmallQuestionTypeList?titleNo=2&parentId=" + dataMap.get("parentId").toString();
	}

	/**
	 * yc 改变分类状态
	 * 
	 * @return
	 */
	@RequestMapping(value = "/updateQuestionType")
	@ResponseBody
	public Map<String, Object> updateQuestionType(Model model, @RequestParam Map<String, String> dataMap) {
		Map<String, Object> result = super.getResult("/updateQuestionType", dataMap);

		return result;
	}

	/**
	 * yc 改变分类状态
	 * 
	 * @return
	 */
	@RequestMapping(value = "/updateQuestion")
	public String updateQuestion(Model model, @RequestParam Map<String, String> dataMap) {
		Map<String, Object> result = super.getResult("/updateQuestionType", dataMap);
		
		if ("0".equals(dataMap.get("parentId"))) {
			return "redirect:getBigQuestionTypeList?titleNo=2&systemIndex=" + dataMap.get("systemIndex");
		}
		
		return "redirect:getSmallQuestionTypeList?titleNo=2&parentId=" + dataMap.get("parentId");
	}

	/**
	 * yc 通过问题小分类 查询 相关人员
	 * 
	 * @return
	 */
	@RequestMapping(value = "/getQuestionTypeToUser")
	@ResponseBody
	public Map<String, Object> getQuestionTypeToUser(Model model, @RequestParam Map<String, String> dataMap) {
		Map<String, Object> result = super.getResult("/selectQuestionTypeToUser", dataMap);
		
		return result;
	}
	/**
	 * yc 修改问题小分类对应关系
	 * 
	 * @return
	 */
	@RequestMapping(value = "/updateQuestionTypeForUser")
	@ResponseBody
	public Map<String, Object> updateQuestionTypeForUser(Model model, @RequestParam Map<String, String> dataMap) {
		Map<String, Object> result = super.getResult("/updateQuestionTypeForUser", dataMap);
		
		return result;
	}
	/**
	 * yc 添加问题小分类对应关系
	 * 
	 * @return
	 */
	@RequestMapping(value = "/addQuestionTypeForUser")
	@ResponseBody
	public Map<String, Object> addQuestionTypeForUser(Model model, @RequestParam Map<String, String> dataMap) {
		Map<String, Object> result = super.getResult("/insertQuestionTypeForUser", dataMap);
		
		return result;
	}
}