
CREATE proc Fetch_inprjallocation 
        @RefNbr		Varchar(30),
        @SrcType	Varchar(8),
        @LineRef     VarChar(32),
	@CpnyID     VarChar(10)
As
Select * from inprjallocation WITH(NOLOCK)
 where SrcNbr = @RefNbr AND
       SrcType = @SrcType AND
       SrcLineRef = @LineRef AND
       CpnyID = @CpnyID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[Fetch_inprjallocation] TO [MSDSL]
    AS [dbo];

