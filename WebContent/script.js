var login_type;
$(document).ready(function(){
	$("#customer").click(function(event) {
		/* Act on the event */
		$("#translator").removeClass('nav_hover');
		$("#translator_intro").fadeOut('fast', function() {
			$("#customer_intro").fadeIn('fast');
			$("#customer").addClass('nav_hover');
		});
	});

	$("#translator").click(function(event) {
		/* Act on the event */
		$("#customer").removeClass('nav_hover');
		$("#customer_intro").fadeOut('fast', function() {
			$("#translator_intro").fadeIn('fast');
			$("#translator").addClass('nav_hover');
		});
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