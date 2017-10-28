Create Procedure CF517p_cftPSContrPriceHist_CD @parm1 varchar (6), @parm2beg smalldatetime, @parm2end smalldatetime as 
    Select * from cftPSContrBPHist Where ContrNbr = @parm1 and BPDate Between @parm2beg and @parm2end
	Order by ContrNbr, BPDate DESC
