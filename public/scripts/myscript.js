var d = new Date();
var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
document.getElementById("currentMonth").innerHTML = getMonth(d.getMonth());
document.getElementById("previousMonth").innerHTML = getPreviousMonth(d.getMonth());
document.getElementById("nextMonth").innerHTML = getNextMonth(d.getMonth());

function getMonth(monthInt) {
	return months[monthInt];
}

function getNextMonth(monthInt) {
	if (monthInt == 11)
	{
		return months[0];
	}
	return months[monthInt+1];
}

function getPreviousMonth(monthInt) {
	if (monthInt == 0)
	{
		return months[11];
	}
	return months[monthInt-1];
}