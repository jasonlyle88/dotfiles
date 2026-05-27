set define '&'
set termout off

variable listUsersScript_bv varchar2(4000);
declare
    l_count number;
begin
    select count(1)
    into l_count
    from all_tab_cols
    where owner = 'SYS'
        and table_name = 'ALL_USERS'
        and column_name = 'CLOUD_MAINTAINED';

    if l_count = 1 then
        :listUsersScript_bv := 'listUsersWithCloudMaintainedConstraint.sql';
    else
        :listUsersScript_bv := 'listUsersWithoutCloudMaintainedConstraint.sql';
    end if;
end;
/

-- Convert bind variable to substitution variable
column listUsersScript new_value listUsersScript
select
    :listUsersScript_bv listUsersScript
from sys.dual;

set termout on

@@ "&&listUsersScript"

undefine listUsersScript
