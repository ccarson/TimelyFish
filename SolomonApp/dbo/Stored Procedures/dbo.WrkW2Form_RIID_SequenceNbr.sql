 Create Proc  WrkW2Form_RIID_SequenceNbr @parm1 smallint, @parm2 smallint, @parm3 smallint as
       Select * from WrkW2Form
           where RI_ID        =       @parm1
             and SequenceNbr  BETWEEN @parm2 and @parm3
           order by RI_ID,
                    SequenceNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WrkW2Form_RIID_SequenceNbr] TO [MSDSL]
    AS [dbo];

