CREATE PROCEDURE XDDVendor_VendId
  @parm1      varchar(15)
AS
  Select      *
  FROM        Vendor
  WHERE       VendId LIKE @parm1
  ORDER BY    VendId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDVendor_VendId] TO [MSDSL]
    AS [dbo];

