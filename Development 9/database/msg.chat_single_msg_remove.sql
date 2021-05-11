select msg.chat_single_msg_remove(2,14686,82796,1) ---woeking


CREATE OR REPLACE
FUNCTION msg.chat_single_msg_remove(p_org_id numeric , p_dc_id numeric, p_topic_id numeric,p_type numeric,p_user_bp_id numeric DEFAULT NULL::numeric) 
RETURNS JSON
LANGUAGE plpgsql 
AS $function$
DECLARE
	
	return_json JSON;

BEGIN 
	
	IF p_user_bp_id IS NULL THEN 
 		p_user_bp_id= (SELECT user_id FROM public.v_current_user);
 	END IF;
	
	IF p_type=1 THEN
	
	DELETE FROM public.discussion_topic_bp_action 
	WHERE org_id=p_org_id 
	AND topic_id=p_topic_id;

	DELETE FROM public.discussion_topic 
	WHERE org_id=p_org_id 
	AND dc_id=p_dc_id  
	AND topic_id=p_topic_id;


	ELSE

	DELETE FROM public.discussion_topic_bp_action 
	WHERE org_id=p_org_id 
	AND topic_id=p_topic_id
	AND bp_id=p_user_bp_id;

	END IF;

	
	return_json= json_build_object('json_code','1','Message', 'success' ,'topic_id',p_topic_id );
	
	RETURN return_json;
	END;

$function$;



select msg.chat_single_msg_remove(2,14686,82783,0,465075)