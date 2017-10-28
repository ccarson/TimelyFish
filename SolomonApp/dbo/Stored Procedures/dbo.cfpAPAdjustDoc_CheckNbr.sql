
Create Procedure cfpAPAdjustDoc_CheckNbr @parm1 varchar (10), @parm2 varchar (10), 
	@parm3 varchar (24), @parm4 varchar (10) as 
   Select a.*, d.* from APAdjust a Join APDoc d on a.AdjdRefNbr = d.RefNbr and a.AdjdDocType = d.DocType
	Where a.AdjgRefNbr = @parm1 and a.AdjgAcct = @parm2 and a.AdjgSub = @parm3 and d.RefNbr Like @parm4
	Order by d.RefNbr
