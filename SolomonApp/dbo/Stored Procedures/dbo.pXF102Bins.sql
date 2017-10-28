CREATE              Proc dbo.pXF102Bins
		@parm1 varchar(6), @parm2 smalldatetime, @parm3 smalldatetime, @parm4 varchar(6)
	as
select  *
	FROM cftBinReading br
	JOIN cftBin bn ON br.BinNbr=bn.BinNbr AND bn.ContactID=br.SiteContactID
	JOIN cftBinType bt ON bn.BinTypeID=bt.BinTypeID
	--Where bn.ContactID=@parm1 AND br.BinNbr=@parm2 AND br.BinReadingDate = @parm3
	Where br.SiteContactID=@parm1 AND br.BinReadingDate > @parm2 AND br.BinReadingDate < @parm3 AND br.BinNbr LIKE @parm4
        Order by bn.BarnNbr, bn.BinNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF102Bins] TO [MSDSL]
    AS [dbo];

