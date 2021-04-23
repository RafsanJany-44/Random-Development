        public string GetGroups(string bp_id, int? pt_id)
        {
          
            string result = "";
            using (var context = new EventEntities())
                {
                    try
                    {

                        string sql = "select msg.chat_groups(org_id," + pt_id + ")from public.business_partner where bp_id="+bp_id;
                        if (pt_id == null)
                        {
                            sql = "select msg.chat_groups(org_id,null)from public.business_partner where bp_id=" + bp_id;
                        }
                        result = context.Database.SqlQuery<string>(sql).FirstOrDefault();

                        return result;
                    }
                    catch (Exception ex)
                    {
                        string err = ex.Message;
                    }
                
            }

            return result;
        }