﻿ CREATE PROCEDURE ED850Lineitem_EDIPoId
 @parm1 varchar( 10 )
AS
 SELECT *
 FROM ED850Lineitem
 WHERE EDIPoId LIKE @parm1
 ORDER BY EDIPoId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Lineitem_EDIPoId] TO [MSDSL]
    AS [dbo];

