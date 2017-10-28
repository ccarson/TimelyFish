 Create Proc  GLTran_LastGLBatNbr_All as
Select * from GLTran
where Module  =  'GL'
order by Module DESC, BatNbr DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLTran_LastGLBatNbr_All] TO [MSDSL]
    AS [dbo];

