/*
{"email_me": "tom.bescherer@wework.com",
 "text_me": "5082571861",
 "schedule":
 [{
  "table_name": "mv_enriched_people",
  "enabled": true,
  "start_at": "2016-01-01",
  "timezone": "America/New_York",
  "cron_schedule": "0 1 * * *",
  "input_json": {
  },
  "type": "normal",
  "incremental_field": "company_id",
  "keys":{
    "primarykey": "email",
    "sortkey": "indexed_at",
    "distkey": "email"
    }
}]}
*/

with unique_people as (
    SELECT
        *,
        row_number() over (partition by email order by indexed_at DESC) as row
    FROM
        dw.mv_enriched_people_historic
)
SELECT
    _run_at as clearbit_ran_at,
    company_id,
    created_at,
    id,
    first_name,
    last_name,
    full_name, 
    email,
    gender,
    location,
    timezone,
    utc_offset,
    city,
    state,
    state_code,
    country,
    country_code,
    latitude,
    longitude,
    bio,
    site,
    avatar,
    employer_name, 
    job_title,
    job_role,
    employer_seniority, 
    employer_domain, 
    facebook_handle,
    github_handle,
    github_id, 
    github_avatar,
    github_company,
    github_blog,
    github_followers,
    github_following,
    twitter_handle,
    twitter_id,
    twitter_bio,
    twitter_followers,
    twitter_following,
    twitter_location,
    twitter_site,
    twitter_statuses, 
    twitter_favorites, 
    twitter_avatar,
    linkedin_handle,
    googleplus_handle,
    about_me_bio,
    about_me_handle,
    about_me_avatar,
    gravatar_handle,
    gravatar_urls,
    gravatar_avatar,
    fuzzy,
    email_provider,
    indexed_at
FROM
    unique_people
WHERE row = 1