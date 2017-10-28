--****************************************************************
--	Purpose:Retrieve the field list for a table with
--        type definition information
--	Author: Timothy Jones
--	Date: 8/10/2005
--	Program Usage: XU001
--	Parms: @TableName - name of SQL table or view
--****************************************************************
CREATE PROC cfpGetFieldListWithTypeAndLength 
	@TableName varchar(90)
	AS
	SELECT convert(char(30),sc.name), convert(char(30),st.name), sc.length
		FROM syscolumns sc
		JOIN systypes st ON sc.xusertype = st.xusertype
			where id = (select object_id(@TableName))
			AND st.name <> 'timestamp'
			order by colorder

GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfpGetFieldListWithTypeAndLength] TO [MSDSL]
    AS [dbo];

