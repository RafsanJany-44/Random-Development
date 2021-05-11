 public void iwc_initialize(string connId, string bp_id)
        {
            Clients.Client(connId).notifyConnection();

        
            var filteredBpList = filterOnlineUser(bp_id); //gettin all online users
            var results = connectionsDict.Where(x => filteredBpList.Contains(x.Key)).Select(x => x).ToDictionary(p => p.Key, p => p.Value);
          
            Dictionary<string, HubUser> PermittedOnlineUser = new Dictionary<string, HubUser>(results);

            var contactList = GetContactList(bp_id);

            Dictionary<string, HubUser> hubUserList = contactList.Select(x =>
            new
            {
                id = x.bp_id.ToString(),
                hubuser =
                new HubUser
                {
                    bpId = x.bp_id.ToString(),
                    contactStatus = "contact-offline",
                    displayName = x.bp_name,
                    userName = x.username
                }
            }).ToDictionary(x => x.id, x => x.hubuser);

            PermittedOnlineUser.Where(x => !hubUserList.Keys.Contains(x.Key)).
               ToList().
               ForEach(x => hubUserList.Add(x.Key, x.Value));

            Dictionary<string, HubUser> hubUserList2 = new Dictionary<string, HubUser>(hubUserList);
            foreach (var item in hubUserList2)
            {
                if (PermittedOnlineUser.Keys.Contains(item.Key))
                {
                    
                    if (string.IsNullOrEmpty(item.Value.contactStatus) || !contactList.Exists(x => x.bp_id == Int32.Parse(item.Value.bpId)))
                        hubUserList[item.Key].contactStatus = "online";
                    else
                        hubUserList[item.Key].contactStatus = "contact-online";
                }

            }
            Clients.Client(connId).getAllUsers(hubUserList);
        }







string json = @"{""key1"":""value1"",""key2"":""value2""}";

var values = JsonConvert.DeserializeObject<Dictionary<string, string>>(json);