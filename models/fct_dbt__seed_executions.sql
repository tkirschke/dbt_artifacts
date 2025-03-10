with
    base as (select * from {{ ref("stg_dbt__seed_executions") }}),

    seed_executions as (

        select
            seed_execution_id,
            command_invocation_id,
            node_id,
            run_started_at,
            was_full_refresh,
            thread_id,
            status,
            compile_started_at,
            query_completed_at,
            total_node_runtime,
            rows_affected,
            materialization,
            {% if target.type == "sqlserver" or target.type == "fabric" %} "schema"
            {% else %} schema
            {% endif %},
            name,
            alias,
            message
        from base

    )

select *
from seed_executions

