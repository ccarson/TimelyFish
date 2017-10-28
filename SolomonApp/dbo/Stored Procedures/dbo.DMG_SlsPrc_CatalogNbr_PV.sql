 create procedure DMG_SlsPrc_CatalogNbr_PV

	@CuryID		varchar(4),
	@CatalogNbr	varchar(15)
as
	select	distinct CatalogNbr
	from	SlsPrc
	where	CuryID = @CuryID
	and	CatalogNbr like @CatalogNbr
	and	CatalogNbr <> ''
	order by CatalogNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SlsPrc_CatalogNbr_PV] TO [MSDSL]
    AS [dbo];

