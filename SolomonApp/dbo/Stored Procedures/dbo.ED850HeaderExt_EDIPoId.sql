﻿ CREATE PROCEDURE ED850HeaderExt_EDIPoId
 @parm1 varchar( 10 )
AS
 SELECT *
 FROM ED850HeaderExt
 WHERE EDIPoId LIKE @parm1
 ORDER BY EDIPoId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850HeaderExt_EDIPoId] TO [MSDSL]
    AS [dbo];

