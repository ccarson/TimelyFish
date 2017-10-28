

CREATE proc GetLotQtyAvail @parm1 varchar(30), @parm2 varchar (10) ,@parm3 varchar (25) AS
select QtyAvail
 from LotSerMst with (nolock)
where
Invtid = @Parm1 AND
WhseLoc = @parm2 AND
LotSerNbr = @Parm3 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[GetLotQtyAvail] TO [MSDSL]
    AS [dbo];

