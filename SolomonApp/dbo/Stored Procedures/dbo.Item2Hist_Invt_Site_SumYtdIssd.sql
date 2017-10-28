 Create Proc Item2Hist_Invt_Site_SumYtdIssd
	@parm1 varchar ( 30),
	@parm2 varchar ( 10)
AS
SELECT Sum(YtdQtyIssd)+ Sum(YtdQtySls) FROM Item2Hist
	WHERE InvtId  = @parm1
	AND SiteID = @parm2
	GROUP BY InvtID,SiteID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Item2Hist_Invt_Site_SumYtdIssd] TO [MSDSL]
    AS [dbo];

