//20210426 RJ removing a single message
        [Authorize]
        public JsonResult SingleMsgRemove(int org_id, int dc_id, int topic_id, int type, int? user_bp_id)
        {
            UserSessionInfo user_info = AuthorizationLogic.GetLogedInUserDataFromSession();


            string result = "";
            if (user_info != null)
            {
                using (var context = new EventEntities())
                {
                    try
                    {
                        string sql = "select msg.chat_single_msg_remove(" + org_id + "," + dc_id + "," + topic_id + "," + type + "," + user_bp_id + ")";

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
