var time_array = new Array();
var delete_time = new Array();
var login_type;
$(document).ready(function(){
	$("#change-setting").click(function(event) {
		/* Act on the event */
		$(".menu_btn").removeClass('menu_btn-focus');
		$(this).addClass('menu_btn-focus');
		$(".menu_data").css('display', 'none');
		$("#data-setting").fadeIn('fast');
		
		
	});
	$("#change-pwd").click(function(event) {
		/* Act on the event */
		$(".menu_btn").removeClass('menu_btn-focus');
		$(this).addClass('menu_btn-focus');
		$(".menu_data").css('display', 'none');
		$("#data-pwd").fadeIn('fast');
	});
	$("#change-schedule").click(function(event) {
		/* Act on the event */
		$(".menu_btn").removeClass('menu_btn-focus');
		$(this).addClass('menu_btn-focus');
		$(".menu_data").css('display', 'none');
		$("#data-schedule").fadeIn('fast');
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

function enter(e) {
	if (e.keyCode == 13) {
        login();
        return false;
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
	      	location.reload();
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

function  getSchedule(){

	time_array.splice(0,time_array.length);
	delete_time.splice(0,delete_time.length);
	$.ajax({
	    url: 'schedule.update',
	    type: 'GET',
	    contentType: "application/json", 
	    dataType: "json", 
	    error: function(xhr) {
	      alert('Ajax request 發生錯誤3');
	    },
	    success: function(response) {

	    	$.each(response, function(index, val) {
	    		 /* iterate through array or object */
	    		 $("#"+val).trigger( "click" );
	    		 delete_time[delete_time.length] = val;
	    	});
	      	console.log('Ajax request success');
	      	
	    }
	});
}

var i;
function ScheduleOnChange(time) {
	if(isItemObjectExisted(time)){
		time_array.splice(i,1);
		$("#"+time).css('background-color', '#eaeaea');
		$("#"+time).html(" ");
	}else{
		time_array[time_array.length] = time;
		$("#"+time).css('background-color', '#A7DF8D');
		$("#"+time).html("<i class='fa fa-phone fa-2x'></i>");
	}
	
	$('#schedule-btn').prop('disabled', false);
}

function isItemObjectExisted(item){
	for (i = time_array.length - 1; i >= 0; i--) {
		if(time_array[i] == item){
			return true;
		}
	};
	return null;
}

function scheduleHandler () {
	// body...
	//alert(time_array);
	$('#schedule-btn').prop('disabled', true);
	$("#schedule-table").fadeOut(1, function() {
		$("#loading-page").fadeIn(1);
	});

	$.each(time_array, function(index, val) {
		var delete_index = delete_time.indexOf(val);
		if(delete_index != -1){
			delete_time.splice(delete_index,1);
		}
	});
	console.log("delete: "+delete_time+" add: "+time_array);
	$.ajax({
	    url: 'schedule.update',
	    type: 'POST',
	    data: {
	      	addItem:time_array,
	      	deleteItem:delete_time
	    },
	    error: function(xhr) {
	      alert('Ajax request 發生錯誤');
	      
	    },
	    success: function(response) {
	    	console.log("update schedule table");
	    	$("#loading-page").fadeOut(500,function(){
	    		$("#schedule-table").fadeIn('fast');
	    	});
	    }
	});
}
