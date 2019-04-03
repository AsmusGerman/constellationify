-- code
-- 0: no errors
-- 1: table doesn't exists

SELECT CASE WHEN EXISTS (
    
   SELECT 1
   FROM   information_schema.tables 
   WHERE  table_schema = 'public'
   AND    table_name = 'constellation'

) THEN 1 ELSE 0 END AS code