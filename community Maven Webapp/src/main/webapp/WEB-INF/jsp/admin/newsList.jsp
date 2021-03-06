<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title></title>
    <link href="${pageContext.request.contextPath}/static/css/style.css" rel="stylesheet" type="text/css" />
	<link href="${pageContext.request.contextPath}/static/css/page.css" rel="stylesheet" />
	<script  src="${pageContext.request.contextPath}/static/js/jquery-3.3.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/paging.js"></script>
	<style type="text/css">
	.page_div .current {
				background-color:rgb(23,180,255);
				border-color: rgb(23,180,255);
				color: #FFFFFF;
			}
	</style>
</head>


<body>

	<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li>公告管理</li>
    <li>公告列表</li>
    </ul>
    </div>
    
    <div class="rightinfo">
    
    <div class="tools">
    	<ul class="seachform">
    			<form action="/community/admin/searchNews" method="post">
				<li><label>作者：</label> <input name="writer" type="text" value="${writer}" class="scinput" /></li>
				<li><label>&nbsp;</label><input  type="submit"
					class="scbtn" value="查询" />
				</li>
			</ul>
			</form>
    </div>
    
    <input type="hidden" id="msg" value="${msg }"> 
    <table class="tablelist">
    	<thead>
    	<tr>
        <th><input name="" type="checkbox" value="" checked="checked"/></th>
        <th>标题</th>
        <th>作者</th>
        <th>类别</th>
        <th>发布时间</th>
        <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${result.dataList }" var="news">
        <tr>
        <td><input name="" type="checkbox" value="${news.newsId }" /></td>
        <td>${news.title }</td>
        <td>${news.writer }</td>
        <td>
        <c:if test="${news.type  eq 'news'}">新闻</c:if>
	    <c:if test="${news.type eq 'notice'}">公告</c:if>
        </td>
        <td><fmt:formatDate value="${news.creatTime}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
        <td style="text-align: center;"><a href="/community/admin/deleteNews?newsId=${news.newsId }" class="tablelink"> 删除</a></td>
        </tr> 
        </c:forEach>
        </tbody>
    </table>
    
   	<br />
    <form  method="post" id="newsForm"></form>
	<div id="page" class="page_div" style="float:right;"></div>
    
    
    <div class="tip">
    	<div class="tiptop"><span>提示信息</span><a></a></div>
        
      <div class="tipinfo">
        <span><img src="${pageContext.request.contextPath}/static/images/ticon.png" /></span>
        <div class="tipright">
        <p>是否确认对信息的修改 ？</p>
        <cite>如果是请点击确定按钮 ，否则请点取消。</cite>
        </div>
        </div>
        
        <div class="tipbtn">
        <input name="" type="button"  class="sure" value="确定" />&nbsp;
        <input name="" type="button"  class="cancel" value="取消" />
        </div>
    
    </div>
    
    
    
    
    </div>
    <script type="text/javascript">			
			$("#page").paging({
			pageNo:${result.currentPage},
			totalPage: ${result.totalPage},
			totalSize: ${result.totalRecord},
			callback: getNews
			})
			
			function getNews(num) {	
				$("#newsForm").attr("action", "/community/admin/newsList?pageNo="+num+"&writer=${writer}");
				$("#newsForm").submit();
				 return false;				 
				}
			$(function() {
				var msg=document.getElementById("msg").value;
					if(msg!=null&&msg!=""){
						alert(msg);
						document.getElementById("msg").value ="";
					}
				})
			</script>
  </body>
</html>
