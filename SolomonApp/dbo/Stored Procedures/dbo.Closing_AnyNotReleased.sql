 create proc Closing_AnyNotReleased @module VARCHAR(2)As
DECLARE @Badcount FLOAT
select @Badcount = 0
BEGIN
  SELECT  @BadCount = count(*)
    FROM batch
   WHERE @Module = Module
     AND status in ('I','S')
     AND editscrnnbr <> '04010'
END

IF @BadCount > 0
   GOTO FINISH

select @badcount = CASE @Module
   WHEN 'GL' THEN (SELECT count(*)
                  FROM batch b, GLSetup S
                  WHERE @Module = Module
                   AND B.PerPost <= S.PerNbr
                   AND status in ('B','H')
                   AND BatType not in('M', 'R'))
   WHEN 'AP' THEN (SELECT count(*)
                   FROM batch b, APSetup S
                   WHERE @Module = Module
                   AND B.PerPost <= S.PerNbr
                   AND status in ('B','H')
                   AND BatType not in('M', 'R'))
   WHEN 'AR' THEN (SELECT count(*)
                   FROM batch b, ARSetup S
                   WHERE @Module = Module
                   AND B.PerPost <= S.PerNbr
                   AND status in ('B','H')
                   AND BatType not in('M', 'R'))
   WHEN 'IN' THEN (SELECT count(*)
                   FROM batch b, INSetup S
                  WHERE @Module = Module
                   AND B.PerPost <= S.PerNbr
                   AND status in ('B','H')
                   AND BatType not in('M', 'R'))
   WHEN 'PO' THEN (SELECT count(*)
                   FROM batch b, APSetup S
                  WHERE @Module = Module
                   AND B.PerPost <= S.PerNbr
                   AND status in ('B','H')
                   AND BatType not in('M', 'R'))
   WHEN 'CA' THEN (SELECT count(*)
                   FROM batch b, CASetup S
                  WHERE @Module = Module
                   AND B.PerPost <= S.PerNbr
                   AND status in ('B','H')
                   AND BatType not in('M', 'R'))
End

FINISH:

Select @BadCount


