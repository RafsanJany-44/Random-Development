    //20210520 RJ Group member adding confirmation
    function addGroupMemberConfirm(dc_id) {

        var org_id = "@ViewBag.orgId";
        var bp_ids = [];
        var role_codes = [];
        for (var i of window.g_arrAdmin) {
            bp_ids.push(i[0]);
            role_codes.push(i[1]);
        }

        for (var j of window.g_arrPart) {
            if (!(bp_ids.includes(j[0]))) {
                bp_ids.push(j[0]);
                role_codes.push(j[1]);
            }
        }

        add_group_members(temp_org_id, dc_id, bp_ids, role_codes);

    }