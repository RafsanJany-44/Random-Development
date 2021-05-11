select msg.chat_group_member_add('{"org_id": "2","dc_id": "14686","members":[{"bp_id":"465086","role_code":"$CGPART"}]}')


select msg.chat_group_member_add('{"org_id": "2", "dc_id": "14686", "bp_id": "465086", "role_code": "$CGPART"}]');



select msg.chat_group_add('{"org_id": "2","dc_name":"for test","discussion_class": "PUBLIC_GROUP","members":[{"bp_id":"465074","role_code":"$CGPART"},{"bp_id":"465075","role_code":"$CGPART"},{"bp_id":"465086","role_code":"$CGPART"}]}');



select msg.chat_group_member_add('[{"org_id": "2", "dc_id": "14686", "bp_id": "465074", "role_code": "$CGPART"}]')


select msg.chat_group_add('{"org_id": "2","dc_name":"for test","discussion_class": "PUBLIC_GROUP","members":[{"bp_id":"465074","role_code":"$CGPART"},{"bp_id":"465075","role_code":"$CGPART"},{"bp_id":"465086","role_code":"$CGPART"}]}');


select msg.chat_group_add('{"org_id": "2","dc_name":"for test 2","discussion_class": "PUBLIC_GROUP","members":[{"bp_id":"465074","role_code":"$CGPART"},{"bp_id":"465075","role_code":"$CGPART"},{"bp_id":"465086","role_code":"$CGPART"}]}');


select  msg.chat_group_delete('{"org_id":"2","dc_id":"14690"}');

select msg.chat_group_member_data('{"org_id":"2","dc_id":"14686"}');