
select msg.chat_group_add('{"org_id":"2","dc_name":"rj application test3","discussion_class":"PUBLIC_GROUP","members":[{"bp_id":"465075","role_code":"$CGOWNER"},{"bp_id":"3","role_code":"$CGPART"},{"bp_id":"4","role_code":"$CGPART"},{"bp_id":"5","role_code":"$CGPART"},{"bp_id":"6","role_code":"$CGPART"}]}')


select * from public.discussion_category dc where dc_id=14674--dc_name='rj factory ajax test2'


select * from public.discussion_category dc2 where discussion_class ='PUBLIC_GROUP';



select msg.chat_group_member_add('[{"org_id":"2","dc_id":"14674","bp_id":"15","role_code":"$CGPART"},{"org_id":"2","dc_id":"14674","bp_id":"16","role_code":"$CGPART"},{"org_id":"2","dc_id":"14674","bp_id":"17","role_code":"$CGPART"},{"org_id":"2","dc_id":"14674","bp_id":"18","role_code":"$CGPART"}]')



select  * from public.discussion_category_members dcm  where dc_id=14676;




DELETE FROM public.discussion_category_members dcm WHERE ;




SELECT msg.chat_group_member_delete('{"org_id":"2","dc_id":"14674","members":[{"bp_id":"13"},{"bp_id":"14"},{"bp_id":"15"}]}')




SELECT  msg.chat_group_delete('{"org_id":"2","dc_id":"14672"}');



SELECT msg.chat_group_name_update('{"org_id":"2","dc_id":"14674","dc_name":"rj ajax test"}')



select msg.chat_save(2,14684,'hello test 2 from data base',14684)


select msg.chat_history(2, 14684)
-------------------------------------------------------------------------------------------