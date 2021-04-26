CREATE OR REPLACE FUNCTION msg.chat_save(p_org_id numeric, p_dc_id numeric, p_msg_text text, p_recipient_id numeric, p_pt_id numeric DEFAULT NULL::numeric)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_user_id NUMERIC;
	v_discussion_class VARCHAR;
	v_bp_id NUMERIC;
	v_topic_id NUMERIC;

	temp_json JSON;
	
	cursor1 CURSOR FOR 
		SELECT bp_id 
		FROM  public.discussion_category_members
		WHERE dc_id = p_dc_id;

BEGIN 
	
	v_user_id= (SELECT user_id FROM public.v_current_user);
	
	--raise notice 'user id: %',v_user_id;

	INSERT INTO  discussion_topic(org_id, bp_id, pt_id, dc_id, topic_title, topic_details, access_roles, discussion_class)
	VALUES(p_org_id, v_user_id, p_pt_id, p_dc_id, 'TEXT CHAT', p_msg_text, '%', 'NOTIFICATION');
	

		
	SELECT discussion_class INTO v_discussion_class 
	FROM public.discussion_category  
	WHERE dc_id=p_dc_id;

	SELECT max(topic_id) INTO v_topic_id
	FROM public.discussion_topic 
	WHERE dc_id=p_dc_id;
	
	
	IF v_discussion_class = 'PUBLIC_GROUP' OR v_discussion_class='PRIVATE_GROUP' THEN 
		-- raise notice 'yse yes yes';

		OPEN cursor1;
			LOOP
				FETCH FROM cursor1 INTO v_bp_id;
					EXIT WHEN NOT FOUND;
				--	RAISE NOTICE 'value: %',v_bp_id;
					INSERT INTO public.discussion_topic_bp_action(org_id, topic_id, bp_id)
					VALUES (p_org_id, v_topic_id, v_bp_id);
				
			END LOOP;
		CLOSE cursor1;
		temp_json= json_build_object('json_code','1','Message', 'success' ,'topic_id',v_topic_id );
		return temp_json; 
	
	
	ELSE
	
		temp_json= json_build_object('json_code','-1','Message', 'error' ,'topic_id',v_topic_id);
		RETURN temp_json;
	--raise notice 'no no';
	
END IF ;

END;
$function$
;





select msg.chat_save(2,14647,'hello test 1',1213)













CREATE OR REPLACE FUNCTION msg.chat_save(p_org_id numeric, p_dc_id numeric, p_msg_text text, p_recipient_id numeric,p_sender_id numeric DEFAULT NULL::numeric ,p_pt_id numeric DEFAULT NULL::numeric)
 RETURNS JSON
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_user_id NUMERIC;
	v_discussion_class VARCHAR;
	v_bp_id NUMERIC;
	v_topic_id NUMERIC;

	temp_json JSON;
	
	cursor1 CURSOR FOR 
		SELECT bp_id 
		FROM  public.discussion_category_members
		WHERE dc_id = p_dc_id;

BEGIN 

	v_user_id= p_sender_bp_id;
	
	
	raise notice 'user id: %',v_user_id;

	INSERT INTO  discussion_topic(org_id, bp_id, pt_id, dc_id, topic_title, topic_details, access_roles, discussion_class)
	VALUES(p_org_id, v_user_id, p_pt_id, p_dc_id, 'TEXT CHAT', p_msg_text, '%', 'NOTIFICATION');
	

		
	SELECT discussion_class INTO v_discussion_class 
	FROM public.discussion_category  
	WHERE dc_id=p_dc_id;

	SELECT max(topic_id) INTO v_topic_id
	FROM public.discussion_topic 
	WHERE dc_id=p_dc_id;
	
	
	IF v_discussion_class = 'PUBLIC_GROUP' OR v_discussion_class='PRIVATE_GROUP' THEN 
		-- raise notice 'yse yes yes';

		OPEN cursor1;
			LOOP
				FETCH FROM cursor1 INTO v_bp_id;
					EXIT WHEN NOT FOUND;
					RAISE NOTICE 'value: %',v_bp_id;
					INSERT INTO public.discussion_topic_bp_action(org_id, topic_id, bp_id)
					VALUES (p_org_id, v_topic_id, v_bp_id);
				
			END LOOP;
		CLOSE cursor1;
		temp_json= json_build_object('json_code','1','Message', 'success' ,'topic_id',v_topic_id );
		return temp_json; 
	
	
	ELSE
	
		temp_json= json_build_object('json_code','-1','Message', 'error' ,'topic_id',v_topic_id);
		RETURN temp_json;
	--raise notice 'no no';
	
