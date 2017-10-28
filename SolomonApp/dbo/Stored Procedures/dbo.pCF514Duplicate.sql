
/****** Select all transactions ******/
CREATE  Procedure pCF514Duplicate
	       @parm1 varchar(10),@parm2 smalldatetime, @parm3 varchar(16), @parm4 integer, @parm5 varchar(10), @parm6 varchar(10)
as
	Select * From cftPGInvXfer
	WHERE SrcPigGroupID=@parm1 AND TranDate=@parm2 AND acct=@parm3 and Qty=@parm4 AND BatNbr<>@parm5 AND DestPigGroupID=@parm6


