        //20210518 RJ Updating group name
        function group_name_updata(org_id, dc_id,new_name) {
            var final_query_string = '{"org_id":"' + org_id + '","dc_id":"' + dc_id + '","dc_name":"' + new_name + '"}';

            var check = GroupAjax(final_query_string, "GroupNameUpdate");
            return check;
        }