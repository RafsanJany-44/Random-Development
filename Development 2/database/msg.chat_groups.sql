CREATE OR REPLACE FUNCTION msg.chat_groups(p_org_id numeric, p_pt_id numeric)
RETURNS CHARACTER VARYING 
LANGUAGE plpgsql
AS $function$
DECLARE
	v_return CHARACTER VARYING;
--	v_curent_user public.v_current_user.user_id%TYPE;
BEGIN

 --v_current_user= (SELECT user_id FROM public.v_current_user);

SELECT coalesce(json_agg(t)::text,'[]') INTO v_return 
FROM(
SELECT *
FROM public.discussion_category 
WHERE org_id =p_org_id AND                  -- TODO:  (current_user)=discussion_category.bp_id OR discussion_category_members table)
      coalesce(pt_id,0)= coalesce(p_pt_id,0) and
      (discussion_class in ('PUBLIC_GROUP','PRIVATE_GROUP'))
)t;

RETURN v_return;

END;
$function$;


select * from msg.chat_groups(2,null);