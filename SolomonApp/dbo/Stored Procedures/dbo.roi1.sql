 Create Procedure roi1 @rptidb smallint           , @rptide smallint            As
Select * from rptruntime (NOLOCK)
Where rptruntime.RI_ID Between @rptidb and @rptide
Order by RI_ID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[roi1] TO [MSDSL]
    AS [dbo];

