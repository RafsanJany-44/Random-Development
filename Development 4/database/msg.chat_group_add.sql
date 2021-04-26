--20210325
create or replace
function msg.chat_group_add(p_json text)
returns json
language plpgsql as 
$function$
declare
	v_json JSON := p_json;
	v_dc_id numeric;
	v_org_id numeric;
	v_dc_name varchar;
	v_discussion_class varchar;
	v_members_json json;
	v_len_json numeric;
	temp_json json;
	temp1_json json;
	temp3_json json;
	temp4_json json;
	return_json json;
begin

	 insert
		into
		public.discussion_category(org_id, dc_name, discussion_class)
	select
		org_id,
		dc_name ,
		discussion_class
	from
		json_populate_record(null::public.discussion_category , v_json);
	
	v_org_id = v_json::json->>'org_id';
	
	v_dc_name = v_json::json->>'dc_name';
	
	v_discussion_class = v_json::json->>'discussion_class';
	
	v_members_json=v_json::json->>'members';
	
	
	
	select
		max(dc_id)
	from
		public.discussion_category
	into
		v_dc_id
	where
		discussion_class = v_discussion_class 
		and dc_name = v_dc_name
		and org_id = v_org_id;
	
	v_len_json=json_array_length(v_members_json)-1;
	temp4_json='[]';
	
	for i in 0..v_len_json loop
	
		temp_json=v_members_json::json->i;
		temp1_json= json_build_object('dc_id', v_dc_id,'org_id', v_org_id);
		temp3_json=temp1_json::jsonb||temp_json::jsonb;
		temp4_json= temp4_json::jsonb || temp3_json::jsonb;
	
	end loop;
	perform msg.chat_group_member_add(temp4_json);
	return_json= json_build_object('code', 1);
	return return_json;
end;

$function$;












create or replace
function msg.chat_group_add(p_json text)
returns void
language plpgsql as 
$function$
declare
	v_json JSON := p_json;
	v_dc_id numeric;
	v_org_id numeric;
	v_dc_name varchar;
	v_discussion_class varchar;
	v_members_json json;
	v_len_json numeric;
	temp_json json;
	temp1_json json;
	temp3_json json;
	temp4_json json;

begin

	 insert
		into
		public.discussion_category(org_id, dc_name, discussion_class)
	select
		org_id,
		dc_name ,
		discussion_class
	from
		json_populate_record(null::public.discussion_category , v_json);
	
	v_org_id = v_json::json->>'org_id';
	
	v_dc_name = v_json::json->>'dc_name';
	
	v_discussion_class = v_json::json->>'discussion_class';
	
	v_members_json=v_json::json->>'members';
	
	
	
	select
		max(dc_id)
	from
		public.discussion_category
	into
		v_dc_id
	where
		discussion_class = v_discussion_class 
		and dc_name = v_dc_name
		and org_id = v_org_id;
	
	v_len_json=json_array_length(v_members_json)-1;
	temp4_json='[]';
	
	for i in 0..v_len_json loop
	
		temp_json=v_members_json::json->i;
		temp1_json= json_build_object('dc_id', v_dc_id,'org_id', v_org_id);
		temp3_json=temp1_json::jsonb||temp_json::jsonb;
	raise notice 'Value: %', temp3_json;
		temp4_json= temp4_json::jsonb || temp3_json::jsonb;
	
	end loop;
	perform msg.chat_group_member_add(temp4_json);
	--raise notice 'Value: %', temp4_json;
end;

$function$;









select msg.chat_group_add('{"org_id": "2","dc_name":"rj test 18","discussion_class": "PUBLIC_GROUP","members":[{"bp_id":"7","role_code":"$CGPART"},{"bp_id":"8","role_code":"$CGPART"},{"bp_id":"9","role_code":"$CGPART"}]}');










CREATE OR REPLACE FUNCTION msg.chat_group_add(p_json json)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
declare
	v_dc_id numeric;
	v_org_id numeric;
	v_dc_name varchar;
	v_discussion_class varchar;
	v_json json;
	v_members_json json;
	v_len_json numeric;
	temp_json json;
	temp1_json json;
	temp3_json json;
	temp4_json json;

begin

	 insert
		into
		public.discussion_category(org_id, dc_name, discussion_class)
	select
		org_id,
		dc_name ,
		discussion_class
	from
		json_populate_record(null::public.discussion_category , p_json);
	
	v_org_id = p_json::json->>'org_id';
	
	v_dc_name = p_json::json->>'dc_name';
	
	v_discussion_class = p_json::json->>'discussion_class';
	
	v_members_json=p_json::json->>'members';
	
	
	
	select
		max(dc_id)
	from
		public.discussion_category
	into
		v_dc_id
	where
		discussion_class = v_discussion_class 
		and dc_name = v_dc_name
		and org_id = v_org_id;
	
	v_len_json=json_array_length(v_members_json)-1;
	temp4_json='[]';
	
	for i in 0..v_len_json loop
	
		temp_json=v_members_json::json->i;
		temp1_json= json_build_object('dc_id', v_dc_id,'org_id', v_org_id);
		temp3_json=temp1_json::jsonb||temp_json::jsonb;
	raise notice 'Value: %', temp3_json;
		temp4_json= temp4_json::jsonb || temp3_json::jsonb;
	
	end loop;
	perform msg.chat_group_member_add(temp4_json);
	--raise notice 'Value: %', temp4_json;
end;

$function$
;







