 create procedure Checkfor_OMBatch @parm1 varchar (10) as
select jrnltype from batch where batnbr = @parm1 and module = "AR" and jrnltype = "OM"
Order by batnbr,module


