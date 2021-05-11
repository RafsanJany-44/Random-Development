// Create a function that the hub can call back to display messages.
chat.client.notifyMessage = function (name, message, senderBpId) {
    //Remove message from pending messages cache as it is displayed instantly
    //debugger;
    //var x = chat.client.getAllUsers();
    chat.server.clearPendingMessages(theBpId, senderBpId);
    
    //if (!$('.text-chat-container').is(":visible")) {
    //ZH: 20180815 - Added the condition check. Now self messages are also loaded via the hub call
    var tempSharedObj = JSON.parse(SJ.localStorage.getItem('PL_CHAT_' + theBpId));
    var last_frnd_bp_id = $('#frndBpId').val();
    var tmp_last_frnd = last_frnd_bp_id;
    if (tempSharedObj != null) {
        last_frnd_bp_id = tempSharedObj.lastFrnd;
    }
    var last_offline_contact_bp_id = $('#offline_contact_to').val();
    if (theBpId != senderBpId){
        last_frnd_bp_id = senderBpId + '';
        var userElem = $('.user[bp_id="' + senderBpId + '"]');
        //////start
        //Eh 181211
        if (tmp_last_frnd == '' && last_offline_contact_bp_id == '') {
            if (userElem.length <= 0) {
                chat.server.loadOnlineUser(senderBpId).done(function () {
                    //alert("Rahat vai");
                    //This will execute only once  between two new bp
                    setTimeout(function () {
                        initiateTextChat(senderBpId);
                    }, 3000);

                });

            }
            else {
                initiateTextChat(senderBpId);
            }
        }

        //////end
        //EH 181211 relocated above
        @*//$('.text-chat-container').show("slide", { direction: 'left' }, "slow");
        //$('.message-area-header').html("In Conversation with " + userElem.text());
        //$('.chat-box').html("<span class=\"e-icon e-plus\"></span>Chat: In Conversation with " + userElem.text()); //MRR 180820 text changed from chat box to chat
        $('.chat-box').html("<span class=\"e-icon e-minus\"></span>@PL_T("AV.TextChat.TextChat.Accordion.Chat.Title", "Chat"): " + inConvMessage.replace('{0}', userElem.text()));
        //$('.chat-close-control').show();
        // Clear text box and reset focus for next comment.
        $('#message').val('').focus();
        $('#frndBpId').val(userElem.attr('bp_id'));

        $('#sendmessage').prop("disabled", false);
        $('#message').prop("disabled", false);

        //ZH: 20180816 - Added pop message falsh
        //ZH: 20180831 - Changed - Flash only when chat pane is hidden. If not hidden, check if Chat Accordion is hidden
        if ($('.right-pane').hasClass('hidden')) {
            var imgElem = $('.online-icon').find('img');
            imgElem.attr('src', '/Content/images/chat-online-flash.gif');
        }
        else{
            var accrodion_obj = $("#accordion").ejAccordion('instance');

            //ZH: chekcing if value 1 exisits in the selectedItems array. (Equivalent to indexOf())
            if ($.inArray(1, accrodion_obj.model.selectedItems) == -1) {
                var imgElem = $('.online-icon').find('img');
                imgElem.attr('src', '/Content/images/chat-online-flash.gif');
            }
        }*@
    }
    //}

    //EH  190313
    // $('.message-area').append(addNewTextMessageElement(name, message));

    //if (tmp_last_frnd == '' || tmp_last_frnd == senderBpId || last_offline_contact_bp_id == '')
    if (tmp_last_frnd == senderBpId || last_offline_contact_bp_id == senderBpId || (tmp_last_frnd == '' && last_offline_contact_bp_id == '')) {
        
        $('.message-area').append(genarate_msg_html(name, message, 'received'));     // --------
        //ZH: 20180815 - Adding the current message html portion in the localstorage for tab sharing
        var sharedObject = { 'lastFrnd': last_frnd_bp_id, 'last_history': $('.message-area').html() };
        //SJ.localStorage.setItem('PL_CHAT_' + theBpId, $('.message-area').html());
        SJ.localStorage.setItem('PL_CHAT_' + theBpId, JSON.stringify(sharedObject));


        //Scroll To Bottom:
        scrollTBottom($('.message-area'));
    }
    else {

        var userElem = $('.user[bp_id="' + senderBpId + '"]');
        if (userElem.length <= 0) {
            chat.server.loadOnlineUser(senderBpId).done(function () {
                //alert("Rahat vai");
                //This will execute only once  between two new bp
                setTimeout(function () {
                    showmsgnotification(senderBpId);
                }, 3000);

            });

        }
        else {
            showmsgnotification(senderBpId);
        }

    }

    ////ZH: 20180815 - Adding the current message html portion in the localstorage for tab sharing
    //var sharedObject = { 'lastFrnd': last_frnd_bp_id, 'last_history': $('.message-area').html() };
    ////SJ.localStorage.setItem('PL_CHAT_' + theBpId, $('.message-area').html());
    //SJ.localStorage.setItem('PL_CHAT_' + theBpId, JSON.stringify(sharedObject));


    ////Scroll To Bottom:
    //scrollTBottom($('.message-area'));
};         
           
           
           
           
           
           
           
           
           
           
           
           // Create a function that the hub can call back to display messages.
            chat.client.notifyMessage = function (name, message, senderBpId,user_id) {
                //Remove message from pending messages cache as it is displayed instantly
                //debugger;
                //var x = chat.client.getAllUsers();
                chat.server.clearPendingMessages(theBpId, senderBpId);
                
                //if (!$('.text-chat-container').is(":visible")) {
                //ZH: 20180815 - Added the condition check. Now self messages are also loaded via the hub call
                var tempSharedObj = JSON.parse(SJ.localStorage.getItem('PL_CHAT_' + theBpId));
                var last_frnd_bp_id = $('#frndBpId').val();
                var tmp_last_frnd = last_frnd_bp_id;
                if (tempSharedObj != null) {
                    last_frnd_bp_id = tempSharedObj.lastFrnd;
                }
                var last_offline_contact_bp_id = $('#offline_contact_to').val();
               // if (theBpId != senderBpId)
                if(theBpId != user_id){
                    last_frnd_bp_id = senderBpId + '';
                    var userElem = $('.user[bp_id="' + senderBpId + '"]');
                    //////start
                    //Eh 181211
                    if (tmp_last_frnd == '' && last_offline_contact_bp_id == '') {
                        if (userElem.length <= 0) {
                            chat.server.loadOnlineUser(senderBpId).done(function () {
                                //alert("Rahat vai");
                                //This will execute only once  between two new bp
                                setTimeout(function () {
                                    initiateTextChat(senderBpId);
                                }, 3000);

                            });

                        }
                        else {
                            initiateTextChat(senderBpId);
                        }
                    }

                    //////end
                    //EH 181211 relocated above
                    @*//$('.text-chat-container').show("slide", { direction: 'left' }, "slow");
                    //$('.message-area-header').html("In Conversation with " + userElem.text());
                    //$('.chat-box').html("<span class=\"e-icon e-plus\"></span>Chat: In Conversation with " + userElem.text()); //MRR 180820 text changed from chat box to chat
                    $('.chat-box').html("<span class=\"e-icon e-minus\"></span>@PL_T("AV.TextChat.TextChat.Accordion.Chat.Title", "Chat"): " + inConvMessage.replace('{0}', userElem.text()));
                    //$('.chat-close-control').show();
                    // Clear text box and reset focus for next comment.
                    $('#message').val('').focus();
                    $('#frndBpId').val(userElem.attr('bp_id'));

                    $('#sendmessage').prop("disabled", false);
                    $('#message').prop("disabled", false);

                    //ZH: 20180816 - Added pop message falsh
                    //ZH: 20180831 - Changed - Flash only when chat pane is hidden. If not hidden, check if Chat Accordion is hidden
                    if ($('.right-pane').hasClass('hidden')) {
                        var imgElem = $('.online-icon').find('img');
                        imgElem.attr('src', '/Content/images/chat-online-flash.gif');
                    }
                    else{
                        var accrodion_obj = $("#accordion").ejAccordion('instance');

                        //ZH: chekcing if value 1 exisits in the selectedItems array. (Equivalent to indexOf())
                        if ($.inArray(1, accrodion_obj.model.selectedItems) == -1) {
                            var imgElem = $('.online-icon').find('img');
                            imgElem.attr('src', '/Content/images/chat-online-flash.gif');
                        }
                    }*@
                }
                //}

                //EH  190313
                // $('.message-area').append(addNewTextMessageElement(name, message));

                //if (tmp_last_frnd == '' || tmp_last_frnd == senderBpId || last_offline_contact_bp_id == '')
                if ((tmp_last_frnd == senderBpId && user_id!=theBpId) || last_offline_contact_bp_id == senderBpId || (tmp_last_frnd == '' && last_offline_contact_bp_id == '')) {
                    
                    $('.message-area').append(genarate_msg_html(name, message, 'received'));     // --------
                    //ZH: 20180815 - Adding the current message html portion in the localstorage for tab sharing
                    var sharedObject = { 'lastFrnd': last_frnd_bp_id, 'last_history': $('.message-area').html() };
                    //SJ.localStorage.setItem('PL_CHAT_' + theBpId, $('.message-area').html());
                    SJ.localStorage.setItem('PL_CHAT_' + theBpId, JSON.stringify(sharedObject));


                    //Scroll To Bottom:
                    scrollTBottom($('.message-area'));
                }
                else {

                    var userElem = $('.user[bp_id="' + senderBpId + '"]');
                    if (userElem.length <= 0) {
                        chat.server.loadOnlineUser(senderBpId).done(function () {
                            //alert("Rahat vai");
                            //This will execute only once  between two new bp
                            setTimeout(function () {
                                showmsgnotification(senderBpId);
                            }, 3000);

                        });

                    }
                    else {
                        showmsgnotification(senderBpId);
                    }

                }

                ////ZH: 20180815 - Adding the current message html portion in the localstorage for tab sharing
                //var sharedObject = { 'lastFrnd': last_frnd_bp_id, 'last_history': $('.message-area').html() };
                ////SJ.localStorage.setItem('PL_CHAT_' + theBpId, $('.message-area').html());
                //SJ.localStorage.setItem('PL_CHAT_' + theBpId, JSON.stringify(sharedObject));


                ////Scroll To Bottom:
                //scrollTBottom($('.message-area'));
            };

























           

