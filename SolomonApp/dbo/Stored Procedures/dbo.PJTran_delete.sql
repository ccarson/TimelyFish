 Create Procedure PJTran_delete @parm1 varchar (06)  as
Delete from Pjtran
where
fiscalno <= @parm1 and
tr_status <> 'S'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTran_delete] TO [MSDSL]
    AS [dbo];

