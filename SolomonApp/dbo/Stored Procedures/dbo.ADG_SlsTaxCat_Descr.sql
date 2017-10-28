 CREATE PROCEDURE ADG_SlsTaxCat_Descr
	@CatID varchar(10)
AS
	SELECT Descr
	FROM SlsTaxCat
	WHERE CatID = @CatID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SlsTaxCat_Descr] TO [MSDSL]
    AS [dbo];

