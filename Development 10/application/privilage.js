    // 20210511 RJ checking admin privilage
    function Group_Admin_Privilege(org_id, dc_id) {

        var data = JSON.parse(group_members_data(org_id, dc_id));
        
        for (var i in data.members) {
            
            if (theBpId == data.members[i].bp_id && data.members[i].role_code == '$CGADMIN') {
                return 1;
            }
        }
        return 0;
    }

    // 20210511 RJ checking Owner privilage
    function Group_Owner_Privilege(org_id, dc_id) {

        var data = JSON.parse(group_members_data(org_id, dc_id));

        for (var i in data.members) {

            if (theBpId == data.members[i].bp_id && data.members[i].role_code == '$CGOWNER') {
                return 1;
            }
        }
        return 0;
    }
