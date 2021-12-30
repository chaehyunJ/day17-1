<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath">${ pageContext.request.contextPath }</c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>맛집리스트</title>
<style>
	.items{
		border : 1px solid black;
		width : 1000px;
		display: flex;
		flex-flow: wrap;
	}
	.item{
		border : 1px solid black;
		margin : 10px;
	}
	.hidden{
		display : none;
	}
</style>
</head>
<body>
<h1>맛집리스트</h1>

<form>
	<input type="number" name="num" min="1" max="10">
	<input type="submit" value="입력"> 
</form>
<div class="root hidden"></div>


<script>
	const cpath = '${ cpath }'
	const form = document.forms[0]
	const root = document.querySelector('.root')
	const num = document.querySelector('input[name="num"]')
	console.log(form)
	console.log(root)
	
	
// 	console.log(num.value)
	function getsubmit(event){
		event.preventDefault()
	 	console.log(num.value)
		
	 	root.innerHTML = ''
	 	
	 	const url = cpath + '/foodList/' + num.value
		const opt = {
				method : 'get'
		}
		fetch(url, opt)
		.then(resp => resp.json())
		.then(json => {
			console.log(json)
			
			const arr = json.response.body.items.item.map(v =>{
				return {
					MAIN_TITLE : v.MAIN_TITLE,
					CNTCT_TEL : v.CNTCT_TEL,
					GUGUN_NM : v.GUGUN_NM,
					MAIN_IMG_THUMB : v.MAIN_IMG_THUMB,
					USAGE_DAY_WEEK_AND_TIME : v.USAGE_DAY_WEEK_AND_TIME
				}
			})
			
			root.innerHTML += getDom(arr)
		})
	 	
	}
	
	
	function getFoodListJava(event){
	
		const url = cpath + '/foodList' 
		const opt = {
				method : 'get'
		}
		fetch(url, opt)
		.then(resp => resp.json())
		.then(json => {
			console.log(json)
			
			const arr = json.response.body.items.item.map(v =>{
				return {
					MAIN_TITLE : v.MAIN_TITLE,
					CNTCT_TEL : v.CNTCT_TEL,
					GUGUN_NM : v.GUGUN_NM,
					MAIN_IMG_THUMB : v.MAIN_IMG_THUMB,
					USAGE_DAY_WEEK_AND_TIME : v.USAGE_DAY_WEEK_AND_TIME
				}
			})
			
			root.innerHTML += getDom(arr)
		})
	}
	
	function getDom(arr){
		let dom = '<div class="items">'
		
		arr.forEach(dto => {
			dom += '<div class="item">'
			dom += '<div>' + dto.MAIN_TITLE + '</div>'
			dom += '<div>' + dto.CNTCT_TEL + '</div>'
			dom += '<div>' + dto.GUGUN_NM + '</div>'
			dom += '<div>' + dto.USAGE_DAY_WEEK_AND_TIME + '</div>'
			dom += '<img src="'+ dto.MAIN_IMG_THUMB +'">'
			dom += '</div>'
		})
		dom += '</div>'
		
		return dom
	}
	
	form.onsubmit = getsubmit
	window.onload = getFoodListJava
</script>
</body>
</html>