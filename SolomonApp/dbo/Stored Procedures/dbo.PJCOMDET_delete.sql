 Create Procedure PJCOMDET_delete @parm1 varchar (06)  as
Delete from PJCOMDET
where fiscalno <= @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOMDET_delete] TO [MSDSL]
    AS [dbo];

