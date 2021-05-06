//20210323 RJ Genarate group creating query
function create_group(org_id, dc_name, dc_class, bp_ids, role_codes) {

    var members_query_string = '[';
    var final_query_string = '';

    for (var i = 0; i < bp_ids.length; i++) {
        members_query_string = members_query_string + '{"bp_id":"' + bp_ids[i] + '","role_code":"' + role_codes[i] + '"}';

        if (i < bp_ids.length - 1) {
            members_query_string = members_query_string + ','
        }
        else {
            members_query_string = members_query_string + ']'
        }
    }

    final_query_string = '{"org_id":"' + org_id + '","dc_name":"' + dc_name + '","discussion_class":"' + dc_class + '","members":' + members_query_string + '}';

    
    var check = GroupAjax(final_query_string,"CreateGroups");
    console.log(check);
    
}



//20210325 RJ adding members query

function add_group_members(org_id, dc_id, bp_ids, role_codes) {

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
  
    var check = GroupAjax(members_query_string, "AddGroupMemebers");
    console.log(check);
}




//20210325 RJ group deleting query
function delete_group(org_id, dc_id) {
    var final_query_string = '{"org_id":"' + org_id + '","dc_id":"' + dc_id + '"}';
   
    var check = GroupAjax(final_query_string, "DeleteGroup");
    console.log(check);
}




//20210325 RJ members removing query
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
    
    var check = GroupAjax(final_query_string, "RemoveGroupMemebers");
    console.log(check);
}

//20210329 RJ rename a group
function update_group_name(org_id, dc_id, new_name) {

    var final_query_string = '{"org_id":"' + org_id + '","dc_id":"' + dc_id + '","dc_name":"' + new_name + '"}';
    var check= GroupAjax(final_query_string, "UpdateGroupName");
    console.log(check);
    
}


//20210329 RJ GroupAjax calls ajax for group functinality
function GroupAjax(query, type) {
    
    var data = JSON.stringify({ "query": query });
    var tmp_url = "/TextChat/" + type;
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



//20210329 RJ rename a group
function update_group_name(org_id, dc_id, new_name) {

    var final_query_string = '{"org_id":"' + org_id + '","dc_id":"' + dc_id + '","dc_name":"' + new_name + '"}';
    var check= GroupAjax(final_query_string, "UpdateGroupName");
    console.log(check);
    
}


