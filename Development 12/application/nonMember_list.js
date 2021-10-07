// 20210511 RJ filtering members

function NonMember_list(dc_id) {
        
    var org_id = "@ViewBag.orgId";
    var all_contact = AllUserList;
    var members_data =JSON.parse(group_members_data(org_id, dc_id));
    var member_list = [];
    var non_memebers_list =[];

    for (var i in members_data.members) {

        member_list.push(members_data.members[i].bp_id.toString());

    }


    for (var i in all_contact) {
        if (!(member_list.includes(all_contact[i].bpId))) {
            
            non_memebers_list.push(all_contact[i]);
        }
    }

    return non_memebers_list;

    }
