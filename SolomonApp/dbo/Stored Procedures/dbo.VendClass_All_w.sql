Create Proc VendClass_All_w @parm1 varchar (10) as
    Select ClassID, APAcct, APSub, ExpAcct, ExpSub, PPayAcct, PPaySub, Terms from VendClass where ClassId like @parm1 order by ClassId 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[VendClass_All_w] TO [MSDSL]
    AS [dbo];

