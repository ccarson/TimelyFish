 CREATE Proc EDInunit_CnvFact_MultDiv  @Parm1 varchar(30), @Parm2 varchar(6), @Parm3 varchar(6) As
--get stock wt for item
declare @stkwtUnit varchar(6)
Select @StkWtUnit = StkWtUnit from Inventory where Invtid = @parm1
If IsNull(@StkWtUnit,'~') = '~'
--if you dont find a stkwt for the item then assume that the stkwtunit is the same as the from unit
 Set @StkWtUnit = @Parm3
Select CnvFact, MultDiv From InUnit Where InvtId In (@Parm1, '*') And ClassId In (@Parm2, '*') And
FromUnit = @Parm3 And ToUnit = @StkWtUnit Order By UnitType Desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInunit_CnvFact_MultDiv] TO [MSDSL]
    AS [dbo];

