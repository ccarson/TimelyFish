 Create Procedure APDoc_RefNbr_DocTyp_Acct_Sub @parm1 varchar ( 10), @parm2 varchar ( 2), @parm3 varchar ( 10), @parm4 varchar ( 24) As
Select * from APDoc Where RefNbr = @parm1 and DocType = @parm2 and Acct = @parm3 and Sub = @parm4


