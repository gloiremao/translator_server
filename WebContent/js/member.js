var login_type;
$(document).ready(function(){
	$("#user").click(function(event) {
		/* Act on the event */
		$("#header-wrapper").slideUp("slow");
		$(".translator").hide(1, function() {
			$("#content-wrapper").slideDown('slow');
		});
		$("#content-img").css('background-image', 'none');
	});
	$("#translator").click(function(event) {
		/* Act on the event */
		$("#header-wrapper").slideUp("slow");
		$(".user").hide(1, function() {
			$("#content-wrapper").slideDown('slow');
		});
		$("#content-img").css('background-image', 'none');
		document.getElementById("people").value = "translator";
	});

	$("#account").keyup(function(event) {
		/* Act on the event */
		$("#account-wrapper").addClass('has-error');
		var phone = $("#account").val();
		if(phone.length == 10){
			re = /^[0]{1}[9]{1}\d{8}/;
			if(re.test(phone)){
				$("#account-wrapper").removeClass('has-error');
				$("#account-wrapper").addClass('has-success');
				$("#account-wrapper").addClass('has-feedback');
			}
		}
	});

	$("#pwd").keyup(function(event) {
		/* Act on the event */
		$("#pwd-wrapper").addClass('has-error'); 
		var pwd = $("#pwd").val();
		re = /^\w{6}\w*/;
		if(re.test(pwd)){
			$("#pwd-wrapper").removeClass('has-error');
			$("#pwd-wrapper").addClass('has-success');
		}
	});

	$("#pwd2").keyup(function(event) {
		/* Act on the event */
		$("#pwd-wrapper").addClass('has-error'); 
		var pwd = $("#pwd").val();
		var pwd2 = $("#pwd2").val();
		
		if(pwd == pwd2){
			$("#pwd-wrapper").removeClass('has-error');
			$("#pwd-wrapper").addClass('has-success');
		}
	});

	$("#mail").keyup(function(event) {
		/* Act on the event */
		$("#mail-wrapper").addClass('has-error'); 
		var mail = $("#mail").val();
		re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		if(re.test(mail)){
			$("#mail-wrapper").removeClass('has-error');
			$("#mail-wrapper").addClass('has-success');
		}
	});

	$("#mail2").keyup(function(event) {
		/* Act on the event */
		$("#mail-wrapper").addClass('has-error'); 
		var mail = $("#mail").val();
		var mail2 = $("#mail2").val();
		
		if(mail == mail2){
			$("#mail-wrapper").removeClass('has-error');
			$("#mail-wrapper").addClass('has-success');
		}
	});

	$("#name").keyup(function(event) {
		/* Act on the event */
		$("#name-wrapper").addClass('has-success'); 
	});

	$("#loginbtn").click(function(event) {
		/* Act on the event */
		$("#login-input").fadeOut('fast', function() {
			$("#login-select").fadeIn('fast');
		});
	});

	$("#login-user").click(function(event) {
		/* Act on the event */
		login_type = "normal";
		$("#login-select").fadeOut('fast', function() {
			$("#login-input").fadeIn('fast');
		});
	});
	$("#login-translator").click(function(event) {
		/* Act on the event */
		login_type = "translator";
		$("#login-select").fadeOut('fast', function() {
			$("#login-input").fadeIn('fast');
		});
	});

});

function check(){
	var phone = document.getElementById("account").value;
	if(phone.length == 10){
		re = /^[0]{1}[9]{1}\d{8}/;
		if(re){

		}
	}
}



function reg(){
	
	
	$.ajax({
	    url: 'member.register',
	    type: 'POST',
	    data: {
	    	type: $("#people").val(),
	      	account: $('#account').val(),
	      	pwd: $('#pwd2').val(),
	      	mail: $('#mail2').val(),
	      	name: $('#name').val(),
	      	lang: $('#lang').val()
	    },
	    error: function(xhr) {
	      alert('發生錯誤');
	    },
	    success: function(response) {
	      
	      window.location.href="index.jsp";
	    }
	});

	
}

function check(){
	var account = document.getElementById("account").value;
	var pwd = document.getElementById("pwd").value;
	var pwd2 = document.getElementById("pwd2").value;
	var mail = document.getElementById("mail").value;
	var mail2 = document.getElementById("mail2").value;
	var name = document.getElementById("name").value;
	
	if(account.length == 0 || pwd.length == 0 || pwd2.length == 0 || mail.length == 0 || mail2.length == 0 || name.length == 0){
		alert("something is empty!");
		return false;
	}
	else {
		return true;
	}
}

function login() {
	// body...
	$.ajax({
	    url: 'member.login',
	    type: 'POST',
	    data: {
	    	type: login_type,
	      	account: $("#m_account").val(),
	      	pwd: $("#m_pwd").val()
	    },
	    error: function(xhr) {
	      alert('Ajax request 發生錯誤');
	    },
	    success: function(response) {
	      
	      if(response == "fail"){
	      	$("#login_fail").fadeIn('fast');
	      }else{
	      	$("#login_fail").fadeOut('fast');
	      	$("#dismiss").trigger( "click" );
	      	$("#loginbtn").hide(100, function() {
	      		$("#logoutbtn").fadeIn('fast');
	      	});
	      	window.location.href="account.jsp";
	      }
	    }
	});
}

function logout() {
	$.ajax({
	    url: 'member.logout',
	    type: 'POST',
	    error: function(xhr) {
	      alert('Ajax request 發生錯誤');
	    },
	    success: function(response) {
	      
	      if(response == "logout"){
	      	location.reload();
	      }
	    }
	});
}

function enter(e) {
	if (e.keyCode == 13) {
        login();
        return false;
    }
}
