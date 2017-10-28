 Create Proc EDFrtTerms_Collect @FrtTermsId varchar(10) As
Select Collect From FrtTerms Where FrtTermsId = @FrtTermsId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDFrtTerms_Collect] TO [MSDSL]
    AS [dbo];

