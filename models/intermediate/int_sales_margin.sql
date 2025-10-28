{{ config(materialized='table') }}

WITH source_data AS (
    SELECT
        s.orders_id,
        s.date_date,
        s.product_id,
        p.product_name,
        p.purchase_price,
        s.quantity,
        s.revenue,

        -- Calcul coût d'achat & marge
        (s.quantity * p.purchase_price) AS purchase_cost,
        (s.revenue - (s.quantity * p.purchase_price)) AS margin

    FROM {{ ref('stg_raw__sales') }} s
    LEFT JOIN {{ ref('stg_raw__products') }} p
        USING (product_id)
)

SELECT *
FROM source_data
