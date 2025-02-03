with
    base as (select * from {{ ref("stg_dbt__seeds") }}),

    seeds as (

        select
            seed_execution_id,
            command_invocation_id,
            node_id,
            run_started_at,
            name,
            {% if target.type == "sqlserver" or target.type == "fabric" %} "database"
            {% else %} database
            {% endif %},
            {% if target.type == "sqlserver" or target.type == "fabric" %} "schema"
            {% else %} schema
            {% endif %},
            package_name,
            path,
            checksum,
            meta,
            alias
        from base

    )

select *
from seeds

