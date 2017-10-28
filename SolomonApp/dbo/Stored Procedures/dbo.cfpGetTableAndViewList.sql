--****************************************************************
--	Purpose:Retrieve the list of table and view names
--	Author: Timothy Jones
--	Date: 8/10/2005
--	Program Usage: XU001
--	Parms: @TableName - name of SQL table or view
--****************************************************************
CREATE PROCEDURE cfpGetTableAndViewList
AS
select TableName = convert(char(90), name) 
	FROM sysobjects WHERE xtype IN('U','V')
	ORDER BY Name

GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfpGetTableAndViewList] TO [MSDSL]
    AS [dbo];

