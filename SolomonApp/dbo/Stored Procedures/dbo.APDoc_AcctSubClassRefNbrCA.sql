 /****** Object:  Stored Procedure dbo.APDoc_AcctSubClassRefNbrCA    Script Date: 4/7/98 12:49:19 PM ******/
Create Procedure APDoc_AcctSubClassRefNbrCA @parm1 varchar (10), @parm2 varchar (10), @parm3 varchar (24), @parm4 varchar (1), @parm5 varchar (10) as
Select * from APDoc
where cpnyid = @parm1
and Acct = @parm2
and Sub = @parm3
and DocClass = @parm4
and RefNbr = @parm5
and Status <> 'V'
and DocType IN ('CK', 'HC','EP', 'ZC')
Order by Acct, Sub, DocType, RefNbr


