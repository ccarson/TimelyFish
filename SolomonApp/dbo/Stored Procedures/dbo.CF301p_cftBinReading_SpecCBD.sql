Create Procedure CF301p_cftBinReading_SpecCBD @parm1 varchar (6), @parm2 varchar (6), @parm3 smalldatetime as 
    Select * from cftBinReading Where SiteContactId = @parm1 and BinNbr = @parm2
	and BinReadingDate = @parm3

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF301p_cftBinReading_SpecCBD] TO [MSDSL]
    AS [dbo];

