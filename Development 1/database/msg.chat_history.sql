CREATE OR REPLACE FUNCTION msg.chat_history(p_org_id numeric, p_pt_id numeric, p_dc_id numeric, 
                                p_recipent_bp_id numeric,p_sender_bp_id numeric default null )
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
DECLARE
v_return character varying ;

BEGIN

SELECT coalesce(json_agg(t)::text,'[]') INTO v_return 
FROM(
SELECT *
FROM msg.v_chat_history
WHERE org_id = p_org_id AND
      pt_id = p_pt_id AND
      dc_id = p_dc_id AND
      recipent_bp_id = p_recipent_bp_id AND 
      sender_bp_id = p_sender_bp_id
)t;

RETURN v_return;

END;
$function$

select msg.chat_history

