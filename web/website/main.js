$(document).ready(function(){

	$("#successAlert").fadeOut(0);
	$("#failAlert").fadeOut(0);

	$("#submitEmail").click(function(){

		$("#successAlert").fadeOut(0);
		$("#failAlert").fadeOut(0);
		
		var email = $("#emailField").val();
		if (validateEmail(email)){

			$.ajax({type: "POST",
		  		url: "emailstorage.php",
		 		data: {"email":email},
		 		success: function(result){
		 			$("#successAlert").fadeIn(400)
		 			$("#emailField").val("")
		 		},
		 		dataType: "text"
			});

		}
		else {
			$("#failAlert").fadeIn(400)
		}

	})
	

});

function validateEmail(email) {
    var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
    return re.test(email);
}