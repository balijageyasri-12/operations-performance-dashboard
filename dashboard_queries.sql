-- 1. Data Cleaning: Handle missing values in Customer Satisfaction (CSAT) scores
UPDATE customer_interactions
SET csat_score = 0
WHERE csat_score IS NULL;

-- 2. Performance Analysis: Calculate Average Turnaround Time (TAT) per Agent Team
SELECT 
    agent_team,
    COUNT(interaction_id) AS total_cases_handled,
    ROUND(AVG(turnaround_time_hours), 2) AS avg_tat_hours,
    ROUND(AVG(csat_score), 1) AS average_csat
FROM customer_interactions
GROUP BY agent_team
ORDER BY average_csat DESC;

-- 3. Efficiency Metric: Calculate First Contact Resolution (FCR) Rate
SELECT 
    process_type,
    COUNT(interaction_id) AS total_cases,
    SUM(CASE WHEN is_resolved_first_contact = 1 THEN 1 ELSE 0 END) AS first_contact_resolutions,
    ROUND((SUM(CASE WHEN is_resolved_first_contact = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(interaction_id)), 2) AS fcr_percentage
FROM customer_interactions
GROUP BY process_type;
