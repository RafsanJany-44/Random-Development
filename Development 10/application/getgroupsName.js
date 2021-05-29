function getGroupNames(n_org_id, n_pt_id) { // add another perameter groupList,
    // type of groupLisst is undefinded then
    var obj = JSON.parse(loadGroupInfo(n_org_id, n_pt_id));
    //else obj=json.pars(grouplist)
    var nameArr = []
    console.log(obj);
    //MAR 20210226 - userOnline changed to userTable and add
    var userDivs = document.createElement("table");
    //userDivs.id = "userOnline";
    userDivs.id = "GroupsTable";
    var userTableStyle = document.createAttribute("style");
    userTableStyle.value = "width : 100%";
    userDivs.setAttributeNode(userTableStyle);
    for (var i = 0; i < obj.length; i++) {
        var userTableRow = document.createElement("tr");
        var userTableData = document.createElement("td");
        nameArr.push(obj[i].dc_name);
        var userData = addNewUserElement("", "", nameArr[i], "online");
        userTableData.appendChild(userData);
        userTableRow.appendChild(userTableData);
        userDivs.appendChild(userTableRow);
    }