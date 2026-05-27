select owner, object_type, object_name, status
from all_objects
where status != 'VALID'
order by owner, object_type, object_name;

