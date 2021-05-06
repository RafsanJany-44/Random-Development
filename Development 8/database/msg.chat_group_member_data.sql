CREATE OR REPLACE FUNCTION msg.chat_group_member_data(p_json text)
 RETURNS json
 LANGUAGE plpgsql
AS $function$

declare

	v_json JSON := p_json;
    v_discussion_class VARCHAR;
   	v_dc_name VARCHAR;
   	v_dc_id NUMERIC:=v_json::json->>'dc_id';
  	v_org_id NUMERIC := v_json::json->>'org_id';
  	v_bp_id NUMERIC;
  	v_role_code VARCHAR; 
 	temp1_json JSON;
 	temp2_json JSON:='[]';
 	final_json JSON;
 	
 
 cursor1 CURSOR FOR 
		SELECT bp_id ,role_code
		FROM  public.discussion_category_members
		WHERE dc_id = v_dc_id;


BEGIN 
 	
	SELECT dc_name,discussion_class INTO  v_dc_name,v_discussion_class
    FROM public.discussion_category 
    WHERE org_id=v_org_id
    AND dc_id=v_dc_id;

OPEN cursor1;
			LOOP
				FETCH FROM cursor1 INTO v_bp_id,v_role_code;
				EXIT WHEN NOT FOUND;
				temp1_json= json_build_object('bp_id', v_bp_id,'role_code',v_role_code);
				temp2_json= temp2_json::jsonb || temp1_json::jsonb;
				
			END LOOP;
		CLOSE cursor1;
	final_json=json_build_object('org_id',v_org_id, 'dc_id',v_dc_id, 'dc_name',v_dc_name, 'dc_class',v_discussion_class,'members',temp2_json);
	
	--raise notice 'Value: %',final_json;
 	  RETURN final_json;
END;

$function$
;