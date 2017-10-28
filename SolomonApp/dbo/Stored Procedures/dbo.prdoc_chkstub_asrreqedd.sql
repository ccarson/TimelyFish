	CREATE PROCEDURE prdoc_chkstub_asrreqedd @parm1 As char(10)
AS	
		Select PRDoc.* from PRDoc join vs_ASRReqEDD on PRDoc.chknbr = vs_asrreqedd.chknbr and vs_asrreqedd.doctype = 'D1'
			where PRDoc.DocType = 'CK' 
			and PRDoc.ChkNbr like @parm1 
			order by PRDoc.ChkNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[prdoc_chkstub_asrreqedd] TO [MSDSL]
    AS [dbo];

