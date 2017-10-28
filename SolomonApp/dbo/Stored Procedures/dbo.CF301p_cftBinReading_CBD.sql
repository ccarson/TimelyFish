
/****** Object:  Stored Procedure dbo.CF301p_cftBinReading_CBD    Script Date: 9/20/2005 12:04:44 PM ******/
CREATE  Procedure [dbo].[CF301p_cftBinReading_CBD] @parm1 varchar (6), @parm2 char (6), @parm3beg smalldatetime, @parm3end smalldatetime as
Select * from cftBinReading Where SiteContactId = @parm1 and BinNbr = @parm2
	and BinReadingDate Between @parm3beg and @parm3end
	Order by SiteContactId, BinNbr, BinReadingDate DESC

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF301p_cftBinReading_CBD] TO [MSDSL]
    AS [dbo];

