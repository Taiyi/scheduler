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

	var lastMonth = d;
	lastMonth.setDate(1);
	lastMonth.setHours(-1);
	lastMonth = lastMonth.getDate()-start+1; //Gets the first visible date on calender



	var count = 1;
	var otherMonth = false;
	for (x=0; x<5; x++)
	{
		//Reset all assigned engineer entries to None
		var e = document.getElementById('e' + x);
		e.innerHTML = "None";

		for (y=0; y<7; y++)
		{
			var cellID = x+"x"+y;
			var d = document.getElementById(cellID);
			if ((x==0 && y>=start) || (x!=0))
				//if date is in active month
			{
				d.classList.remove("previousMonth");
				d.classList.remove("nextMonth");
				d.innerHTML = count;
				count++;

				if (otherMonth == true)
				{
					//if date is in next month
					d.className += " nextMonth";
				}
				if (count > end)
				{
					count = 1;
					otherMonth = true;
				}
			}
			else if (x==0 && y<start)
			{
				//if date is in last month
				d.innerHTML = lastMonth;
				lastMonth++;
				d.className += " previousMonth"
			}

			if (y==1)
			{
				//check if any engineer is active this week
				Object.keys(gon.schedule).forEach(function (key) {
					var dateArray = gon.schedule[key]// [year, month, day]

					var currentYear = activeMonthYear.getFullYear();
					var currentMonth = activeMonthYear.getMonth();
					var currentDay = d.innerHTML;

					e = document.getElementById('e' + x);
					if (dateArray[2] == currentDay)
					{
						if (dateArray[0] == currentYear && dateArray[1]-1 == currentMonth)
							//Month was stored 1-incremented so reduce by 1
						{
							//Current Month
							e.innerHTML = key;
							console.log(key, dateArray)
							console.log(currentYear, currentMonth+1, currentDay)
						}
						else if (dateArray[1]-1 == currentMonth-1)
						{
							//Past Month
							if (dateArray[0] == currentYear || (currentMonth == 0 && dateArray[0] == currentYear-1))
								//Checks year.
							{
								e.innerHTML = key;
							}
						}
						else if (dateArray[1]-1 == currentMonth+1)
						{
							//Next Month
							if (dateArray[0] == currentYear || (currentMonth == 0 && dateArray[0] == currentYear+1))
							{
								e.innerHTML = key;
							}
						}

					}
				});
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

document.getElementById('dropdown').onchange = function(){

	var selected = document.getElementById('dropdown').value;
	if (selected == "---")
	{
		return;
	}
	document.getElementById('command').innerHTML = "Switch " + selected + " With:";

	var entries = document.getElementsByClassName('engineerEntry');
	var len = entries.length;

	for (x=0; x<len; x++)
	{
		var entry = entries[x];
		var week = entry.id[1];
		var dayID = week+'x'+1;
		var dayElement = document.getElementById(dayID);
		var day = dayElement.innerHTML
		var month = activeMonthYear.getMonth();
		var year = activeMonthYear.getFullYear();

		if (dayElement.classList.contains("previousMonth"))
		{
			//this monday belongs to the previous month
			if (month == 0)
			{
				month = 11;
				year--;
			}
			else
			{
				month--;
			}
		}
		else if (dayElement.classList.contains("nextMonth"))
		{
			//this monday belongs to the next month
			if (month == 11)
			{
				month = 0;
				year++;
			}
			else
			{
				month++;
			}
		}

		entry.href = "/" + entry.innerHTML + "/" + selected  + "/" + year + "/" + month + "/" + day;
	}
};


document.getElementById('dropdown').value = "---";
var entries = document.getElementsByClassName('engineerEntry');
var len = entries.length;
for (x=0; x<len; x++)
{
	var entry = entries[x];
	entry.addEventListener("click", function() {
		var selected = document.getElementById('dropdown').value;
		if (selected == "---")
		{
			return;
		}
		this.innerHTML = selected;
		var href = this.href
		document.getElementById('dropdown').value = "---";
		document.getElementById('command').innerHTML = "Assigned Engineer";

		var entries = document.getElementsByClassName('engineerEntry');
		var len = entries.length;
		for (x=0; x<len; x++){
			var entry = entries[x];
			entry.removeAttribute("href");
		}
		window.location = href; //removing href prevents link from working so force redirect
	});
}
