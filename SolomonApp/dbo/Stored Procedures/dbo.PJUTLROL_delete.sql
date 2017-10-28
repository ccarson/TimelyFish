 Create Procedure PJUTLROL_delete @parm1 varchar (06)  as
Delete from PJUTLROL
where fiscalno <= @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJUTLROL_delete] TO [MSDSL]
    AS [dbo];

