{% macro create_invocations_table_if_not_exists(schema_name, table_name) -%}

    {%- do adapter.create_schema(api.Relation.create(target=target.database, schema=schema_name)) -%}

    {%- if adapter.get_relation(database=database, schema=schema_name, identifier=table_name) is none -%}
        {{ log("Creating table " ~ adapter.quote(schema_name ~ "." ~ table_name), info=true) }}
        {%- set query -%}
            {{ adapter.dispatch('get_create_invocations_table_if_not_exists_statement', 'dbt_artifacts')(schema_name, table_name) }}
        {% endset %}
        {%- call statement(auto_begin=True) -%}
            {{ query }}
        {%- endcall -%}
    {%- endif -%}

{%- endmacro %}

{% macro databricks__get_create_invocations_table_if_not_exists_statement(schema_name, table_name) -%}
    create table {{schema_name}}.{{table_name}} (
        command_invocation_id STRING,
        dbt_version STRING,
        project_name STRING,
        run_started_at TIMESTAMP,
        dbt_command STRING,
        full_refresh_flag BOOLEAN,
        target_profile_name STRING,
        target_name STRING,
        target_schema STRING,
        target_threads INTEGER,
        dbt_cloud_project_id STRING,
        dbt_cloud_job_id STRING,
        dbt_cloud_run_id STRING,
        dbt_cloud_run_reason_category STRING,
        dbt_cloud_run_reason STRING,
        other_env_vars STRING,
        dbt_vars STRING
    )
    using delta
{%- endmacro %}

{% macro snowflake__get_create_invocations_table_if_not_exists_statement(schema_name, table_name) -%}
    create table {{schema_name}}.{{table_name}} (
        command_invocation_id STRING,
        dbt_version STRING,
        project_name STRING,
        run_started_at TIMESTAMP,
        dbt_command STRING,
        full_refresh_flag BOOLEAN,
        target_profile_name STRING,
        target_name STRING,
        target_schema STRING,
        target_threads INTEGER,
        dbt_cloud_project_id STRING,
        dbt_cloud_job_id STRING,
        dbt_cloud_run_id STRING,
        dbt_cloud_run_reason_category STRING,
        dbt_cloud_run_reason STRING,
        other_env_vars ARRAY,
        dbt_vars ARRAY
    )
{%- endmacro %}

{% macro default__get_create_invocations_table_if_not_exists_statement(schema_name, table_name) -%}
    create table {{schema_name}}.{{table_name}} (
        command_invocation_id STRING,
        dbt_version STRING,
        project_name STRING,
        run_started_at TIMESTAMP,
        dbt_command STRING,
        full_refresh_flag BOOLEAN,
        target_profile_name STRING,
        target_name STRING,
        target_schema STRING,
        target_threads INTEGER,
        dbt_cloud_project_id STRING,
        dbt_cloud_job_id STRING,
        dbt_cloud_run_id STRING,
        dbt_cloud_run_reason_category STRING,
        dbt_cloud_run_reason STRING,
        other_env_vars STRING,
        dbt_vars STRING
    )
{%- endmacro %}
