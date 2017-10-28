
create proc inprjallocationlot_All 
    @CpnyID     VarChar(10),
    @OrdNbr     Varchar(15)
    As
Select * from inprjallocationlot
 where SrcNbr =  @OrdNbr   AND
       CpnyID = @CpnyID    
        

GO
GRANT CONTROL
    ON OBJECT::[dbo].[inprjallocationlot_All] TO [MSDSL]
    AS [dbo];

