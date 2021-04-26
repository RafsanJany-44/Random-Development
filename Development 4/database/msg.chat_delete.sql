CREATE OR replace
FUNCTION msg.chat_delete(p_org_id NUMERIC ,p_topic_id NUMERIC ) 
RETURNS json
LANGUAGE plpgsql
AS $function$
DECLARE
	v_org_id1 NUMERIC;
	v_topic_id1 NUMERIC;
	v_org_id2 NUMERIC;
	v_topic_id2 NUMERIC;
	temp_json JSON; 

BEGIN 
	
	SELECT org_id, topic_id 
	INTO v_org_id1, v_topic_id1
	from public.discussion_topic_bp_action 
	where org_id= p_org_id
	AND  topic_id = p_topic_id;
	
	SELECT org_id, topic_id 
	INTO v_org_id2, v_topic_id2
	from public.discussion_topic
	where org_id= p_org_id
	AND  topic_id = p_topic_id;	
	
	IF  v_org_id1 IS NULL OR  v_org_id2 IS NULL 
	   OR v_topic_id1 IS NULL OR v_topic_id2 IS NULL THEN  
	   
	  temp_json= json_build_object('json_code','-1','Message', 'error' );
	  RETURN temp_json;
	ELSE 
	  
	  DELETE
		FROM
			public.discussion_topic_bp_action 
		WHERE
			org_id = p_org_id
			AND topic_id = p_topic_id;
		
		DELETE
		FROM
			public.discussion_topic
		WHERE
			org_id = p_org_id
			AND topic_id = p_topic_id;
	  
	  	temp_json= json_build_object('json_code','1','Message', 'success' );
	  	RETURN temp_json;
	  
	 
	END IF ;

END;

$function$
