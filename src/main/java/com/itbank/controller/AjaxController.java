package com.itbank.controller;

import java.io.IOException;

import org.json.XML;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.itbank.service.FoodService;

@RestController
public class AjaxController {

	@Autowired private FoodService fs;
	
	@GetMapping(value="/foodList/{num}", produces="application/json; charset=utf-8")
	public String foodList(@PathVariable int num) throws IOException {
		
		String xml = fs.getData(num);
		if(xml != null) {
			
			String json = XML.toJSONObject(xml).toString();
			return json;
		}
		return "{\"message\" : \"no data\"}";
	}
	
	@GetMapping(value="/foodList", produces="application/json; charset=utf-8")
	public String foodList() throws IOException {
		
		String xml = fs.getData();
		if(xml != null) {
			
			String json = XML.toJSONObject(xml).toString();
			return json;
		}
		return "{\"message\" : \"no data\"}";
	}
}
