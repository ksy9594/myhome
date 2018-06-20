<%@page import="project.ImageBean"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import = "java.util.Vector"%>
<jsp:useBean id="mgr" class = "project.Imgloadmgr" />
<jsp:useBean id="bean" class = "project.ImageBean"/>
<% 
	request.setCharacterEncoding("EUC-KR");

	String outcoat = request.getParameter("outcoat");
	String top = request.getParameter("top");
	String bottom = request.getParameter("bottom");
	
	int vecsize = 0;
	Vector<ImageBean> vlist = null;
	
	if("0".equals(outcoat))
	{
		vlist = mgr.selectImg011(top, bottom);
	}
	else
	{
		vlist = mgr.selectImg(outcoat,top, bottom);
	}
	
%>
<!DOCTYPE html>

<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width">

    <!-- Main Style Sheet -->
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="css/jdb_popup.min.css">
	<link rel="stylesheet" href="css/style.min.css">
    <!-- Modernizr -->
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <script src="js/vendor/modernizr-2.6.2.min.js"></script>
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script type="js/vendor/jquery-1.9.0.min.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <!-- Respond.js for IE 8 or less only -->
    <!--[if (lt IE 9) & (!IEMobile)]>
        <script src="js/vendor/respond.min.js"></script>
    <![endif]-->
</head>

<body class="products">

<%
	for(int i=0; i < vlist.size(); i++)
	{
		bean = vlist.get(i);

%>
	<div class="product-item col-sm-4">
		<div>
		<p><%=outcoat %></p>
		<a href="imgfile/<%=bean.getName()%>" class="jdbpopup">
		<img src="imgfile/<%=bean.getName()%>" alt="Ceci est une image !" width="auto" height="auto"></a>

		</div>	
	<script src="js/jquery.min.js"></script>
	<script src="js/jdb_popup.min.js"></script>	 	
	</div>
	<%
	}
	%>
<body>