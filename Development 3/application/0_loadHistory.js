 function loadHistory(contactBpId, currentOnline)
        {
            //debugger;
            //console.log(contactBpId);
            var data = JSON.stringify({ "bp_id": contactBpId });

            //var data = JSON.stringify({ "path": $(this).attr("data-path"), "bp_id": $(this).attr("data-bp-id"), "pt_id": $(this).attr("data-pt-id"), "org_id": $(this).attr("data-org-id") });
            var tmp_url = "../../TextChat/GetHistoryContactList";
            //$("#content-loader-modal").modal('show')
            $("#accordion").ejAccordion("expandPanel", [1]);

            $('#message-area-loader').show();

            //$('#content-loader-modal').modal('show');
            $.ajax({
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                type: "post",
                cache: false,
                async: true,
                url: tmp_url,
                 data: data,
                 success: function (response) {
                     //$("#content-loader-modal").modal('hide')
                     $('#message-area-loader').hide();
                    // $('#content-loader-modal').modal('hide');
                    var Obj = JSON.parse(response);

                    var txt = "";
                    for (var i = 0; i < Obj.length; i++) {
                        var contact = "";
                        //var contact = "<a href='' onclick='loadHistory(" + Obj[i].bp_id + ")'>" + Obj[i].bp_name + "</a>";
                        if (theBpId == Obj[i].bp_id) {
                            contact = genarate_msg_html(Obj[i].username, Obj[i].message, 'sent');
                            txt += contact;
                        }
                        else {
                            contact = genarate_msg_html(Obj[i].username, Obj[i].message, 'received');
                            txt += contact;
                        }


                    }
                    //ZH: 20180820 - Commented out contact hsitory html. Added message area prepend();
                     //$(".contact-history").html(txt);
                    $('.message-area').prepend(txt);

                    //EH 180817 expand contact history
                    //$("#accordion").ejAccordion("expandPanel", [2]);
                    scrollTBottom($('.message-area'));

                     //ZH: 20180820 - Adding the current message html portion in the localstorage for tab sharing
                    var last_frd = '';
                    if (currentOnline) {
                        last_frd = contactBpId + '';
                    }

                    var sharedObject = { 'lastFrnd': last_frd, 'last_history': $('.message-area').html() };

                    SJ.localStorage.setItem('PL_CHAT_' + theBpId, JSON.stringify(sharedObject));

                     //EH 180830 disable chat option for offline user

                 },
                error: function (xhr) {
                    // $("#content-loader-modal").modal('hide')
                    $('#message-area-loader').hide();

               }
            });

        }
       