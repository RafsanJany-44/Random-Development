--20210325
CREATE OR REPLACE
FUNCTION msg.chat_group_delete(p_json TEXT)
RETURNS JSON
LANGUAGE plpgsql 
AS $FUNCTION$
DECLARE
	 v_json JSON := p_json;
	 v_org_id NUMERIC;
	 v_dc_id NUMERIC;
	 return_json JSON;

BEGIN 
	v_org_id = v_json::JSON->>'org_id';

	v_dc_id = v_json::JSON->>'dc_id';
	
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
	return_json= JSON_BUILD_OBJECT('code', 1);
	RETURN return_json;
END;

$FUNCTION$






create or replace
function msg.chat_group_delete(p_json json) returns void language plpgsql as $function$
declare
	v_org_id numeric;

v_dc_id numeric;

begin v_org_id = p_json::json->>'org_id';

v_dc_id = p_json::json->>'dc_id';

delete
from
	public.discussion_category
where
	org_id = v_org_id
	and dc_id = v_dc_id;

delete
from
	public.discussion_category_members
where
	org_id = v_org_id
	and dc_id = v_dc_id;



end;

$function$

--select  msg.chat_group_delete('{"org_id":"2","dc_id":"14651"}');







CREATE OR REPLACE
FUNCTION msg.chat_group_delete(p_json JSON) 
RETURNS VOID
LANGUAGE plpgsql 
AS $function$
DECLARE
	v_org_id numeric;

    v_dc_id numeric;

BEGIN 
	v_org_id = p_json::JSON->>'org_id';

	v_dc_id = p_json::JSON->>'dc_id';

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
END;

$function$









group_delete proposal algorithm:

1. fetcth every topic_id from disscussion_topic and delete that topic_id from discussion_topic_bp_action
2. delete from disscussion_topic where org_id= and dc_id=
3.delete from discussion_category where org_id= and dc_id=
4.delete from discussion_category_members where org_id= and dc_id= 






CREATE OR REPLACE
FUNCTION msg.chat_group_delete(p_json JSON) 
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
		FROM  public.discussion_topic
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
















CREATE OR REPLACE
FUNCTION msg.chat_group_delete(p_json JSON) 
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
		FROM  public.discussion_topic
		WHERE org_id=v_org_id AND dc_id = v_dc_id;

BEGIN 
	
	OPEN cursor1;
			LOOP
				FETCH FROM cursor1 INTO v_topic_id;
					EXIT WHEN NOT FOUND;
					raise notice 'Value: %', v_topic_id;
					
			END LOOP;
		CLOSE cursor1;

	
	
	return_json= json_build_object('json_code','1','Message', 'success' ,'topic_id',v_topic_id );
	
	RETURN return_json;
END;

$function$















CREATE OR REPLACE
FUNCTION msg.chat_group_delete(p_json JSON) 
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
		FROM  public.discussion_topic
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