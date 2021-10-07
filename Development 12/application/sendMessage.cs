        //20210311 RJ modified sendMessage() for both group and single chat
        
        public void sendMessage(string name, string message, int senderBpId, int? pt_id, int dc_id, int recipient_id)
        {
            Dictionary<int, string> messageDict = new Dictionary<int, string>();
            List<int> bp_ids = new List<int>();
            string textMessage = "";


        if (dc_id = recipient_id){
            
            // bp_id from discussion_category members into bp_ids array
            int org_id = 2;

            using (var context = new EventEntities())
            {
                try
                {

                    //string sql = "select msg.chat_group_member_data('{\"org_id\":\"" + org_id + "\",\"dc_id\":\"" + dc_id + "\"}')";
                     string sql = "select msg.chat_group_member_data((\'{\"org_id\":\"\'||org_id::text||\'\",\"dc_id\":\"\'|| dc_id::text ||\'\"}\'))from public.discussion_category dc where dc_id=" + dc_id;
                    string group_data = context.Database.SqlQuery<string>(sql).FirstOrDefault();
                    
                    JObject obj = JObject.Parse(group_data);
                    JArray array = (JArray)obj["members"];
                    int bp;
                    for (int  i= 0; i < array.Count; i++)
                        {
                            bp = (int)array[i]["bp_id"];
                            bp_ids.Add(bp);
                        }
   
                }
                catch (Exception ex)
                {
                  string err = ex.Message;
                }
            }
 

        }
        else{
            bp_ids.Add(recipient_id);
        }
        
        
        foreach (var receiverBpId in bp_ids)
            {

                if (pendingMessageDict.ContainsKey(receiverBpId))
                {
                    messageDict = pendingMessageDict[receiverBpId];

                    if (messageDict.ContainsKey(senderBpId))
                    {
                        textMessage = messageDict[senderBpId];
                        messageDict[senderBpId] = textMessage + "||" + message;
                        
                    }
                    else
                    {
                        messageDict.Add(senderBpId, message);
                        
                    }
                    pendingMessageDict[receiverBpId] = messageDict;
                
                }
                else
                {
                    messageDict.Add(senderBpId, message);
                    pendingMessageDict.Add(receiverBpId, messageDict);
                }
                
                try
                {
                    if (connectionsDict != null)
                    {

                        string[] activeConnIds = (string[])connectionsDict[receiverBpId.ToString()].connectionsList.ToArray(typeof(string));

                        Clients.Clients(activeConnIds).notifyMessage(name, message, senderBpId);
                        var senderConnId = Context.ConnectionId;
                        Clients.Client(senderConnId).notifyMessage(name, message, senderBpId);
                        Clients.Clients(activeConnIds).popMessageCall(name, message);
                    }

                }
                catch { }
            }

            foreach (var receiverBpId in bp_ids){
            saveChatHistory(senderBpId, receiverBpId, message);
            }

        }  
       




// the old one ----------------------------------------------------

        public void sendMessage(string name, string message, int senderBpId, int receiverBpId)
        {
            Dictionary<int, string> messageDict = new Dictionary<int, string>();
            string textMessage = "";


            if (pendingMessageDict.ContainsKey(receiverBpId))
            {
                messageDict = pendingMessageDict[receiverBpId];

                if (messageDict.ContainsKey(senderBpId))
                {
                    textMessage = messageDict[senderBpId];
                    messageDict[senderBpId] = textMessage + "||" + message;
                    
                }
                else
                {
                    messageDict.Add(senderBpId, message);
                    
                }
                pendingMessageDict[receiverBpId] = messageDict;
               
            }
            else
            {
                messageDict.Add(senderBpId, message);
                pendingMessageDict.Add(receiverBpId, messageDict);
            }
            
            //ZH: Getting all available connection IDs from the Connections Dictionary.
            //Facilitating the new Offline user handling. (Sending message to all active connectio  ids)
            //20210215 RJ WY try catch implemented

            //20210215 RJ checking if connectionsDict null or not

            try
            {
                if (connectionsDict != null)
                {

                    string[] activeConnIds = (string[])connectionsDict[receiverBpId.ToString()].connectionsList.ToArray(typeof(string));


                    //Clients.Client(toConnectionId).notifyMessage(name, message, senderBpId);
                    Clients.Clients(activeConnIds).notifyMessage(name, message, senderBpId);


                    //ZH: 20180816 - Added Segment to send notifyMessage call to sender itself
                    var senderConnId = Context.ConnectionId;

                    Clients.Client(senderConnId).notifyMessage(name, message, senderBpId);

                    //Clients.Client(toConnectionId).popMessageCall(name, message);
                    Clients.Clients(activeConnIds).popMessageCall(name, message);
                }

            }
            catch { }

            // EH 180815 save messages
            saveChatHistory(senderBpId, receiverBpId, message);
            //_chatService.SaveChatHistory(senderBpId, receiverBpId, message);
        
        }