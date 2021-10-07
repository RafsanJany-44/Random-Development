        //20210323 RJ removing group members
[Authorize]
        public JsonResult DeleteGroup(string query)
        {
            UserSessionInfo user_info = AuthorizationLogic.GetLogedInUserDataFromSession();
            string result = "";
            if (user_info != null)
            {
                using (var context = new EventEntities())
               {
                   try
                  {
                    string sql = "select msg.chat_group_delete('" + query + "')";
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