 create procedure ConsAggLev_CustID_SeqNbr

@CustID varchar(15),
@SeqNbrMin smallint,
@SeqNbrMax smallint

AS

select * from ConsAggLev where CustID = @CustID and SeqNbr between @SeqNbrMin and @SeqNbrMax
order by CustID, SeqNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ConsAggLev_CustID_SeqNbr] TO [MSDSL]
    AS [dbo];

