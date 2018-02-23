var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

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

function fillCalander(dateString) {
	var monthInt = dateString.getMonth();
	var yearInt = dateString.getFullYear()
	var d = new Date(yearInt, monthInt, 1);
	document.getElementById("currentMonth").innerHTML = months[monthInt] + " " + yearInt;
	document.getElementById("previousMonth").innerHTML = getPreviousMonth(monthInt);
	document.getElementById("nextMonth").innerHTML = getNextMonth(monthInt);

	var start = d.getDay();	//
	var end = 32 - new Date(yearInt, monthInt, 32).getDate();	//

	var lastMonth = new Date()
	lastMonth.setDate(1);
	lastMonth.setHours(-1);
	lastMonth = lastMonth.getDate()-start+1; //Gets the first visible date on calender


	var count = 1;
	for (x=0; x<5; x++)
	{
		for (y=0; y<7; y++)
		{
			if ((x==0 && y>=start) || (x!=0))
			{
				var cellID = x+"x"+y;
				document.getElementById(cellID).innerHTML = count;
				count++;
				if (count > end)
				{
					count = 1;
				}
			}
			else if (x==0 && y<start)
			{
				var cellID = x+"x"+y;
				document.getElementById(cellID).innerHTML = lastMonth;
				lastMonth++;
			}
		}
	}
}

var activeMonthYear = new Date();
fillCalander(activeMonthYear);

document.getElementById('previousMonth').onclick = function(){
	activeMonthYear.setMonth(activeMonthYear.getMonth()-1)
	fillCalander(activeMonthYear);
};

document.getElementById('nextMonth').onclick = function(){
	activeMonthYear.setMonth(activeMonthYear.getMonth()+1)
	fillCalander(activeMonthYear);
};


document.getElementById('switchButton').onclick = function(){
	var selected = document.getElementById('dropdown').value;
	document.getElementById('command').innerHTML = "Switch " + selected + " With:";
};