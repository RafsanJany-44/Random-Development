CREATE OR REPLACE
FUNCTION msg.chat_group_delete() 
RETURNS JSON
LANGUAGE plpgsql 
AS $function$
DECLARE
	v_org_id numeric:= p_json::JSON->>'org_id';
    v_dc_id numeric:= p_json::JSON->>'dc_id';
	v_topic_id numeric;
	return_json JSON;

	cursor1 CURSOR FOR 
		SELECT topic_id 
		FROM  public.disscussion_topic
		WHERE org_id=v_org_id AND dc_id = v_dc_id;

BEGIN 
	
	OPEN cursor1;
			LOOP
				FETCH FROM cursor1 INTO v_topic_id;
					EXIT WHEN NOT FOUND;
					DELETE
					FROM
						public.discussion_topic_bp_action
					WHERE
						org_id = v_org_id
						AND topic_id = v_topic_id;
					
			END LOOP;
		CLOSE cursor1;

	DELETE
	FROM
		public.discussion_topic
	WHERE
		org_id = v_org_id
		AND dc_id = v_dc_id;

	DELETE
	FROM
		public.discussion_category
	WHERE
		org_id = v_org_id
		AND dc_id = v_dc_id;
	
	DELETE
	FROM
		public.discussion_category_members
	WHERE
		org_id = v_org_id
		AND dc_id = v_dc_id;
	
	return_json= json_build_object('json_code','1','Message', 'success' ,'topic_id',v_topic_id );
	
	RETURN return_json;
END;

$function$