 //20210521 RJ date Filtering for msg
 function dateFilter() {
    var dateTime = "2021-04-19T06:43:49.349311+02:00";
    var date = dateTime.slice(0, 9);
    return date;
}

//20210521 RJ time Filtering for msg
function timeFilter(){

    var dateTime = "2021-04-19T23:43:49.349311+02:00";

    var hours = parseInt(dateTime[11] + dateTime[12]);
    var min = dateTime[14] + dateTime[15];
    console.log(hours);
    console.log(min);
    var Time;
    var meridiem;

        if (hours >= 0 && hours <= 12)
        {
            var meridiem = "am";
            if (hours == 0) {
                hours = "12";
            }

            else if (hours > 0 && hours < 10) {
                hours = "0" + hours.toString();

            }
            else {
                hours = hours.toString();
            }
        }
        else {
            var meridiem = "pm";
            hours = hours - 12;
            if (hours > 0 && hours < 10) {
                hours = "0" + hours.toString();

            }
            else {
                hours = hours.toString();
            }
        }
    
    Time=hours+":"+min+meridiem;

    console.log(Time);

}