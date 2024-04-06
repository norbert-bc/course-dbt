{% macro test_less_than_or_equal(model, smaller_column, larger_column) %}

select
    *
from {{ model }}
where {{ smaller_column }} > {{ larger_column }}

{% endmacro %}