<%@ page pageEncoding="UTF-8" %><%@ page import="org.opencms.workplace.tools.modules.*" %><%	
	
	CmsModulesUploadFromServer wp = new CmsModulesUploadFromServer(pageContext, request, response);
	wp.displayDialog();
%>