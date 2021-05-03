        //20210426 RJ added single message removing functionality
        function remove_msg_for_you(dc_id, topic_id){

            var temp_org_id = "@ViewBag.orgId";
            var temp_user_bp_id=theBpId;
            RemoveMsgAjax(temp_org_id, dc_id, topic_id, 0, temp_user_bp_id);

        }

        function remove_msg_for_everyone(dc_id, topic_id){
            var temp_org_id = "@ViewBag.orgId";
            var temp_user_bp_id=theBpId;
            RemoveMsgAjax(temp_org_id, dc_id, topic_id, 1, temp_user_bp_id)
        }

        function RemoveMsgAjax(org_id, dc_id, topic_id, type, user_bp_id) {
           
            var data = JSON.stringify({ "org_id": org_id, "dc_id": dc_id, "topic_id": topic_id, "type": type, "user_bp_id": user_bp_id });
            var tmp_url = "/TextChat/SingleMsgRemove";
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