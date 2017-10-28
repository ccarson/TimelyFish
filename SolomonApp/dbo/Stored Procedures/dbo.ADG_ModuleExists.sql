 CREATE PROCEDURE ADG_ModuleExists
	@ModuleCode varchar(2)
AS
	-- This procedure is used to determine if a particular module is installed.
	-- A module is considered 'installed' if it has a setup table that contains
	-- at least one row.  The name of the setup table is the module code plus 'setup'.
	-- For example, if @moduleCode = 'SO' then the setup table name is 'SOsetup'.
	--
	-- This procedure returns a single-row resultset with a single integer column
	-- called ModuleExists.  The return values are as follows:
	--  -1           The setup table does not exist.
	--   0           The setup table exists but has no records.
	--   1           The setup table exists and has at least one record.

	declare @SetupRowCount integer
	declare @SetupTable varchar(255)
	declare @Sql varchar(255)

	select @setupTable = @moduleCode + 'setup'

	if exists( select id from sysobjects where name = @SetupTable and type = 'U' )
		--The table exists so return 0 if there are no records, else return 1.
		exec('select case count(*) when 0 then convert(tinyint,0) else convert(tinyint,1) end as ModuleExists from ' + @SetupTable)
	else
		--The table does not exist so return -1
		select convert(tinyint,-1) as ModuleExists

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_ModuleExists] TO [MSDSL]
    AS [dbo];

