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