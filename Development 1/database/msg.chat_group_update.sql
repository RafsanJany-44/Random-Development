CREATE OR REPLACE FUNCTION msg.chat_group_name_update(p_json TEXT)
 RETURNS JSON
 LANGUAGE plpgsql
AS $function$
DECLARE
	
	v_json JSON:= p_json;
	v_org_id NUMERIC;
	v_dc_id NUMERIC;
	v_dc_name VARCHAR;
	return_json 	JSON;

BEGIN 
	v_org_id = v_json::JSON->>'org_id';

	v_dc_id = v_json::JSON->>'dc_id';

	v_dc_name = v_json::JSON->>'dc_name';
	UPDATE
		public.discussion_category
	SET
		dc_name = v_dc_name
	WHERE
			org_id = v_org_id
	AND dc_id = v_dc_id;
	return_json= JSON_BUILD_OBJECT('code', 1);
	RETURN return_json;
END;

$function$
;












CREATE OR REPLACE FUNCTION msg.chat_group_update(p_json json)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE

	v_org_id numeric;

	v_dc_id numeric;

	v_dc_name varchar;

begin 
	v_org_id = p_json::json->>'org_id';

	v_dc_id = p_json::json->>'dc_id';

	v_dc_name = p_json::json->>'dc_name';
	update
		public.discussion_category
	set
		dc_name = v_dc_name
	where
			org_id = v_org_id
	and dc_id = v_dc_id;
end;

$function$
;
