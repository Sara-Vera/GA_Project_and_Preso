SELECT a.campaign_id, count(a.campaign_id) AS num_actions, b.follows_count,
  SUM(CASE WHEN a.recruiter_id IS NOT NULL THEN 1 ELSE 0 END) AS num_recruited_actions,
  SUM(CASE WHEN c.context_id = a.campaign_id THEN 1 ELSE 0 END) AS num_posts, 
  SUM(CASE WHEN d.author_id = b.creator_id THEN 1 ELSE 0 END) AS num_auth_posts, 
  e.num_pers_campaigns, f.comment_count, b.created_at
FROM action_credit_silo.action_credits AS a
  JOIN descolada_prod.campaigns AS b ON (a.campaign_id = b.id)
  LEFT JOIN descolada_prod.post_references AS c ON (b.id = c.context_id)
  LEFT JOIN descolada_prod.posts AS d ON (c.post_id = d.id)
  LEFT JOIN analytics_db.temp_num_pers_campaigns_Oct_9_sv AS e ON (b.id = e.campaign_id)
  LEFT JOIN descolada_prod.comment_threads AS f ON (c.post_id = f.owner_id)
WHERE b.id > 82 
  AND b.launched_at IS NOT NULL 
  AND b.deleted_at IS NULL 
  AND b.title NOT LIKE '%test%'
  AND b.state NOT LIKE 'Inactive'
  AND c.context_type = 'Campaign'
  AND f.owner_type = 'Post'
GROUP BY campaign_id