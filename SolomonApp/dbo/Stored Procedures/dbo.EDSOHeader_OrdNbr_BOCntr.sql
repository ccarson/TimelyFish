 Create Proc EDSOHeader_OrdNbr_BOCntr @OrdNbr varchar(15), @CpnyID varchar(10) As
select * From EDSOHeader where ordnbr = @OrdNbr and cpnyid = @CpnyID order by ordnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOHeader_OrdNbr_BOCntr] TO [MSDSL]
    AS [dbo];

