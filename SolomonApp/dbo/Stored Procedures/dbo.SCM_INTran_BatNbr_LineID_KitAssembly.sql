 Create	Procedure SCM_INTran_BatNbr_LineID_KitAssembly
	@BatNbr 	varchar ( 10),
	@KitID		varchar ( 30),
	@RefNbr		varchar ( 15),
	@InitMode	smallint,
	@Status		varchar ( 1),
	@parm2beg 	smallint,
	@parm2end 	smallint
as

    	Select 	*
	from 	INTran
	where 	Batnbr = @BatNbr
	  and	InvtID <> @KitID
	  and	RefNbr = @RefNbr
	  and 	(@InitMode = 0 or Rlsed = 0 or @Status <> 'S')
       	  and 	LineNbr between @parm2beg and @parm2end
     	  and 	TranType not in ('CT', 'CG')
      	order by BatNbr, LineNbr


