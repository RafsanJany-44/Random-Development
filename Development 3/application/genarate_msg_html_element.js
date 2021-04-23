function genarate_msg_html(name, message,type) {

    var messageDiv = "";
    if (type == "received") {
        messageDiv = "<div class='pl_tc_rcvd_from'>" + htmlEncode(name) + "</div><div class='pl_tc_rcvd'><div class='pl_tc_rcvd_msg'>" + htmlEncode(message) + "</div></div>";
    }
    else {
        messageDiv = "<div class='pl_tc_sent_by'>" + htmlEncode(name) + "</div><div class='pl_tc_sent'><div class='pl_tc_sent_msg'>" + htmlEncode(message) + "</div></div>";
    }
    return messageDiv;
}
