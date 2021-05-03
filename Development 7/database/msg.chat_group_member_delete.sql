--20210326
CREATE OR REPLACE FUNCTION msg.chat_group_member_delete(p_json TEXT)
RETURNS JSON
LANGUAGE plpgsql 
AS $FUNCTION$
DECLARE

    v_json JSON := p_json;
	v_org_id NUMERIC;
	v_dc_id NUMERIC;
	v_bp_id NUMERIC;
	v_members_json JSON;
	v_len NUMERIC;
	v_bp_json JSON;
    return_json JSON;

BEGIN 
	
	v_org_id = v_json::JSON->>'org_id';
	
	v_dc_id = v_json::JSON->>'dc_id';
	
	v_members_json = v_json::JSON->>'members';
	
	v_len = JSON_ARRAY_LENGTH(v_members_json)-1;

	FOR i IN 0.. v_len LOOP
	v_bp_json = v_members_json->i;
	v_bp_id=v_bp_json::json->>'bp_id';
	
	
		DELETE
		FROM
			public.discussion_category_members
		WHERE
			org_id = v_org_id
			AND dc_id = v_dc_id
			AND bp_id=v_bp_id;
	 END LOOP;
	 return_json= JSON_BUILD_OBJECT('code', 1);
	RETURN return_json;
END;

$FUNCTION$











create or replace function msg.chat_group_member_delete(p_json json)
returns void 
language plpgsql 
as $function$
declare
	v_org_id numeric;

	v_dc_id numeric;
	
	v_bp_id numeric;
	
	v_members_json json;
	
	v_len numeric;
	v_bp_json json;

begin 
	
	v_org_id = p_json::json->>'org_id';
	
	v_dc_id = p_json::json->>'dc_id';
	
	v_members_json = p_json::json->>'members';
	
	v_len = json_array_length(v_members_json)-1;

	for i in 0.. v_len loop
	v_bp_json = v_members_json->i;
	v_bp_id=v_bp_json::json->>'bp_id';
	
	
	DELETE
	FROM
		public.discussion_category_members
	WHERE
		org_id = v_org_id
		AND dc_id = v_dc_id
		AND bp_id=v_bp_id;
	
	end loop;
end;

$function$





--select * from public.discussion_category_members
--SELECT msg.chat_group_member_delete('{"org_id":"2","dc_id":"14650","members":[{"bp_id":"7"},{"bp_id":"8"}]}')


