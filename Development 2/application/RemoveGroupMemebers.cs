 [Authorize]
        public JsonResult RemoveGroupMemebers(string query)
        {
            UserSessionInfo user_info = AuthorizationLogic.GetLogedInUserDataFromSession();

            string result = "";
            if (user_info != null)
            {
                using (var context = new EventEntities())
                {
                    try
                    {
                        string sql = "select msg.chat_group_member_delete('" + query + "')";

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