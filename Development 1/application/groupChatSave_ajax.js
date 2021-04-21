//20210405 RJ GroupAjax calls ajax for group save
function GroupAjax(org_id,dc_id,msg,recipient_id,sender_id) {

    var data = JSON.stringify({ "org_id": org_id , "dc_id":dc_id,"msg":msg,"recipient_id":recipient_id,"sender_id":sender_id});
    var tmp_url = "/TextChat/GroupChatSave";
    var info = [];
    $.ajax({
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        type: "post",
        cache: false,
        async: false,
        url: tmp_url,
        data: data,
        success: function (response) {

            info = response;

        },
        error: function (xhr) {
            alert("ajax calling failed");


        }
    });

    return info;
}
