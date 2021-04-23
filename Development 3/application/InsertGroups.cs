//20210323 RJ insert a group details into database
        [Authorize]
        public JsonResult InsertGroups(string query)
        {
            UserSessionInfo user_info = AuthorizationLogic.GetLogedInUserDataFromSession();
            
            string result = "";
            if (user_info != null)
            {
                using (var context = new EventEntities())
                {
                    try
                    {
                    string sql= "select msg.chat_group_add('"+ query +"')";
                    
                    result = context.Database.SqlQuery<string>(sql).FirstOrDefault();
                   
                    return Json(result);
                      }
                       catch (Exception ex)
                      {
                          string err = ex.Message;
                     }
                }
            }

            return Json("{\"Code\" : \"-1\"}");
        }