with 

source as (

    select * from {{ source('raw', 'ship') }}

),

renamed as (

    select
        orders_id,
        coalesce(shipping_fee, shipping_fee_1) as shipping_fee,
        logcost,
        safe_cast(
            replace(replace(cast(ship_cost as string), '€', ''), ',', '.') 
            as float64
        ) as ship_cost

    from source

)

select * from renamed