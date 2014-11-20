<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*,java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>帳務中心</title>
	<link rel="shortcut icon" href="img/icon.ico">
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/account.css">
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
					<li><a href="index.jsp">首頁</a></li>
					<li class="active"><a href="account.jsp">帳務中心</a></li>
					<li><a href="service.jsp">客戶服務</a></li>
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
			<p>帳務中心</p>
		</div>
	</div>

	<div id="content-wrapper">
		
		<div id="content" class="container">

			<div id="pocket-bar">
				<% 
					if( session.getAttribute("login")!=null ){ %>
						<p><%= session.getAttribute("user")%>(<%= session.getAttribute("login")%>)，您好！</p>
					<% }else{ %>
						<p>你還沒登入喔！請先登入以查看您的帳務訊息。</p>
						<button id="loginbtn" type="button" class="btn btn-primary navbar-btn" data-toggle="modal" data-target="#login-modal">登入</button>
					<% } %>
			</div>

			<div id="account-setting" <%if( session.getAttribute("login")==null ){out.print("style='display:none;'");}%>>
				<div id="content-menu">
					<div class="menu_btn menu_btn-focus" id="change-setting"><p>修改基本資料</p></div>
					<div class="menu_btn" id="change-pwd"><p>更換密碼</p></div>
					<% if( session.getAttribute("login")!=null )if( session.getAttribute("type").equals("translator") ){ %>
						<div class="menu_btn" id="change-schedule" onClick="getSchedule();"><p>翻譯員排班</p></div>
					<% } %>
				</div>
				<div id="content-data">
					
					<div class="menu_data" id="data-setting" >
						
						<div id="personal">
							<p class="content-title">修改您的基本資料</p>
							<div id="menu_photo">
								<img src="img/app_icon.png">
							</div>
							<div id="mail-wrapper" class="form-group">
						    	<div class="col-xs-7">
						      		<input type="text" class="form-control input" id="mail" placeholder=<%if( session.getAttribute("login")!=null ){out.print(""+session.getAttribute("mail"));}%>>
						      		<span class="help-block">更改您的電子郵件信箱</span>
						      		<input type="text" class="form-control input" id="mail2" name="mail" placeholder="確認你的信箱">
						      		<span class="help-block">請確認您的電子郵件信箱，我們將發送驗證信到此信箱</span>
						    	</div>
						  	</div>
						  	<div id="name-wrapper" class="form-group">
						    	<div class="col-xs-7">
						      		<input type="text" class="form-control input" name="name" id="name" placeholder=<%if( session.getAttribute("login")!=null ){out.print(""+session.getAttribute("user"));}%>>
						      		<span class="help-block">更改真實姓名</span>
						    	</div>
						  	</div>
						  	<div class="col-xs-7">
						  		<button class="btn btn-default">送出</button>
						  	</div>
						</div>
					</div>
					<div class="menu_data" id="data-pwd" style="display:none;">
						<div id="input-pwd">
							<p class="content-title"> 更換使用者密碼</p>
				      		<input type="password" class="form-control input" id="pwd" placeholder="舊密碼">
				      		<span class="help-block">請輸入原先密碼</span>
				      		<input type="password" class="form-control input" id="pwd" placeholder="新使用者密碼">
				      		<span class="help-block">請輸入至少6位，數字或英文子母組成的密碼</span>
				      		<input type="password" class="form-control input" id="pwd2" name="pwd" placeholder="確認新密碼">
				      		<span class="help-block">請確認您的密碼</span>
				      		<button class="btn btn-default">送出</button>
						</div>
					</div>
					<div class="menu_data" id="data-schedule" style="display:none;">
						<p>翻譯員您好，這是您可以提供翻譯服務的時間表格，你可以任意調整時間。※ <i class="fa fa-phone"></i>已註冊的服務時間</p>
						<div id="tg-update-btn"><button id="schedule-btn" class="btn btn-primary btn-lg btn-block" disabled="disabled" onClick="scheduleHandler();">更新時間表</button></div>
						<div id="loading-page">
							<div id="loading-bar"></div>
							<p>資料傳輸中...</p>
						</div>
						<table id="schedule-table" class="tg">
						  <tr>
						    <th class="tg-s0xy"><i class="fa fa-phone"></i> <%= session.getAttribute("lang")%>->中文</th>
						    <th class="tg-j3wa">星期一</th>
						    <th class="tg-j3wa">星期二</th>
						    <th class="tg-j3wa">星期三</th>
						    <th class="tg-j3wa">星期四</th>
						    <th class="tg-j3wa">星期五</th>
						    <th class="tg-j3wa">星期六</th>
						    <th class="tg-j3wa">星期日</th>
						  </tr>
						  <tr>
						    <td class="tg-hy62">08:00~10:00</td>
						    <td class="tg-s6z2"><div id="m8" class="tg-btn" onClick="ScheduleOnChange('m8');"></div></td>
						    <td class="tg-s6z2"><div id="t8" class="tg-btn" onClick="ScheduleOnChange('t8');"></div></td>
						    <td class="tg-s6z2"><div id="w8" class="tg-btn" onClick="ScheduleOnChange('w8');"></div></td>
						    <td class="tg-s6z2"><div id="th8" class="tg-btn" onClick="ScheduleOnChange('th8');"></div></td>
						    <td class="tg-s6z2"><div id="f8" class="tg-btn" onClick="ScheduleOnChange('f8');"></div></td>
						    <td class="tg-s6z2"><div id="st8" class="tg-btn" onClick="ScheduleOnChange('st8');"></div></td>
						    <td class="tg-s6z2"><div id="s8" class="tg-btn" onClick="ScheduleOnChange('s8');"></div></td>
						  </tr>
						  <tr>
						    <td class="tg-hy62">10:00~12:00</td>
						    <td class="tg-s6z2"><div id="m10" class="tg-btn" onClick="ScheduleOnChange('m10');"></div></td>
						    <td class="tg-s6z2"><div id="t10" class="tg-btn" onClick="ScheduleOnChange('t10');"></div></td>
						    <td class="tg-s6z2"><div id="w10" class="tg-btn" onClick="ScheduleOnChange('w10');"></div></td>
						    <td class="tg-s6z2"><div id="th10" class="tg-btn" onClick="ScheduleOnChange('th10');"></div></td>
						    <td class="tg-s6z2"><div id="f10" class="tg-btn" onClick="ScheduleOnChange('f10');"></div></td>
						    <td class="tg-s6z2"><div id="st10" class="tg-btn" onClick="ScheduleOnChange('st10');"></div></td>
						    <td class="tg-s6z2"><div id="s10" class="tg-btn" onClick="ScheduleOnChange('s10');"></div></td>
						  </tr>
						  <tr>
						    <td class="tg-hy62">12:00~14:00</td>
						    <td class="tg-s6z2"><div  id="m12" class="tg-btn" onClick="ScheduleOnChange('m12');"></div></td>
						    <td class="tg-s6z2"><div  id="t12" class="tg-btn" onClick="ScheduleOnChange('t12');"></div></td>
						    <td class="tg-s6z2"><div  id="w12" class="tg-btn" onClick="ScheduleOnChange('w12');"></div></td>
						    <td class="tg-s6z2"><div id="th12" class="tg-btn" onClick="ScheduleOnChange('th12');"></div></td>
						    <td class="tg-s6z2"><div  id="f12" class="tg-btn" onClick="ScheduleOnChange('f12');"></div></td>
						    <td class="tg-s6z2"><div id="st12" class="tg-btn" onClick="ScheduleOnChange('st12');"></div></td>
						    <td class="tg-s6z2"><div  id="s12" class="tg-btn" onClick="ScheduleOnChange('s12');"></div></td>
						  </tr>
						  <tr>
						    <td class="tg-hy62">14:00~16:00</td>
						    <td class="tg-s6z2"><div  id="m14" class="tg-btn" onClick="ScheduleOnChange('m14');"></div></td>
						    <td class="tg-s6z2"><div  id="t14" class="tg-btn" onClick="ScheduleOnChange('t14');"></div></td>
						    <td class="tg-s6z2"><div  id="w14" class="tg-btn" onClick="ScheduleOnChange('w14');"></div></td>
						    <td class="tg-s6z2"><div id="th14" class="tg-btn" onClick="ScheduleOnChange('th14');"></div></td>
						    <td class="tg-s6z2"><div  id="f14" class="tg-btn" onClick="ScheduleOnChange('f14');"></div></td>
						    <td class="tg-s6z2"><div id="st14" class="tg-btn" onClick="ScheduleOnChange('st14');"></div></td>
						    <td class="tg-s6z2"><div  id="s14" class="tg-btn" onClick="ScheduleOnChange('s14');"></div></td>
						  </tr>
						  <tr>
						    <td class="tg-hy62">16:00~18:00</td>
						    <td class="tg-s6z2"><div  id="m16" class="tg-btn" onClick="ScheduleOnChange('m16');"></div></td>
						    <td class="tg-s6z2"><div  id="t16" class="tg-btn" onClick="ScheduleOnChange('t16');"></div></td>
						    <td class="tg-s6z2"><div  id="w16" class="tg-btn" onClick="ScheduleOnChange('w16');"></div></td>
						    <td class="tg-s6z2"><div id="th16" class="tg-btn" onClick="ScheduleOnChange('th16');"></div></td>
						    <td class="tg-s6z2"><div  id="f16" class="tg-btn" onClick="ScheduleOnChange('f16');"></div></td>
						    <td class="tg-s6z2"><div id="st16" class="tg-btn" onClick="ScheduleOnChange('st16');"></div></td>
						    <td class="tg-s6z2"><div  id="s16" class="tg-btn" onClick="ScheduleOnChange('s16');"></div></td>
						  </tr>
						  <tr>
						    <td class="tg-hy62">18:00~20:00</td>
						    <td class="tg-s6z2"><div  id="m18" class="tg-btn" onClick="ScheduleOnChange('m18');"></div></td>
						    <td class="tg-s6z2"><div  id="t18" class="tg-btn" onClick="ScheduleOnChange('t18');"></div></td>
						    <td class="tg-s6z2"><div  id="w18" class="tg-btn" onClick="ScheduleOnChange('w18');"></div></td>
						    <td class="tg-s6z2"><div id="th18" class="tg-btn" onClick="ScheduleOnChange('th18');"></div></td>
						    <td class="tg-s6z2"><div  id="f18" class="tg-btn" onClick="ScheduleOnChange('f18');"></div></td>
						    <td class="tg-s6z2"><div id="st18" class="tg-btn" onClick="ScheduleOnChange('st18');"></div></td>
						    <td class="tg-s6z2"><div  id="s18" class="tg-btn" onClick="ScheduleOnChange('s18');"></div></td>
						  </tr>
						  <tr>
						    <td class="tg-hy62">20:00~22:00</td>
						    <td class="tg-s6z2"><div  id="m20" class="tg-btn" onClick="ScheduleOnChange('m20');"></div></td>
						    <td class="tg-s6z2"><div  id="t20" class="tg-btn" onClick="ScheduleOnChange('t20');"></div></td>
						    <td class="tg-s6z2"><div  id="w20" class="tg-btn" onClick="ScheduleOnChange('w20');"></div></td>
						    <td class="tg-s6z2"><div id="th20" class="tg-btn" onClick="ScheduleOnChange('th20');"></div></td>
						    <td class="tg-s6z2"><div  id="f20" class="tg-btn" onClick="ScheduleOnChange('f20');"></div></td>
						    <td class="tg-s6z2"><div id="st20" class="tg-btn" onClick="ScheduleOnChange('st20');"></div></td>
						    <td class="tg-s6z2"><div  id="s20" class="tg-btn" onClick="ScheduleOnChange('s20');"></div></td>
						  </tr>
						</table>
					</div>
				</div>
			</div>
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
<script type="text/javascript" src="js/account.js"></script>
</body>