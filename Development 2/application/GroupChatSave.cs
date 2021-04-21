//20210401 RJ Group Chat is saved in data base
[Authorize]
        public JsonResult GroupChatSave(int org_id, int dc_id, string msg, int recipient_id, int sender_id)
        {
            UserSessionInfo user_info = AuthorizationLogic.GetLogedInUserDataFromSession();

            string result = "";
            if (user_info != null)
            {
                using (var context = new EventEntities())
                {
                    try
                    {
                    string sql = "select msg.chat_save("+ org_id + "," + dc_id + ",\'" + msg + "\'," + recipient_id +","+ sender_id + ")";
                   
                    result = context.Database.SqlQuery<string>(sql).FirstOrDefault();

                        return Json(result);
                    }
                    catch (Exception ex)
                    {
                      string err = ex.Message;
                    }
                }
            }

            return Json("{\"Code\" : -1}");
        }


