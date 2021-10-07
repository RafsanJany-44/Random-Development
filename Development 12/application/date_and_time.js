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



























     //20210531 RJ date serialization
     function dateSerializeCheck(date) { 
    
        console.log(window.g_date);
        var len = window.g_date.length;
        if (len > 1) {
            if (window.g_date[len - 2] == date) {
                return "";
            }
            else {
                return date;
            }
        }
        else{
            return date;
        }
    }

    //20210521 RJ date Filtering for msg
    function dateFilter(dateTime) {
        
        var date = dateTime.slice(0, 10);
        return date;
    }

        //20210521 RJ time Filtering for msg
        function timeFilter(dateTime){


            var hours = parseInt(dateTime[11] + dateTime[12]);
            var min = dateTime[14] + dateTime[15];
            var Time;
            // var meridiem;

            /*    if (hours >= 0 && hours <= 12)
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
                }*/
            if (hours => 0 || hours <= 9) {
                hours =  hours.toString();
            }
            else { 
                hours = hours.toString();
            }
        
            Time=hours+":"+min;

            return Time;

        }

        //20210524 RJ checking thee date is today or not
        function isToday(date) {

            var today = new Date();
            var msg_date = dateFilter(date);
        
        
            if (((today.getMonth() + 1)) < 10) {
                var t_date = today.getFullYear() + '-0' + (today.getMonth() + 1) + '-' + today.getDate();
            }
            else {
                var t_date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
            }
            var check=0;
            if (msg_date == t_date) {
                check = 1;
            }
            return check;
        }































//20210531 RJ date serialization
function dateSerializeCheck(date) { 
    
    console.log(window.g_date);
    var len = window.g_date.length;
    if (len > 1) {
        if (window.g_date[len - 2] == date) {
            return "";
        }
        else {
            return date;
        }
    }
    else{
        return date;
    }
}

//20210521 RJ date Filtering for msg
function dateFilter(dateTime) {
    
    var date = dateTime.slice(0, 10);
    return date;
}

    //20210521 RJ time Filtering for msg
    function timeFilter(dateTime){


        var hours = parseInt(dateTime[11] + dateTime[12]);
        var min = dateTime[14] + dateTime[15];
        var Time = (hours < 10 ? '0' : '') + hours + ":" + (min < 10 ? '0' : '') + min;
        return Time;

    }

    //20210524 RJ checking thee date is today or not
    function isToday(date) {

        var today = new Date();
        var msg_date = dateFilter(date);
    
    
        if (((today.getMonth() + 1)) < 10) {
            var t_date = today.getFullYear() + '-0' + (today.getMonth() + 1) + '-' + today.getDate();
        }
        else {
            var t_date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
        }
        var check=0;
        if (msg_date == t_date) {
            check = 1;
        }
        return check;
    }