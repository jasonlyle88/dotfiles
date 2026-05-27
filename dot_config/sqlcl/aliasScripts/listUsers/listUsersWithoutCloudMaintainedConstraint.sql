select *
from all_users
where common = 'NO'
    and oracle_maintained = 'N'
order by username asc;
