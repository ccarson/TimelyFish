Create Procedure CF517p_cftPSCtrctDates_CD @parm1 varchar (6), @parm2beg smalldatetime, @parm2end smalldatetime as 
    Select * from cftPSCtrctDates Where CtrctNbr = @parm1 and BPDate Between @parm2beg and @parm2end
	Order by CtrctNbr, BPDate DESC

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF517p_cftPSCtrctDates_CD] TO [MSDSL]
    AS [dbo];

