 Create Proc ED850Header_POBoExists @CustId varchar(15), @PONbr varchar(35) As
Select * From ED850Header where CustId = @CustId and PONbr = @PONbr and PoType in ('BE','BK','LB')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Header_POBoExists] TO [MSDSL]
    AS [dbo];

