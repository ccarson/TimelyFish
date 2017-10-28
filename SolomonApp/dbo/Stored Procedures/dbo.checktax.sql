
create proc checktax as

DECLARE @groupid VARCHAR(15)
DECLARE @String  VARCHAR(400)
DECLARE @String1  VARCHAR(400)

SELECT @String = ''
SELECT @String1 = ''

--find all groups with Categories not correct
DECLARE csr_taxvalues CURSOR FOR
 SELECT  t.groupid FROM slstaxgrp t INNER join salestax s ON t.taxid = s.taxid and s.taxtype = 'T'
  GROUP BY t.groupid
 HAVING MIN(s.CatFlg) <> Max(s.CatFlg) OR MIN(s.CatExcept00) <> Max(s.CatExcept00) OR MIN(s.CatExcept01) <> Max(s.CatExcept01) OR MIN(s.CatExcept02) <> Max(s.CatExcept02)
        OR MIN(s.CatExcept03) <> Max(s.CatExcept03) OR MIN(s.CatExcept04) <> Max(s.CatExcept04) OR MIN(s.CatExcept05) <> Max(s.CatExcept05)

 OPEN csr_taxvalues
FETCH csr_taxvalues INTO @GroupId
WHILE @@FETCH_STATUS = 0
   BEGIN
      SELECT @String1 = @String + ',' + Rtrim(@GroupId)
      SELECT @String  = @String1
      FETCH csr_taxvalues INTO @GroupID
   END

IF @string <> ''
   BEGIN
   	SELECT @String1 = ' Group ID [' + substring(@String, 2, len(@String)) + '] contains Tax IDs with inconsistent values for Categories.'
   	RAISERROR 32000 @String1
   END


CLOSE csr_taxvalues
DEALLOCATE csr_taxvalues
-- end of Categories check



GO
GRANT CONTROL
    ON OBJECT::[dbo].[checktax] TO [MSDSL]
    AS [dbo];

