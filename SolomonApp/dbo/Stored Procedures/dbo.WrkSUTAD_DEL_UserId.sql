 Create Proc  WrkSUTAD_DEL_UserId @parm1 varchar ( 47) as
       Delete wrksutad from WrkSUTAD
           where UserId   =  @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WrkSUTAD_DEL_UserId] TO [MSDSL]
    AS [dbo];

