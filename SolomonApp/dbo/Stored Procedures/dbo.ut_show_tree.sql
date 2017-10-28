 CREATE PROC ut_show_tree @obj_name VARCHAR (75),
                         @detail VARCHAR (5) = 'Proc',
                         @levelnum int = 0 AS
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
**    Proc Name: ut_show_tree
**++* Narrative: Creates a list of dependencies in tree form for a given proc or view.
*               This program does not report dependencies across databases
**    Inputs   : obj_name  varchar(75)   obj_name for which to list dependencies
*               detail     varchar(4)    Optional parameter
*                                        "Proc" -(Default) lists all dependent procs
                                                 if a proc is passed, all views if a view is passed.
*                                        "view"  - list dependent procs and views
*                                        "table" - list dependent procs, views and tables
*               levelnum   int           Used internally by this program for recursive calls. Should
*                                          not be passed to this program from the command line.
**   Called by: Standalone program used from isql/w prompt. Calls itself recursively as
*              dependencies are found.
*
*/
SET NOCOUNT ON
-- Declare variables
DECLARE @nextobjname VARCHAR (75)
DECLARE @thisproc VARCHAR (75)
DECLARE @type2 VARCHAR (4)
DECLARE @type3 VARCHAR (10)

/* Get the name of this proc to use in recursive call below  */
/* Using the hardcoded name in the exec below will cause compile time warnings */
/* that the proc does not exist. */

SELECT @thisproc = name
  FROM sysobjects
 WHERE id = @@PROCID

-- If this is just being called (levelnum = 0) then make sure proc passed is valid
IF @levelnum = 0
   BEGIN
     IF (SELECT count(*)
         FROM sysobjects
        WHERE name=@obj_name) = 0
     BEGIN
       PRINT 'Proc not found'
       GOTO Endit
     END
   END

-- Depending on parms passed to this program, set up correct variables for
--case statement below
IF @detail = 'table'
BEGIN
   set @type2 = 'view'
   set @type3 = 'user table'
END
ELSE IF @detail = 'View'
BEGIN
   set @type2 = 'view'
   set @type3 = null
END
ELSE IF (Select xtype from sysobjects where name = @obj_name) = 'V'
BEGIN
   set @type2 = 'View'
   set @type3 = null
END

-- Print out this program name, add 1 to nesting level
PRINT replace(SPACE((@levelnum)*2) + @obj_name,'  ','. ')
SELECT @levelnum = @levelnum + 1

-- Declare/Open Cursor for finding passed objects dependencies
DECLARE obj_list CURSOR LOCAL FOR
          SELECT distinct 'name' = substring(o1.name, 1, 40)
            FROM sysobjects o1,
		 master.dbo.spt_values	v2,
		 sysdepends		d3
           WHERE o1.id = d3.depid
             AND o1.xtype = substring(v2.name,1,2) AND v2.type = 'O9T'
             AND substring(v2.name, 5, 16) in ('stored procedure',@type2, @type3)
	     AND d3.id = object_id(@obj_name)

OPEN obj_list

-- Get all dependencies, recursive calling this proc to show those dependencies too
FETCH obj_list INTO @nextobjname
WHILE ( @@FETCH_STATUS <> -1)
BEGIN
    EXEC @thisproc @nextobjname, @detail, @levelnum
    FETCH obj_list INTO @nextobjname
END

-- clean up cursor
CLOSE obj_list
DEALLOCATE obj_list

Endit:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ut_show_tree] TO [MSDSL]
    AS [dbo];

