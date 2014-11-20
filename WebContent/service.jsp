<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*,java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>客戶服務</title>
	<link rel="shortcut icon" href="img/icon.ico">
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/service.css">
	<link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
	<link href='http://fonts.googleapis.com/css?family=Open+Sans:300' rel='stylesheet' type='text/css'>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
</head>
<body>
	<!-- /.modal -->
	<div id="login-modal" class="modal fade">
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
	        		<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
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
					<li><a href="index.jsp">首頁</a></li>
					<li><a href="account.jsp">帳務中心</a></li>
					<li class="active"><a href="service.jsp">客戶服務</a></li>
					<li>
						<div class="col-sm-10">
							<%
								
								if( session.getAttribute("login")!=null ){ %>
								<button id="loginbtn" type="button" class="btn btn-primary navbar-btn" data-toggle="modal" data-target="#login-modal" style="display:none">登入</button>
								<button id="logoutbtn" type="button" class="btn btn-primary navbar-btn"  onClick="logout();">登出</button>
							<% }else{ %>
								<button id="loginbtn" type="button" class="btn btn-primary navbar-btn" data-toggle="modal" data-target="#login-modal">登入</button>
								<button id="logoutbtn" type="button" class="btn btn-primary navbar-btn" style="display:none" onClick="logout();">登出</button>
							<%}%>
							
						</div>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<div id = "header-wrapper">
		<div id = "header" class="container">
			<p>客戶服務</p>
		</div>
	</div>

	<div id="content-wrapper">
		<div id="content" class="container">
			<p class="title"><i class="fa fa-question-circle"></i> 常見Q&A</p>
			<div class="panel-group" id="accordion">

			  	<div class="panel panel-default">
			    	<div class="panel-heading">
			      		<h4 class="panel-title">
			        		<a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
			          			問題敘述1
			        		</a>
			      		</h4>
			    	</div>
			    	<div id="collapseOne" class="panel-collapse collapse in">
			      		<div class="panel-body">
			        		答案1
			      		</div>
			    	</div>
			  	</div>

			  	<div class="panel panel-default">
			    	<div class="panel-heading">
			      		<h4 class="panel-title">
			        		<a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
			          			問題敘述2
			        		</a>
			      		</h4>
			    	</div>
			    	<div id="collapseTwo" class="panel-collapse collapse">
			      		<div class="panel-body">
			        		答案2
			      		</div>
			    	</div>
			  	</div>

			  	<div class="panel panel-default">
			    	<div class="panel-heading">
			      		<h4 class="panel-title">
			        		<a data-toggle="collapse" data-parent="#accordion" href="#collapseThree">
			          			問題敘述3
			        		</a>
			      		</h4>
			    	</div>
			    	<div id="collapseThree" class="panel-collapse collapse">
			      		<div class="panel-body">
			        		答案3
			      		</div>
			    	</div>
			  	</div>
			  
			</div>

			<p class="title"><i class="fa fa-phone-square"></i> 與我們聯絡</p>
			<p class="content_p">客服專線：0800-XX-XXX</p>
			<a href="#"><div id="mail" class="contact_icon"><img src="img/gmail.png"></div></a>
		</div>
	</div>

	<div id="content-img" class="container">
		<p>雲端翻譯服務，您的專屬翻譯員。</p>
		<img src="img/phone.png"/>
		<img src="img/phone2.png"/>
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
			<p id="copy_p">清華大學雲端翻譯服務 | 清華大學雲端網路電話服務 | Web designed by Mao Chen-Ning. | National Tsing Hua University.</p>
		</div>
	</div>

<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/service.js"></script>

</body>