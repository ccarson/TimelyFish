
CREATE PROCEDURE XDDFile_Wrk_Load_PR_PP
   @BatNbr	varchar(10)

AS
   SELECT	*
   FROM		PRDoc (NoLock)
   WHERE	(	(PRDoc.Status <> 'V' and PRDoc.DocType <> 'VC') or	-- No voids in orig batch
   			(PRDoc.Status = 'V' and PRDoc.DocType = 'VC') 		-- Only voids in void batch
   		)
   		and PRDoc.Batnbr = @BatNbr
   		and PRDoc.DocType <> 'ZC'				-- No Zero Checks
   		and PRDoc.DocType <> 'SC'				-- No Stub Checks

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDFile_Wrk_Load_PR_PP] TO [MSDSL]
    AS [dbo];

