//20210325 RJ Genarate members adding query

function genarate_group_members(org_id, dc_id, bp_ids, role_codes) {

    var members_query_string = '[';


    for (var i = 0; i < bp_ids.length; i++) {
        members_query_string = members_query_string + '{"org_id":"' + org_id + '","dc_id":"' + dc_id + '","bp_id":"' + bp_ids[i] + '","role_code":"' + role_codes[i] + '"}';

        if (i < bp_ids.length - 1) {
            members_query_string = members_query_string + ',';
        }
        else {
            members_query_string = members_query_string + ']';
        }
    }
   var temp= insertGroupMember(members_query_string);
    console.log(temp);
}

//20210221 RJ insert group info with an ajax call
function insertGroupMember(query) {

    var data = JSON.stringify({ "query": query });
    var tmp_url = "/TextChat/AddGroupMemebers";
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

