CREATE OR REPLACE FUNCTION msg.getgroup_bp_ids (p_dc_id numeric)
 RETURNS numeric[]
 LANGUAGE plpgsql
AS $function$
DECLARE

	v_bp_ids NUMERIC []:=array[]::numeric[];
	v_bp_id NUMERIC;
cursor1 CURSOR FOR 
		SELECT bp_id 
		FROM  public.discussion_category_members
		WHERE dc_id = p_dc_id;

BEGIN 
		OPEN cursor1;
			LOOP
				FETCH FROM cursor1 INTO v_bp_id;
				EXIT WHEN NOT FOUND;
				v_bp_ids := v_bp_ids || v_bp_id;
			END LOOP;
		CLOSE cursor1;
--RAISE NOTICE 'value: %',v_bp_ids;
return v_bp_ids;
END;
$function$
;



msg.chat_group_bp_ids(dc_id)
-> take the dc_id of a group
-> select all bp_ids from  discussion_category members 
-> return an array of all bp_ids of that group