END IF ;

END;
$function$
;



















CREATE OR REPLACE FUNCTION msg.chat_save(p_org_id numeric, p_dc_id numeric, p_msg_text text, p_recipient_id numeric,p_sender_bp_id numeric DEFAULT NULL::numeric ,p_pt_id numeric DEFAULT NULL::numeric)
 RETURNS JSON
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_user_id NUMERIC;
	v_discussion_class VARCHAR;
	v_bp_id NUMERIC;
	v_topic_id NUMERIC;

	temp_json JSON;
	
	cursor1 CURSOR FOR 
		SELECT bp_id 
		FROM  public.discussion_category_members
		WHERE dc_id = p_dc_id;

BEGIN 

	v_user_id= p_sender_bp_id;

	INSERT INTO  discussion_topic(org_id, bp_id, pt_id, dc_id, topic_title, topic_details, access_roles, discussion_class)
	VALUES(p_org_id, v_user_id, p_pt_id, p_dc_id, 'TEXT CHAT', p_msg_text, '%', 'NOTIFICATION');
	
	SELECT discussion_class INTO v_discussion_class 
	FROM public.discussion_category  
	WHERE dc_id=p_dc_id;

	SELECT max(topic_id) INTO v_topic_id
	FROM public.discussion_topic 
	WHERE dc_id=p_dc_id;
	
	IF v_discussion_class = 'PUBLIC_GROUP' OR v_discussion_class='PRIVATE_GROUP' THEN 
		
		OPEN cursor1;
			LOOP
				FETCH FROM cursor1 INTO v_bp_id;
					EXIT WHEN NOT FOUND;
					RAISE NOTICE 'value: %',v_bp_id;
					INSERT INTO public.discussion_topic_bp_action(org_id, topic_id, bp_id)
					VALUES (p_org_id, v_topic_id, v_bp_id);
				
			END LOOP;
		CLOSE cursor1;
		temp_json= json_build_object('json_code','1','Message', 'success' ,'topic_id',v_topic_id );
		return temp_json; 
	
	ELSE
	
		temp_json= json_build_object('json_code','-1','Message', 'error' ,'topic_id',v_topic_id);
		RETURN temp_json;
	
END IF ;

END;
$function$
;











CREATE OR REPLACE FUNCTION msg.chat_save(p_org_id numeric, p_dc_id numeric, p_msg_text text, p_recipient_id numeric, p_sender_bp_id numeric DEFAULT NULL::numeric, p_pt_id numeric DEFAULT NULL::numeric)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_user_id NUMERIC;
	v_discussion_class VARCHAR;
	v_bp_id NUMERIC;
	v_topic_id NUMERIC;

	temp_json JSON;
	
	cursor1 CURSOR FOR 
		SELECT bp_id 
		FROM  public.discussion_category_members
		WHERE dc_id = p_dc_id;

BEGIN 

	v_user_id= p_sender_bp_id;

	INSERT INTO  discussion_topic(org_id, bp_id, pt_id, dc_id, topic_title, topic_details, access_roles, discussion_class)
	VALUES(p_org_id, v_user_id, p_pt_id, p_dc_id, 'TEXT CHAT', p_msg_text, '%', 'NOTIFICATION') returning topic_id into v_topic_id;
	
	SELECT discussion_class INTO v_discussion_class 
	FROM public.discussion_category  
	WHERE dc_id=p_dc_id;

	
