// 20210304 RJ Getting msg data with ajax call (will be implemented as a part of onChatButtonClick)

        function get_msg_data(org_id,pt_id, dc_id, recepient_id, dc_class) {

            var msg_data = [];

            if (dc_class = "group")
            {
                var data = JSON.stringify({ "org_id": org_id, "pt_id": pt_id, "dc_id": dc_id, "recipent_bp_id": recepient_id, "sender_bp_id": recepient_id });
                console.log("calling group massage");
            }
            else
            {
                var data = JSON.stringify({ "org_id": org_id, "pt_id": pt_id, "dc_id": dc_id, "recipent_bp_id": recepient_id, "sender_bp_id": "null" });
                console.log("calling single message");
            }


            var tmp_url = "/TextChat/GetMsgHistory";

            $("#accordion").ejAccordion("expandPanel", [1]);

            $.ajax({
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                type: "post",
                cache: false,
                async: false,
                url: tmp_url,
                data: data,
                success: function (response) {

                    msg_data = response;

                },
                error: function (xhr) {
                    alert("ajax calling failed");


                }
            });

            return msg_data;

        }
        //20210304 RJ loading message in html element

        function load_msg_history(msg_data) {
            if(msg_data == null) {
                var msg_data = JSON.parse(get_msg_data(2, 14019, 15, 128993,"group"));
                console.log(msg_data);
            }

           
            var txt = "";
            for (var i = 0; i < msg_data.length; i++) {
                var contact = "";

                if (theBpId == msg_data[i].sender_bp_id) {
                    contact = addNewTextMessageElement(msg_data[i].recipent_bp_name, msg_data[i].topic_details, 'sent');
                    txt += contact;

                }
                else {
                    contact = addNewTextMessageElement(msg_data[i].username, msg_data[i].topic_details, 'received');
                    txt += contact;
                }


            }

            $('.message-area').append(txt);
            scrollTBottom($('.message-area'));
        }


        







//var msg_data = JSON.parse(get_msg_data(2, 14019, 15, 128993, "PRIVATE_GROUP")); 

        function get_msg_data(recepient_id, dc_class,org_id, pt_id, dc_id) {

            var msg_data = [];
            if (dc_class == "PRIVATE_GROUP" || dc_class=="PUBLIC_GROUP") {
                var data = JSON.stringify({ "org_id": org_id, "pt_id": pt_id, "dc_id": dc_id, "recipent_bp_id": recepient_id, "sender_bp_id": recepient_id });
                var tmp_url = "/TextChat/GetMsgHistory";
            }
            else {
                console.log("calling single message");
                var data = JSON.stringify({ "bp_id": recepient_id });
                var tmp_url = "../../TextChat/GetHistoryContactList";
            }


          //  var tmp_url = "/TextChat/GetMsgHistory";

            $("#accordion").ejAccordion("expandPanel", [1]);

            $.ajax({
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                type: "post",
                cache: false,
                async: false,
                url: tmp_url,
                data: data,
                success: function (response) {

                    msg_data = response;

                },
                error: function (xhr) {
                    $('#message-area-loader').hide();
                    alert("ajax calling failed");
                    

                }
            });

            return msg_data;

        }