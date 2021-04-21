//20210325 RJ Genarate members removing query
function remove_group_memebers(org_id, dc_id, bp_ids) {

    var members_query_string = '[';
    var final_query_string = '';

    for (var i = 0; i < bp_ids.length; i++) {
        members_query_string = members_query_string + '{"bp_id":"' + bp_ids[i] + '"}';

        if (i < bp_ids.length - 1) {
            members_query_string = members_query_string + ','
        }
        else {
            members_query_string = members_query_string + ']'
        }
    }

    final_query_string = '{"org_id":"' + org_id + '","dc_id":"' + dc_id + '","members":' + members_query_string + '}';
    var check = removeGroupMember(final_query_string);
    console.log(check);
}



//20210221 RJ remove members  with an ajax call
function removeGroupMember(query) {

    var data = JSON.stringify({ "query": query });
    var tmp_url = "/TextChat/RemoveGroupMemebers";
    var info = [];
    $("#accordion").ejAccordion("expandPanel", [1]);

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
