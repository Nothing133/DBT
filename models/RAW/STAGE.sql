SELECT 
    c.customer_id, 
    c.customer_name, 
    c.email, 
    o.order_id, 
    o.order_date, 
    o.total_amount
FROM {{ ref('RAW_CUSTOMERS') }} as c
JOIN  {{ ref('RAW_ORDERS') }} as o 
ON c.customer_id = o.customer_id



