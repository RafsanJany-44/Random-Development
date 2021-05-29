        //20210511 RJ getting group members data
        function group_members_data(org_id, dc_id) {
            var final_query_string = '{"org_id":"' + org_id + '","dc_id":"' + dc_id + '"}';

            var check = GroupAjax(final_query_string, "GroupMemebersData");
            return check;
        }
