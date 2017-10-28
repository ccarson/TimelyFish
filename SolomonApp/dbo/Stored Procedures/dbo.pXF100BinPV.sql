
CREATE    Proc pXF100BinPV
		@parm1 varchar(6),
		@parm2 varchar (6)
	as
select  *
	FROM cfvBin 
	Where ContactID=@parm1 And BinNbr Like @parm2
	Order by ContactId, BinNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF100BinPV] TO [MSDSL]
    AS [dbo];

