select *
from all_users
where common = 'NO'
    and oracle_maintained = 'N'
    and cloud_maintained = 'NO'
order by username asc;
