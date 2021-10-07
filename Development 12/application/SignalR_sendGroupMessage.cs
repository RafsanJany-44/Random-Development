        public void sendGroupMessage(int org_id,string name, int dc_id, string message, int recipient_id, int senderBpId, int? pt_id)
        {
            Dictionary<int, string> messageDict = new Dictionary<int, string>();
            List<int> bp_ids = new List<int>();
            string textMessage = "";


            if (dc_id == recipient_id){
            
                using (var context = new EventEntities())
                {
                    try
                    {

                        string sql = "select msg.chat_group_member_data((\'{\"org_id\":\"\'||org_id::text||\'\",\"dc_id\":\"\'|| dc_id::text ||\'\"}\'))from public.discussion_category dc where dc_id=" + dc_id;
                        string group_data = context.Database.SqlQuery<string>(sql).FirstOrDefault();

                        JObject obj = JObject.Parse(group_data);
                        JArray array = (JArray)obj["mem bers"];
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

               // foreach (var receiverBpId in bp_ids){
               // saveChatHistory(senderBpId, receiverBpId, message);
                //}

        }


//20210431



  //20210311 RJ modified sendMessage for both group and single chat

        public void sendMessage(int org_id, string name, int dc_id, string message, int recipient_id, int senderBpId, int? pt_id)
        {
            Dictionary<int, string> messageDict = new Dictionary<int, string>();
            List<int> bp_ids = new List<int>();
            string textMessage = "";
            int flage = 1; // 1 for group and 0 for one to one

            if (dc_id == recipient_id)
            { // for group case

                using (var context = new EventEntities())
                {
                    try
                    {

                        string sql = "select msg.chat_group_member_data((\'{\"org_id\":\"\'||org_id::text||\'\",\"dc_id\":\"\'|| dc_id::text ||\'\"}\'))from public.discussion_category dc where dc_id=" + dc_id;
                        string group_data = context.Database.SqlQuery<string>(sql).FirstOrDefault();

                        JObject obj = JObject.Parse(group_data);
                        JArray array = (JArray)obj["members"];
                        int bp;
                        for (int i = 0; i < array.Count; i++)
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
            else
            { // one to one case
                bp_ids.Add(recipient_id);
                flage = 0;

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
                    //AD 210429 added else if insteadof else
                    else if (messageDict.ContainsKey(senderBpId) == false)
                    {
                        messageDict.Add(senderBpId, message);
                    }
                    pendingMessageDict[receiverBpId] = messageDict;

                }
                else
                {
                    //AD 210429 added if
                    if (messageDict.ContainsKey(senderBpId) == false)
                    {
                        messageDict.Add(senderBpId, message);
                    }
                    //AD 210429 added if
                    if (pendingMessageDict.ContainsKey(receiverBpId) == false)
                    {
                        pendingMessageDict.Add(receiverBpId, messageDict);
                    }
                }

                try
                {
                    if (connectionsDict != null && connectionsDict.Count > 0 && connectionsDict.ContainsKey(receiverBpId.ToString()) == true)
                    {

                        string[] activeConnIds = (string[])connectionsDict[receiverBpId.ToString()].connectionsList.ToArray(typeof(string));

                        /*Clients.Clients(activeConnIds).notifyMessage(name, message, senderBpId);
                        var senderConnId = Context.ConnectionId;
                        Clients.Client(senderConnId).notifyMessage(name, message, senderBpId);*/
                        // 210430 RJ calling notifyMessage for group and one to one
                        if (flage == 0) // one to one chat
                        {
                            Clients.Clients(activeConnIds).notifyMessage(name, message, senderBpId, senderBpId);
                            var senderConnId = Context.ConnectionId;
                            Clients.Client(senderConnId).notifyMessage(name, message, senderBpId, senderBpId);
                        }

                        else // group chat
                        {
                            Clients.Clients(activeConnIds).notifyMessage(name, message, dc_id, senderBpId);
                            var senderConnId = Context.ConnectionId;
                            Clients.Client(senderConnId).notifyMessage(name, message, dc_id, senderBpId);
                        }
                        Clients.Clients(activeConnIds).popMessageCall(name, message);
                    }

                }
                catch(Exception ex) {
                }
            }


            if (flage == 0)// one to one
            {
                saveChatHistory(senderBpId, recipient_id, message);
            }
            // todo: else {group chat save}

        }