IF v_discussion_class = 'PUBLIC_GROUP' OR v_discussion_class='PRIVATE_GROUP' THEN 
		RAISE NOTICE 'value: %',v_discussion_class;
		OPEN cursor1;
			LOOP
				FETCH FROM cursor1 INTO v_bp_id;
					EXIT WHEN NOT FOUND;
					--RAISE NOTICE 'value: %',v_bp_id;
					--RAISE NOTICE 'topic: %',v_topic_id;			
				INSERT INTO public.discussion_topic_bp_action(org_id, topic_id, bp_id)
				SELECT p_org_id, v_topic_id, v_bp_id
			   WHERE NOT EXISTS (SELECT topic_id FROM  public.discussion_topic_bp_action  WHERE org_id = p_org_id and topic_id=v_topic_id and bp_id=v_bp_id);
			
			END LOOP;
		CLOSE cursor1;
		temp_json= json_build_object('json_code','1','Message', 'success' ,'topic_id',v_topic_id );
		return temp_json; 
	
	ELSE
	
		temp_json= json_build_object('json_code','-1','Message', 'error' ,'topic_id',v_topic_id);
		RETURN temp_json;
	
END IF ;

END;
$function$
;








CREATE OR REPLACE FUNCTION msg.chat_save(p_org_id numeric, p_dc_id numeric, p_msg_text text, p_recipient_id numeric, p_sender_bp_id numeric DEFAULT NULL::numeric, p_pt_id numeric DEFAULT NULL::numeric)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_user_id NUMERIC;
	v_discussion_class VARCHAR;
	v_bp_id NUMERIC;
	v_topic_id NUMERIC;

	temp_json JSON;
	
	cursor1 CURSOR FOR 
		SELECT bp_id 
		FROM  public.discussion_category_members
		WHERE  org_id =p_org_id AND dc_id = p_dc_id;

BEGIN 

	v_user_id= p_sender_bp_id;

	INSERT INTO  discussion_topic(org_id, bp_id, pt_id, dc_id, topic_title, topic_details, access_roles, discussion_class)
	VALUES(p_org_id, v_user_id, p_pt_id, p_dc_id, 'TEXT CHAT', p_msg_text, '%', 'NOTIFICATION') returning topic_id into v_topic_id;
	
	SELECT discussion_class INTO v_discussion_class 
	FROM public.discussion_category  
	WHERE dc_id=p_dc_id;

	
IF v_discussion_class = 'PUBLIC_GROUP' OR v_discussion_class='PRIVATE_GROUP' THEN 
		RAISE NOTICE 'value: %',v_discussion_class;
		OPEN cursor1;
			LOOP
				FETCH FROM cursor1 INTO v_bp_id;
					EXIT WHEN NOT FOUND;
					--RAISE NOTICE 'value: %',v_bp_id;
					--RAISE NOTICE 'topic: %',v_topic_id;			
				INSERT INTO public.discussion_topic_bp_action(org_id, topic_id, bp_id)
				SELECT p_org_id, v_topic_id, v_bp_id
			   WHERE NOT EXISTS (SELECT topic_id FROM  public.discussion_topic_bp_action  WHERE org_id = p_org_id and topic_id=v_topic_id and bp_id=v_bp_id);
			
			END LOOP;
		CLOSE cursor1;
		temp_json= json_build_object('json_code','1','Message', 'success' ,'topic_id',v_topic_id );
		return temp_json; 
	
	ELSE
	
		temp_json= json_build_object('json_code','-1','Message', 'error' ,'topic_id',v_topic_id);
		RETURN temp_json;
	
END IF ;

END;
$function$
;
