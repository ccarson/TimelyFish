
Create Proc FlexDef_SegCount @FieldClass varchar (15) as
	Select SegLength00 + SegLength01 + SegLength02 + SegLength03 + SegLength04 + SegLength05 + SegLength06 + SegLength07
	From flexdef
	Where FieldClassName = @FieldClass
