package com.bhe.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * json 工具类，采用的是jackson jar
 * @author 陈建伟
 * @datetime 2015年7月24日下午2:31:15
 */
public class JacksonUtil {

	private static Log log = LogFactory.getLog(JacksonUtil.class);
	
	/**
	 * 把map对象转换成json字符串
	 * @param mapData <String,Object>要转换的对象
	 * @return json字符串
	 * @author 陈建伟
	 * <ul>
	 *  <li>陈建伟 2015年7月24日下午2:32:12 新建该方法</li>
	 * </ul>
	 */
	public static String map2Json(Map<String, Object> mapData){
		String result = null;
		ObjectMapper mapper = new ObjectMapper();
		try {
			result = mapper.writeValueAsString(mapData);
		} catch (JsonProcessingException e) {
			log.error(e,e);
		}
		return result;
	}
	
	/**
	 * 把json对象转换成map
	 * @param jsonStr
	 * @return
	 * @author 陈建伟
	 * <ul>
	 *  <li>陈建伟 2015年7月24日下午2:40:29 新建该方法</li>
	 * </ul>
	 */
	@SuppressWarnings("unchecked")
	public static Map<String, Object> json2Map(String jsonStr){
		Map<String, Object> result = null;

		ObjectMapper mapper = new ObjectMapper();
		try {
			result = mapper.readValue(jsonStr, Map.class);
		} catch (JsonParseException e) {
			log.error(e,e);
		} catch (JsonMappingException e) {
			log.error(e,e);
		} catch (IOException e) {
			log.error(e,e);
		}
		
		return result;
	}
	
	/**
	 * list 转json
	 * @param temp
	 * @return
	 * @author 陈建伟
	 * <ul>
	 *  <li>陈建伟 2015年7月25日上午10:07:32 新建该方法</li>
	 * </ul>
	 */
	public static String listMap2json(List<Map<String, Object>> temp){
		String result = null;
		
		ObjectMapper mapper = new ObjectMapper();
		
		try {
			result = mapper.writeValueAsString(temp);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * json 转换成List<Map<String, Object>> 
	 * @param jsonStr
	 * @return
	 * @author 陈建伟
	 * <ul>
	 *  <li>陈建伟 2015年7月25日上午10:15:03 新建该方法</li>
	 * </ul>
	 */
	public static List<Map<String, Object>> json2listMap(String jsonStr){
		List<Map<String, Object>> result = null;

		ObjectMapper mapper = new ObjectMapper();
		try {
			result = mapper.readValue(jsonStr, List.class);
		} catch (JsonParseException e) {
			log.error(e,e);
		} catch (JsonMappingException e) {
			log.error(e,e);
		} catch (IOException e) {
			log.error(e,e);
		}
		
		return result;
	}
	
	
	/**
	 * Map<String, List<Map<String, Object>>> 转换成json
	 * @param data
	 * @return
	 * @author 陈建伟
	 * <ul>
	 *  <li>陈建伟 2015年7月25日上午10:23:34 新建该方法</li>
	 * </ul>
	 */
	public static String MapListMap2Json(Map<String, List<Map<String, Object>>> data){
		String result = null;
		ObjectMapper mapper = new ObjectMapper();
		try {
			result = mapper.writeValueAsString(data);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * json 转换成 Map<String, List<Map<String, Object>>>
	 * @param jsonStr 
	 * @return
	 * @author 陈建伟
	 * <ul>
	 *  <li>陈建伟 2015年7月25日上午10:25:54 新建该方法</li>
	 * </ul>
	 */
	public static Map<String, List<Map<String, Object>>> json2MapListMap(String jsonStr){
		Map<String, List<Map<String, Object>>> result = null;

		ObjectMapper mapper = new ObjectMapper();
		try {
			result = mapper.readValue(jsonStr, Map.class);
		} catch (JsonParseException e) {
			log.error(e,e);
		} catch (JsonMappingException e) {
			log.error(e,e);
		} catch (IOException e) {
			log.error(e,e);
		}
		
		return result;
	}
	public static void main(String[] args) {
		String str = "{\"key1\" : \"abc\", \"ke2\" : [{\"value\" : \"adf\",\"val2\" : \"adf\"}]}";
		@SuppressWarnings("unused")
		Map<String, Object> json2Map = json2Map(str);
		System.out.println("1");
	}
}
