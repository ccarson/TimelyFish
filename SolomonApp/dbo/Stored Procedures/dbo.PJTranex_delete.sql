 Create Procedure PJTranex_delete @parm1 varchar (06)  as
Delete from PJTranex
where fiscalno <= @parm1


