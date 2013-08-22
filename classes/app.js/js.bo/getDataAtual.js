function getDataAtual(){

    var thetime = new Date();

    var nmonth = thetime.getMonth();
    var ntoday = thetime.getDate();
    var nyear = thetime.getYear();

    if(nmonth < 10 ){
        nmonth = "0"+nmonth;
    }
    if(ntoday < 10 ){
        ntoday = "0"+ntoday;
    }

    var data = ntoday+"/"+nmonth+"/"+nyear;
    return data;
}