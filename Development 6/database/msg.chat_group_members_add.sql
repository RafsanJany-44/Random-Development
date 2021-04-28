create or replace
function msg.chat_group_member_add(p_json json) 
returns json
language plpgsql as 
$function$
declare
return_json json;
begin
		insert
			into
			public.discussion_category_members
		select
			*
		from
			json_populate_recordset( null::public.discussion_category_members , p_json );
		
		return_json= json_build_object('code', 1);
		return return_json;
end;

$function$;





create or replace
function msg.chat_group_member_add(p_json text) 
returns json
language plpgsql as 
$function$
declare
	v_json json:= p_json;
	return_json json;
begin
		insert
			into
			public.discussion_category_members
		select
			*
		from
			json_populate_recordset( null::public.discussion_category_members , v_json );
		return_json= json_build_object('code', 1);
		return return_json;

end;

$function$;


--select msg.chat_group_member_add('[{"org_id": "2", "dc_id": "890", "bp_id": "20", "role_code": "$CGPART"},
   --                      {"org_id": "2", "dc_id": "890", "bp_id": "21", "role_code": "$CGPART"},
      --              {"org_id": "2", "dc_id": "890", "bp_id": "22", "role_code": "$CGPART"}]');




-----------------------------------------------------------------------------------------------------------------------------------------------------

select msg.chat_group_member_add('[{"org_id": "2", "dc_id": "14686", "bp_id": "465074", "role_code": "$CGPART"}]')









