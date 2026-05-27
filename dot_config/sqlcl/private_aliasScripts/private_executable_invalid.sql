select owner, object_type, object_name, status
from all_objects
where status != 'VALID'
    and owner in(
        select username
        from all_users
        where common = 'NO'
            and oracle_maintained = 'N'
    )
order by owner, object_type, object_name;

