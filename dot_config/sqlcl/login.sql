--------------------------------------------------------------------------------
-- SQLcl Configuration
--------------------------------------------------------------------------------
set editor emacs
set sqlformat ansiconsole
set highlighting on
set codescan on
set history fails
set history filter history,connect,clear,set

-- Length of LONG of LOB columns to display before truncating
set long 100
-- Length of LONG or LOB columns to display before breaking into a new visual row
set longchunksize 100

-- script currentschema.js

-- set statusbar username currentschema dbid editmode txn timing cwd linecol
set statusbar username dbid editmode txn timing cwd linecol

set serveroutput on size unlimited

--------------------------------------------------------------------------------
-- Database session Configuration
--------------------------------------------------------------------------------
set termout off

alter session set PLSQL_OPTIMIZE_LEVEL=2;

-- PLW-06005: Throws a warning when the compiler inlines a procedure
-- PLW-06026: Throws a warning when a package spec exposes a global variable
-- PLW-06027: Throws a warning when the compiler removes a procedure that has been inlined everywhere
-- PLW-07206: Throws a warning when the compiler determines assignement to a string is unnecessary
alter session set PLSQL_WARNINGS='ENABLE:ALL', 'DISABLE:(6005,6026,6027,7206)';

-- Set NLS formats
alter session set nls_date_format = "YYYY-MM-DD HH24:MI:SS";
alter session set nls_timestamp_format = "YYYY-MM-DD HH24:MI:SSXFF";
alter session set nls_timestamp_tz_format = "YYYY-MM-DD HH24:MI:SSXFF TZH:TZM";

set termout on
