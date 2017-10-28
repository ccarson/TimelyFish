 Create proc pp08050Payments
   @parm1 varchar (10),
   @parm2 varchar (10),
   @parm3 varchar (2),
   @parm4 varchar (15) as

   Select * from ardoc
   where batnbr = @parm1 and
         refnbr = @parm2 and
         doctype = @parm3 and
         custid like @parm4
   order by batnbr, refnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp08050Payments] TO [MSDSL]
    AS [dbo];

