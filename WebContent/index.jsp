<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*,java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>雲端真人翻譯服務</title>
<link rel="shortcut icon" href="img/icon.ico">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="default.css">
<link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<link href='http://fonts.googleapis.com/css?family=Open+Sans:300' rel='stylesheet' type='text/css'>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
</head>
<body>
	<!-- /.modal -->
	<div id="login-modal" class="modal fade" >
	 	<div class="modal-dialog">
	    	<div class="modal-content">
	      		<div class="modal-header">
	        		<button type="button" class="close" data-dismiss="modal">
	          			<span aria-hidden="true">&times;</span>
	          			<span class="sr-only">Close</span>
	        		</button>
	        		<h4 class="modal-title">登入</h4>
	      		</div>
	      		<div id="login-select" class="modal-body">
	        		
            		<button id="login-user" type="button" class="btn btn-success btn-lg btn-block">用戶登入</button>
            		<span class="help-block">當您註冊成為一般用戶後，請點選用戶登入</span>
            		<button id="login-translator" type="button" class="btn btn-primary btn-lg btn-block">翻譯員登入</button>
            		<span id="login" class="help-block">當您是翻譯員，請點選翻譯員登入</span>
	        		
	      		</div>
	      		<div id="login-input" class="modal-body" style="display:none">
	        		
            		<input type="text" class="form-control input-lg" id="m_account" placeholder="手機號碼" onkeypress="return enter(event);"> 
            		<input type="password" class="form-control input-lg" id="m_pwd" placeholder="密碼" onkeypress="return enter(event);">
            		<span id="login_fail" class="help-block" style="color:red;display:none;">帳號或密碼錯誤</span>
	        		
	      		</div>
	      		<div class="modal-footer">
	        		<a id="modal_reg" href="member.html">立即註冊翻譯會員</a>
	        		<button id="dismiss" type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	        		<button type="button" class="btn btn-primary" onClick="login();">登入</button>
	      		</div>
	    	</div>
	  	</div>
	</div>
	
	<nav id="navbar" class="navbar navbar-default" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<button class="navbar-toggle" data-toggle="collapse" data-target = ".navHeaderCollapse">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>

				<a class="navbar-brand" href="index.jsp"><img src="img/app_icon_32x32.png"> 雲端翻譯服務</a>
			</div>
			<div class="collapse navbar-collapse navHeaderCollapse">
				<ul class="nav navbar-nav navbar-right">
					<li class="active"><a href="index.jsp">首頁</a></li>
					<li><a href="account.jsp">帳務中心</a></li>
					<li><a href="service.jsp">客戶服務</a></li>
					<li>
						
							<%
								
								if( session.getAttribute("login")!=null ){ %>
								<button id="loginbtn" type="button" class="btn btn-primary navbar-btn" data-toggle="modal" data-target="#login-modal" style="display:none">登入</button>
								<button id="logoutbtn" type="button" class="btn btn-primary navbar-btn"  onClick="logout();">登出</button>
							<% }else{ %>
								<button id="loginbtn" type="button" class="btn btn-primary navbar-btn" data-toggle="modal" data-target="#login-modal">登入</button>
								<button id="logoutbtn" type="button" class="btn btn-primary navbar-btn" style="display:none" onClick="logout();">登出</button>
							<%}%>
							
						
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<div id ="header-wrapper">
		<header class="container">
			<div id="hello-wrapper">
				<div id="photo"><img src="img/web_icon.png" /></div>
				<div id="market" style="opacity:1;">
					<div id="googleplay"></div>
					<div id="appstore" style="opacity:0.1;"></div>
				</div>
			</div>
		</header>
	</div>
	
	<div id="introduce">
		<div id="introduce-nav">
			<div id="customer" class="nav_hover"><p>找翻譯</p></div>
			<div id="translator"><p>當翻譯</p></div>
		</div>
		<div id="customer_intro" class="container" >
			<div id="customer-box">
				<div id="customer-box-text" style="padding-top:120px;">
					<p class="subtitle">你需要即時的翻譯服務嗎，什麼是雲端翻譯服務？</p>
					<p>雲端真人翻譯服務是一種貼心電話服務，提供雇主與外籍看護、外勞、家人與外配、老師與外配家長等等的即時翻譯服務。</br>當你需要翻譯服務的時候，只需要一個按鈕就有專人為您即時翻譯，解決溝通問題，提升生活品質。</p>
				</div>
				<div id="customer-box-image"><img src="img/htc.png" /></div>
			</div>
			<div class="intro-box">
				<div class="box-text">
					<p class="subtitle">如何使用雲端翻譯服務？</p>
					<p>無論你是使用Android系列還是使用iPhone，下載我們的免費APP，連接上網後，您只需要按下一個按鍵，雲端系統就會自動幫您配對，讓您輕鬆享有一對一專業翻譯服務。</br>如果沒有智慧型手機或是沒有，你也可以撥打服務熱線，透過我們的專業技術，雲端服務平台就會幫您配對。</p>
				</div>
				<div class="box-image"><img src="img/how.png" /></div>
			</div>
			<div class="intro-box">
				<div class="box-text">
					<p class="subtitle">雲端服務的翻譯範圍有哪些？</p>
					<p>目前我們提供翻譯的語言主要有：</br>1. 國語或台語</br>2. 印尼話</br>3. 泰語</br>4. 越南語</p>
				</div>
				<div class="box-image"><img src="img/lang.png" /></div>
			</div>
			<div class="intro-box" style="border:none;">
				<div class="box-text">
					<p class="subtitle">翻譯服務要收費嗎？</p>
					<p>目前雲端翻譯服務平台並<span style="color:red;">不會收取任何額外費用</span>(但電信業者會向您收取一般的網外通話費用)，就如同撥打一般電話給親朋好友一樣的價格，低廉的價錢卻有高級的專業服務。</p>
				</div>
				<div class="box-image"><img src="img/price.png" style="height:100%;width:auto;"/></div>
			</div>
		</div>

		<div id="translator_intro" class="container" style="display:none">
			<div id="translator-box">
				<div id="translator-box-text" style="padding-top:120px;">
					<p class="subtitle">什麼是雲端翻譯員，如何成為翻譯員？</p>
					<p>雲端真人翻譯服務是一種貼心電話服務，提供雇主與外籍看護、外勞、家人與外配、老師與外配家長等等的即時翻譯服務。</br>當你需要翻譯服務的時候，只需要一個按鈕就有專人為您即時翻譯，解決溝通問題，提升生活品質。</p>
				</div>
				<div id="translator-box-image"><img src="img/iphone.png" /></div>
			</div>
			<div class="intro-box">
				<div class="box-text">
					<p class="subtitle">如何使用雲端翻譯服務？</p>
					<p>建構中</p>
				</div>
				<div class="box-image"><img src="img/how.png" /></div>
			</div>
			<div class="intro-box">
				<div class="box-text">
					<p class="subtitle">雲端服務的翻譯範圍有哪些？</p>
					<p>建構中</p>
				</div>
				<div class="box-image"><img src="img/lang.png" /></div>
			</div>
			<div class="intro-box" style="border:none;">
				<div class="box-text">
					<p class="subtitle">翻譯服務要收費嗎？</p>
					<p>建構中</p>
				</div>
				<div class="box-image"><img src="img/price.png" style="height:100%;width:auto;"/></div>
			</div>
		</div>
	</div>
	
	<div id="reg-wrapper">
		<div id="reg-box" class="container">
			<div id="reg">
				<p id='reg-title'>馬上開始！</p>
				<p id="reg-text">註冊成為雲端翻譯服務的會員，馬上體驗及時翻譯服務，讓您溝通零障礙。</p>
				<div id="reg-btn">
					<a href="member.html"><button type="button" class="btn btn-default btn-lg btn-block">立刻註冊</button></a>
				</div>
			</div>
		</div>
	</div>

	<div id = "copyright-wrapper">
		<div id="copyright" class="container">
			<div id="link-wrapper">
				<a href="aboutus.html" ><i class="fa fa-rocket"></i> 關於我們</a>
				<a href="http://nthu.kits.tw/service/home.html" ><i class="fa fa-phone"></i> 雲端電話服務</a>
				<a href="service.jsp" ><i class="fa fa-info"></i> 客服中心</a>
			</div>
			<div id="contact">
				<a href="#"><div id="fb" class="contact_icon"><img src="img/fb.png"></div></a>
				<a href="#"><div id="mail" class="contact_icon"><img src="img/gmail.png"></div></a>
			</div>
			<p id="copy_p">清華大學雲端翻譯服務 | 清華大學雲端網路電話服務 | Web designed by Mao | National Tsing Hua University.</p>
		</div>
	</div>
	
<script type="text/javascript" src="script.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>

</body>