
Create Procedure cfpAPDoc_AcctSub_RefNbr @parm1 varchar (10), @parm2 varchar (24), @parm3 varchar (10) as 
   Select * from APDoc Where Acct = @parm1 and Sub = @parm2 and DocType In ('CK', 'HC', 'VC') and RefNbr Like @parm3
	Order by RefNbr
