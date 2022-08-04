{% test ada_bundles_exist(model, column_name) %}

with validation as (
    select
        {{ column_name }} as bundle_type
    from {{ model }}

),
validation_errors as (
    select
        count(distinct bundle_type) as bundle_type_matches
    from validation

    -- check for all digital access bundle types
    where bundle_type like '%ADA%'
)
select bundle_type_matches
from validation_errors
where bundle_type_matches < 0

{% endtest %}