 Create Proc Deduction_VendId @parm1 varchar ( 4), @parm2 varchar( 10) as
       Select * from Deduction, Vendor
           where Deduction.VendId = Vendor.VendId
             and Deduction.VendId <> ''
             and CalYr  = @parm1
             and DedId  LIKE  @parm2
           order by DedId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Deduction_VendId] TO [MSDSL]
    AS [dbo];

