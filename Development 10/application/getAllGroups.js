            //20210318 RJ Getting all group list for the first time connected
            chat.client.getAllGroups = function (grouplist) {
                $('#online-user-loader').hide();
                $('#displayname').val(theBpName);
                var userDivs = document.createElement("table");
                userDivs.id = "userTable";
                var userTableStyle = document.createAttribute("style");
                userTableStyle.value = "width : 100%";
                userDivs.setAttributeNode(groupTableStyle);
                for (var key in grouplist) {

                    var userTableRow = document.createElement("tr");
                    var userTableData = document.createElement("td");
                    var userData = addNewUserElement(grouplist[key].dc_id, grouplist[key].dc_name, grouplist[key].dc_class);
                    userTableData.appendChild(userData);
                    console.log(userTableData);
                    userTableRow.appendChild(userTableData);
                    userDivs.appendChild(userTableRow);
                }
            };