--DROP TABLE public.discussion_category_members

CREATE TABLE public.discussion_category_members(
	org_id numeric(4) NOT NULL,
	dc_id numeric(10) NOT NULL,
	bp_id numeric(10) NOT NULL,
	role_code varchar(250) NULL,
	entered_by numeric(10) NOT NULL,
	entered_on timestamptz NOT NULL,
	last_updated_by numeric(10) NOT NULL,
	last_updated_on timestamptz NOT NULL
	CONSTRAINT discussion_category_ref_org_id_fk FOREIGN KEY (org_id) REFERENCES organization(org_id),
);

create trigger tfb1_row_history before
insert
    or
update
    on
    public.discussion_category_members for each row execute procedure itfb1_add_row_history();



--------------------------------------------View---------------------------------------------------

CREATE OR REPLACE VIEW msg.v_chat_history
AS 
select 
public.discussion_topic.org_id,
public.discussion_topic.topic_id,
public.discussion_topic.bp_id as sender_bp_id,
public.discussion_topic_bp_action.bp_id as recipent_bp_id,
public.discussion_topic.pt_id,
public.discussion_topic.dc_id,
public.discussion_topic.parent_topic_id,
public.discussion_topic.topic_title,
public.discussion_topic.topic_details,
public.discussion_topic.is_global,
public.discussion_topic.access_roles,
public.discussion_topic.delete_roles,
public.discussion_topic.entered_by,
public.discussion_topic.entered_on,
public.discussion_topic.last_updated_by,
public.discussion_topic.last_updated_on,
public.discussion_topic.is_deleted,
public.discussion_topic.discussion_class,
public.discussion_topic.topic_view_action,
public.discussion_topic.ns_bp_id,
public.discussion_topic.ns_document_no,
public.discussion_topic.ns_document_code,
public.discussion_topic_bp_action.viewed_on,
public.discussion_topic_bp_action.is_followed,
public.discussion_topic_bp_action.is_favourite
from public.discussion_topic,
public.discussion_topic_bp_action
WHERE  public.discussion_topic.topic_id
         =public.discussion_topic_bp_action.topic_id;

-----------------------------------------------------DB Funtion---------------------------------------------
CREATE OR REPLACE FUNCTION msg.chat_history(p_org_id numeric, p_pt_id numeric, p_dc_id numeric, 
                                p_recipent_bp_id numeric,p_sender_bp_id numeric default null )
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
      pt_id = p_pt_id and
      dc_id = p_dc_id and 
      recipent_bp_id = p_recipent_bp_id and 
      sender_bp_id = p_sender_bp_id
)t;

return v_return;

END;
$function$


------------------------

CREATE OR REPLACE FUNCTION msg.chat_groups(p_org_id numeric, p_pt_id numeric)
 RETURNS ?
 LANGUAGE plpgsql
AS $function$
DECLARE


BEGIN







END;
$function$



--------------

CREATE OR REPLACE FUNCTION msg.save(p_org_id numeric,p_pt_id numeric, p_dc_id numeric, 
                                    p_recipent_bp_id numeric,p_sender_bp_id numeric)
 RETURNS ?
 LANGUAGE plpgsql
AS $function$
DECLARE


BEGIN









END;
$function$




----------------------------------------------rough---------------------------

select * from public.discussion_topic;

select * from public.discussion_topic_bp_action;

select * from public.discussion_topic
inner join public.discussion_topic_bp_action
on  public.discussion_topic.topic_id =public.discussion_topic_bp_action.topic_id;




select 