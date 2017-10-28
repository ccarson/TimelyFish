 create procedure ADG_SlsPrc_CatalogNbr

	@CuryID		varchar(4),
	@CatalogNbr 	varchar(15)
as
	select	*
	from	SlsPrc
	where	CuryID = @CuryID
	and	CatalogNbr like @CatalogNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SlsPrc_CatalogNbr] TO [MSDSL]
    AS [dbo];

