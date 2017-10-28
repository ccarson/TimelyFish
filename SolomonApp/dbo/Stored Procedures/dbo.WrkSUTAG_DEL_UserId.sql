 Create Proc  WrkSUTAG_DEL_UserId @parm1 varchar ( 47) as
       Delete wrksutag from WrkSUTAG
           where UserId   =  @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WrkSUTAG_DEL_UserId] TO [MSDSL]
    AS [dbo];

