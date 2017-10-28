 Create Proc  UnionDeduct_DedId_Update2 @parm1 varchar (10), @parm2 varchar (1), @parm3 varchar (2), @parm4 float as
           Update UnionDeduct set basetype        = @parm2,
                                  calcmthd        = @parm3,
                                  fxdpctrate      = @parm4,
                                  wklyminamtperpd = 0,
                                  bwkminamtperpd  = 0,
                                  smonminamtperpd = 0,
                                  monminamtperpd  = 0,
                                  override        = 0
           Where DedId = @parm1 and BaseType <> 'E'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[UnionDeduct_DedId_Update2] TO [MSDSL]
    AS [dbo];

