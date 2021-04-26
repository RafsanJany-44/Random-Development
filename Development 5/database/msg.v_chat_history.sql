CREATE OR REPLACE VIEW msg.v_chat_history
AS SELECT discussion_topic.org_id,
    discussion_topic.topic_id,
    discussion_topic.bp_id AS sender_bp_id,
    discussion_topic_bp_action.bp_id AS recipent_bp_id,
    bp.bp_name AS recipent_bp_name,
    discussion_topic.pt_id,
    discussion_topic.dc_id,
    discussion_topic.parent_topic_id,
    discussion_topic.topic_title,
    discussion_topic.topic_details,
    discussion_topic.is_global,
    discussion_topic.access_roles,
    discussion_topic.delete_roles,
    discussion_topic.entered_by,
    discussion_topic.entered_on,
    discussion_topic.last_updated_by,
    discussion_topic.last_updated_on,
    discussion_topic.is_deleted,
    discussion_topic.discussion_class,
    discussion_topic.topic_view_action,
    discussion_topic.ns_bp_id,
    discussion_topic.ns_document_no,
    discussion_topic.ns_document_code,
    discussion_topic_bp_action.viewed_on,
    discussion_topic_bp_action.is_followed,
    discussion_topic_bp_action.is_favourite
   FROM discussion_topic,
    discussion_topic_bp_action,
    business_partner bp
  WHERE discussion_topic_bp_action.bp_id = bp.bp_id AND discussion_topic.topic_id = discussion_topic_bp_action.topic_id;







  CREATE OR REPLACE VIEW msg.v_chat_history
    AS SELECT dt.org_id,
    dt.topic_id,
    dt.bp_id AS sender_bp_id,
    (
    SELECT bp_name FROM business_partner WHERE bp_id=dt.bp_id
    ) AS sender_bp_name,
    dtba .bp_id AS recipent_bp_id,
    bp.bp_name AS recipent_bp_name,
    dt.pt_id,
    dt.dc_id,
    dt.parent_topic_id,
    dt.topic_title,
    dt.topic_details,
    dt.is_global,
    dt.access_roles,
    dt.delete_roles,
    dt.entered_by,
    dt.entered_on,
    dt.last_updated_by,
    dt.last_updated_on,
    dt.is_deleted,
    dt.discussion_class,
    dt.topic_view_action,
    dt.ns_bp_id,
    dt.ns_document_no,
    dt.ns_document_code,
    dtba.viewed_on,
    dtba.is_followed,
    dtba.is_favourite
   FROM discussion_topic dt,
    discussion_topic_bp_action dtba,
    business_partner bp
  WHERE dtba.bp_id = bp.bp_id AND dt.topic_id = dtba.topic_id;

