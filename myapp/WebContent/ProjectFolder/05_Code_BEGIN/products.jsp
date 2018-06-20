<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="project.ImageBean"%>
<%@ page import = "java.util.Vector"%>
<jsp:useBean id="mgr" class = "project.Imgloadmgr" />
<jsp:useBean id="bean" class = "project.ImageBean"/>
<% 
	request.setCharacterEncoding("UTF-8");
	
%>
<% 	
	String outcoat = request.getParameter("outcoat");
	String top = request.getParameter("top");
	String bottom = request.getParameter("bottom");
	String imgname = null;
	
	int vecsize = 0;
	Vector<ImageBean> vlist = null;	
	
	if("0".equals(outcoat))
	{
		vlist = mgr.selectImg011(top, bottom);		
	}
	else if("0".equals(top))
	{
		vlist = mgr.selectImg101(outcoat, bottom);
	}
	else if("0".equals(bottom))
	{
		vlist = mgr.selectImg110(outcoat, top);
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
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Exile On Main Street</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width">

    <!-- Main Style Sheet -->
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="css/jdb_popup.min.css">
    <!-- Modernizr -->
    <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet"><!-- 메뉴 탭 -->
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <script src="js/vendor/modernizr-2.6.2.min.js"></script>
    <script type="js/vendor/jquery-1.9.0.min.js"></script>
    
    <!-- Respond.js for IE 8 or less only -->
    <!--[if (lt IE 9) & (!IEMobile)]>
        <script src="js/vendor/respond.min.js"></script>
    <![endif]-->
       	   
</head>
<body class="products">

<!--[if lte IE 7]>
    <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
<![endif]-->

<header role="banner">
  <div class="container">
  </div><!-- /.container -->
    <nav role="navigation" class="navbar navbar-default">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>          
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Home<b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="/myapp/ProjectFolder/web/main.html">Home</a></li>
                </ul>              
            </li>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Blog<b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="https://www.pinterest.co.kr/" target = "_blank">Pinterest</a></li>
                  <li><a href="https://www.instagram.com/lookbook/" target = "_blank">LookBook Instagram</a></li>
                  <li><a href="http://www.thesartorialist.com/" target = "_blank">thesartorialist</a></li>
                  <li><a href="http://streetfsn.blogspot.kr/" target = "_blank">StreetFSN</a></li>
                  <li><a href="http://streetfashionincracow.blogspot.kr/" target = "_blank">Street Fashion In Krakow</a></li>
                  <li><a href="http://www.streetgeist.com/" target = "_blank">StreetGeist</a></li>
                  <li><a href="http://damstyle.blogspot.kr/" target = "_blank">Dam Style</a></li>
                  <!-- <li class="divider"></li>
                  <li><a href="#">Separated link</a></li>
                  <li class="divider"></li>
                  <li><a href="#">One more separated link</a></li> -->
                </ul>
            </li>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Store<b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="http://whoshot.net/" target = "_blank">Who's Hot</a></li>
                  <li><a href="http://store.musinsa.com/" target = "_blank">무신사 스토어</a></li>
                  <li><a href="http://www.hiphopplayastore.com/" target = "_blank">힙플 스토어</a></li>
                  <li><a href="http://www.kmohr.com/" target = "_blank">kmohr</a></li>
                  <li><a href="http://crewbi.com/" target = "_blank">crewbi</a></li>
                  <li><a href="http://lakickz.com/" target = "_blank">lakickz</a></li>
                </ul>
            </li>
             <li class="dropdown"> <!-- help -->
                <a class="dropdown-toggle" data-toggle="dropdown" id="left">
                Help<b class="caret" id="left"></b></a>
                
			    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
			    <script src="js/jAlerts.js"></script>
            </li>
           </ul>
        </div><!--/.nav-collapse -->
      </div><!--/.container -->
    </nav>
</header>
<main role="main">
  <div class="container">
    <div class="row">
      <div class="grid-options col-sm-3">     
		<form method = "post" action = "products.jsp?" name="chooseFrm">
		<ul id="nav-tabs-wrapper" class="nav nav-tabs nav-pills nav-stacked well">
              <li>
              <a href="#vtab1" data-toggle="tab" id = "headerouter">Outer</a>
              <label id="outer"><input type = "radio" name = "outcoat" value = "0" checked>없음<br>
              <input type = "radio" name = "outcoat" value = "01">자켓
              <input type = "radio" name = "outcoat" value = "02">코트
	          <input type = "radio" name = "outcoat" value = "04">가디건
	          <input type = "radio" name = "outcoat" value = "05">야상<br>
	          <input type = "radio" name = "outcoat" value = "07">점퍼
	          <input type = "radio" name = "outcoat" value = "08">블레이저</label>
	          
              <li>
              <a href="#vtab2" data-toggle="tab" id="headtop">상의</a>
              <label id="top" style="display:none;">
              <input type = "radio" name = "top" value = "0" checked>없음<br>
	          <input type = "radio" name = "top" value = "01">맨투맨
	          <input type = "radio" name = "top" value = "02">브이넥
	          <input type = "radio" name = "top" value = "03">반팔티쳐츠<br>
	          <input type = "radio" name = "top" value = "04">와이셔츠/남방<br>
	          <input type = "radio" name = "top" value = "05">후드
	          <input type = "radio" name = "top" value = "06">긴팔티
	          <input type = "radio" name = "top" value = "07">카라티<br>
	          <input type = "radio" name = "top" value = "08">폴라티
	          <input type = "radio" name = "top" value = "09">니트</label>
              </li>
              
              <li>
              <a href="#vtab3" data-toggle="tab" id="headbottom">하의</a>
              <li><label id="bottom" style="display:none;">
              <input type = "radio" name = "bottom" value = "0" checked>없음<br>
		          <input type = "radio" name = "bottom" value = "01">면-반바지<br>
		          <input type = "radio" name = "bottom" value = "02">청-반바지<br>
		          <input type = "radio" name = "bottom" value = "03">청바지<br>
		          <input type = "radio" name = "bottom" value = "04">면바지
		          <input type = "radio" name = "bottom" value = "05">슬랙스</label>
              </li>
         </ul>
		<button type = "submit" id="btnstyle" onClick="check()">
		<a class = "btn btn-feature choose-clearance">
		<span class = "icon fa fa-tag fa-3x"></span>
		<h2>옵션 선택하기</h2></a>
		</button>
        </form>
                  
      </div><!-- /.products-grid-options -->
      <div class="products-grid col-sm-9">
        <div class="row">     
      	<%
      		if(!vlist.isEmpty())
      		{
 
			for(int i=0; i < vlist.size(); i++)
			{
				
				bean = vlist.get(i);
		
		%>
			<div class="product-item col-sm-4">
				<div>
				<a href="imgfile/<%=bean.getName()%>" class="jdbpopup">
				<img src="imgfile/<%=bean.getName()%>" alt="Ceci est une image !" width="auto" height="auto">
				</a>
				<%imgname = bean.getName(); %>
				</div>															
			<script src="js/jquery.min.js"></script>
			<script src="js/jdb_popup.min.js"></script>	 	
			</div>			  		
		<%
			}			
		%>						
		<%
      		}
      		else
      		{
      			out.println("검색된 자료가 없습니다.");
      		}
		%>		
		</div>		
	  </div>
    </div>
        <!-- /.row -->           
          </div><!-- /.products-grid -->
        </div><!-- /.row -->
      </div><!-- /.container -->
    </main>
    <script type="text/javascript">
    function check()
    {
    	if(document.chooseFrm.outcoat.value=="0")
		{
    		if(document.chooseFrm.top.value=="0")
    		{
    			if(document.chooseFrm.bottom.value=="0")
    			{
    				alert("옵션을 선택해주세요.");
    			}   			
    		}
		}
    	else if(document.chooseFrm.outcoat.value=="0")
    	{
    		if(document.chooseFrm.top.value=="0")
    		{
    			alert("옵션을 2가지 이상 선택해주세요.");    			
    		}
    	}
    	else if(document.chooseFrm.outcoat.value=="0")
    	{
    		if(document.chooseFrm.bottom.value=="0")
    		{
    			alert("옵션을 2가지 이상 선택해주세요.");
    		}
    	}
    	else if(document.chooseFrm.top.value=="0")
    	{
    		if(document.chooseFrm.bottom.value=="0")
    		{
    			alert("옵션을 2가지 이상 선택해주세요.");
    		}
    	}   	
    } 
    </script>
    
    <footer role="contentinfo">
      <div class="container">
        <div class="row">

            <div class="col-sm-4 col-md-2">
              <h3>Page</h3>
              <ul>
                <li><a href="/myapp/ProjectFolder/web/main.html">Home</a></li>
                <li><a href="/myapp/ProjectFolder/web/board.jsp">유저게시판</a></li>
                <li><a href="/myapp/ProjectFolder/web/freeboard.jsp">건의게시판</a></li>
                <li><a href="#">Codi Search</a></li>
              </ul>
            </div>
          <!-- Add the extra clearfix for only the required viewport -->
         <div class="clearfix visible-sm"></div>

          <div class="about col-sm-12 col-md-6">
            <h3>About Us</h3>
            <p> 
            원하는 아이템에 버튼을 선택하고 검색을 누르시면 해당하는 사진이 페이지에 출력됩니다.<br> 
            사진을 보시고 자신이 원하는 코디를 마음껏 찾으시고 패셔니스트가 되기를 바랍니다.<br>
            사이트 제작자 : K.S.Y</p>
            
          </div>
        </div><!-- /.row -->

       <ul class="social">
          <li><a href="#" title="Twitter Profile"><span class="icon fa fa-twitter"></span></a></li>
          <li><a href="#" title="Facebook Page"><span class="icon fa fa-facebook"></span></a></li>
          <li><a href="#" title="LinkedIn Profile"><span class="icon fa fa-linkedin"></span></a></li>
          <li><a href="#" title="Google+ Profile"><span class="icon fa fa-google-plus"></span></a></li>
          <li><a href="#" title="GitHub Profile"><span class="icon fa fa-github-alt"></span></a></li>
        </ul>
		
        <p class="footer-brand"><a href="index.html"><img src="img/logo.png" width="80" alt="Bootstrappin'"></a></p>

      </div><!-- /.container -->
    </footer>

    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.10.2.min.js"><\/script>')</script>

    <!-- Holder.js for project development only -->
    <script src="js/vendor/holder.js"></script>

    <!-- Essential Plugins and Main JavaScript File -->
    <script src="js/plugins.js"></script>
    <script src="js/main.js"></script>

    <!-- Google Analytics: change UA-XXXXX-X to be your site's ID. -->
    <script>
        var _gaq=[['_setAccount','UA-XXXXX-X'],['_trackPageview']];
        (function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
        g.src=('https:'==location.protocol?'//ssl':'//www')+'.google-analytics.com/ga.js';
        s.parentNode.insertBefore(g,s)}(document,'script'));
        
        $(document).ready(function()
        		{
        			$("#headerouter").click(function()
        			{
        				$("#outer:not(:animated)").toggle("slow");
        				$("#outer").css("display","block");
        			});
        			<!-- -->
                	$("#headtop").click(function()
                	{
                		$("#top:not(:animated)").toggle("slow");
                		$("#top").css("display","block");
                	});
                	<!-- -->
                    $("#headbottom").click(function()
                     {
                        $("#bottom:not(:animated)").toggle("slow");
                        $("#bottom").css("display","block");
                     });
                    // Assign functions to the 4 buttons
        		    $("#left").bind("click", left);
        		    
        		    function left() 
        			{       			        
        			    jAlert({
        					headingText: 'Help',
        			            contentText: 
        			            	'2개이상의 속성을 선택한 다음 선택 버튼을 누르시면 해당하는 조건의 사진이 페이지에 출력됩니다.'
        			        },"left"); // <---- Notice how this is changed to "left"
        			    
        			} // end left() function
        		});
    </script>
  </body>
</html>