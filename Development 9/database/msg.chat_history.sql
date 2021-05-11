CREATE FUNCTION msg.chat_history(p_org_id numeric, p_dc_id numeric, p_sender_bp_id numeric DEFAULT NULL::numeric,p_pt_id numeric DEFAULT NULL::numeric)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
	v_return character varying ;
BEGIN

IF p_sender_bp_id is null then 
 	p_sender_bp_id= (select user_id from public.v_current_user);
END if;
raise notice 'p_org_id: %',p_org_id;
raise notice 'p_dc_id: %',p_dc_id;
raise notice 'p_recipient_id: %',p_recipent_bp_id;
raise notice 'sender: %',p_sender_bp_id;


select coalesce(json_agg(t)::text,'[]') into v_return 
from (
SELECT *
FROM msg.v_chat_history
where org_id = p_org_id and
		dc_id=p_dc_id and
      	sender_bp_id = p_sender_bp_id
)t;
raise notice 'return: %',v_return;
return v_return;

END;
$function$
;


select msg.chat_history(2, 14684)











--factory function
CREATE FUNCTION msg.chat_history(p_org_id numeric,p_dc_class varchar ,p_recipent_bp_id numeric, p_sender_bp_id numeric DEFAULT NULL::numeric,p_pt_id numeric DEFAULT NULL::numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
declare
	
BEGIN

IF p_dc_class=='CHAT' then 
 	--perform  msg.chat_history (org_id,pt_id, dc_id, recipient_bp_id= recipient_id);
ELSE 
      perform select msg.chat_history(p_org_id, p_recipent_bp_id,p_sender_bp_id,p_pt_id)

END if;

END;
$function$
;











CREATE OR REPLACE FUNCTION msg.chat_history(p_org_id numeric, p_dc_id numeric, p_sender_bp_id numeric DEFAULT NULL::numeric, p_pt_id numeric DEFAULT NULL::numeric)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
	v_return character varying ;
BEGIN

	IF p_sender_bp_id is null then 
	 	p_sender_bp_id= (select user_id from public.v_current_user);
	END if;
	select coalesce(json_agg(t)::text,'[]') into v_return 
	from (
	SELECT *
	FROM msg.v_chat_history
	where org_id = p_org_id and
			dc_id=p_dc_id 
	)t;

	return v_return;

END;
$function$








CREATE OR REPLACE FUNCTION msg.chat_history(p_org_id numeric, p_dc_id numeric, p_sender_bp_id numeric DEFAULT NULL::numeric, p_pt_id numeric DEFAULT NULL::numeric)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
	v_return character varying ;
BEGIN

	IF p_sender_bp_id is null then 
	 	p_sender_bp_id= (select user_id from public.v_current_user);
	END if;
	select coalesce(json_agg(t)::text,'[]') into v_return 
	from (
	SELECT *
	FROM msg.v_chat_history
	where org_id = p_org_id and
			dc_id=p_dc_id 
	
	)t;

	return v_return;

END;
$function$











CREATE OR REPLACE FUNCTION msg.chat_history(p_org_id numeric, p_dc_id numeric, p_sender_bp_id numeric DEFAULT NULL::numeric, p_pt_id numeric DEFAULT NULL::numeric)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
	v_return character varying ;
BEGIN

	IF p_sender_bp_id is null then 
	 	p_sender_bp_id= (select user_id from public.v_current_user);
	END if;
	select coalesce(json_agg(t)::text,'[]') into v_return 
	from (
	SELECT *
	FROM msg.v_chat_history
	WHERE org_id = 2 AND
			dc_id=14686
	ORDER BY topic_id DESC
	
	)t;

	return v_return;

END;
$function$


















CREATE OR REPLACE FUNCTION msg.chat_history(p_org_id numeric, p_dc_id numeric, p_sender_bp_id numeric DEFAULT NULL::numeric, p_pt_id numeric DEFAULT NULL::numeric)
 RETURNS CHARACTER VARYING
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_return CHARACTER VARYING ;
BEGIN

	IF p_sender_bp_id IS NULL THEN 
	 	p_sender_bp_id= (SELECT user_id FROM public.v_current_user);
	END IF;
	SELECT coalesce(json_agg(t)::text,'[]') INTO v_return 
	FROM (
	SELECT *
	FROM msg.v_chat_history
	WHERE org_id = 2 AND
			dc_id=p_dc_id
	ORDER BY topic_id
	
	)t;

	RETURN v_return;

END;
$function$