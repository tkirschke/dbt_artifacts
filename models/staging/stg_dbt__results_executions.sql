with base as (

    select *
    from {{ source('dbt_artifacts', 'results_executions') }}

),

enhanced as (

    select
        {{ dbt_utils.surrogate_key(['command_invocation_id', 'node_id']) }} as node_execution_id,
        command_invocation_id,
        node_id,
        was_full_refresh,
        split(thread_id, '-')[1]::int as thread_id,
        status,
        compile_started_at,
        query_completed_at,
        total_node_runtime,
        rows_affected,
        model_materialization,
        model_schema,
        name
    from base

)

select * from enhanced
