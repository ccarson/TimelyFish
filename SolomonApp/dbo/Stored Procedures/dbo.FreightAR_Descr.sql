 Create Proc FreightAR_Descr @parm1 varchar ( 10) as
    Select Descr from FrtTerms where FrtTermsID = @parm1 order by FrtTermsID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FreightAR_Descr] TO [MSDSL]
    AS [dbo];

