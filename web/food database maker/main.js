$(document).ready(function() {


	$( "#testSubmit" ).click(function() {

		var openYear = $("#meal_open_year").val()
		var openMonth = $("#meal_open_month").val()
		var openDay = $("#meal_open_day").val()
		var openHour = $("#meal_open_hour").val()
		var openMinute = $("#meal_open_minute").val()

		var openDate = new Date(openYear,openMonth,openDay,openHour,openMinute,0)
		
		$("#meal_open_time_string").val(openDate.toJSON());

	});


});


window.onbeforeunload = function() {
    localStorage.setItem(openYear, $('#meal_open_year').val());
    localStorage.setItem(openMonth, $('#meal_open_month').val());
    localStorage.setItem(openDay, $('#meal_open_day').val());
    localStorage.setItem(openHour, $('#meal_open_hour').val());
    localStorage.setItem(openMinute, $('#meal_open_minute').val());
}

window.onload = function() {

    var openYear = localStorage.getItem(openYear);
    if (openYear !== null) $('#meal_open_year').val(openYear);

}