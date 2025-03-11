-- Common Table Expression (CTE) to calculate time differences between consecutive transactions
WITH difference AS (
    SELECT
        *,
        DATEDIFF(
            MINUTE,                                         -- Calculate interval in minutes
            LAG(dt) OVER (PARTITION BY sender ORDER BY dt), -- Previous transaction's timestamp for the same sender
            dt                                              -- Current transaction's timestamp
        ) AS diff_minute                                    -- Time difference in minutes between consecutive transactions
    FROM transactions
),

-- CTE to group transactions into sequences based on time intervals
groups AS (
    SELECT
        *,
        SUM(
                                                          -- Create a new group when:
            CASE 
                WHEN diff_minute IS NULL THEN 1           -- First transaction for a sender
                WHEN diff_minute > 60 THEN 1              -- Gap >1 hour from previous transaction
                ELSE 0                                    -- Continue the current group
            END
        ) OVER (PARTITION BY sender ORDER BY dt) AS group_id -- Cumulative sum to create group IDs
    FROM difference
)

-- Final query to aggregate suspicious sequences
SELECT
    sender,
    MIN(dt) AS sequence_start,                           -- First timestamp in the sequence
    MAX(dt) AS sequence_end,                             -- Last timestamp in the sequence
    COUNT(*) AS transactions_count,                      -- Number of transactions in the sequence
    ROUND(SUM(amount), 6) AS transactions_sum            -- Total amount, rounded to 6 decimals
FROM groups
GROUP BY sender, group_id
HAVING 
    SUM(amount) >= 150                                   -- Filter sequences with total >=150
    AND COUNT(*) >= 2                                    -- Ensure at least 2 transactions in the sequence
ORDER BY 
    sender ASC, 
    sequence_start ASC, 
    sequence_end ASC;                                    -- Sort results as specified