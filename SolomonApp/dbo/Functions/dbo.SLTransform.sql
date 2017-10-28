Create FUNCTION [dbo].[SLTransform] 
(
	@Full Varchar(50),
	@FieldClass_prm Varchar(3)
)
RETURNS Varchar(50)
AS
BEGIN
DECLARE @Formatted Varchar(50)

DECLARE @SegLength00 smallint, @SegLength01 smallint, @SegLength02 smallint, @SegLength03 smallint
DECLARE @SegLength04 smallint, @SegLength05 smallint, @SegLength06 smallint, @SegLength07 smallint
DECLARE @NumSegs smallint

DECLARE @Separator00 varchar(1), @Separator01 varchar(1), @Separator02 varchar(1), @Separator03 varchar(1)
DECLARE @Separator04 varchar(1), @Separator05 varchar(1), @Separator06 varchar(1)
Declare @ControlData as varchar(100)
if (@Fieldclass_prm = 'period')
BEGIN
-- Period
	SET @Formatted=SUBSTRING( @Full, 5, 2 ) + '-' + SUBSTRING( @Full, 1, 4 )
END
else if (@Fieldclass_prm = '114')
BEGIN
-- Project
       SELECT @ControlData = Control_Data from pjcontrl where control_type = 'FK' and control_code = 'PROJECT'
	   -- Split out the control data into the parts needed
	   -- First char is the number of segments
	   SET @NumSegs = CAST( SUBSTRING( @ControlData, 1, 1 ) as smallint )
	   --SET @NumSegs = 2
	   SET @Separator00 = SUBSTRING( @ControlData, 18, 1 )
	   SET @Separator01 = SUBSTRING( @ControlData, 18, 1 )
	   SET @Separator02 = SUBSTRING( @ControlData, 18, 1 )
	   SET @Separator03 = SUBSTRING( @ControlData, 18, 1 )
	   SET @Separator04 = SUBSTRING( @ControlData, 18, 1 )
	   SET @Separator05 = SUBSTRING( @ControlData, 18, 1 )
	   SET @Separator06 = SUBSTRING( @ControlData, 18, 1 )

	   SET @SegLength00 = CAST( SUBSTRING( @ControlData, 31, 2 ) as smallint )
	   SET @SegLength01 = CAST( SUBSTRING( @ControlData, 70, 2 ) as smallint )
	   SET @SegLength02 = CAST( SUBSTRING( @ControlData, 109, 2 ) as smallint )
	   SET @SegLength03 = CAST( SUBSTRING( @ControlData, 148, 2 ) as smallint )
	   SET @SegLength04 = CAST( SUBSTRING( @ControlData, 187, 2 ) as smallint )
	   SET @SegLength05 = CAST( SUBSTRING( @ControlData, 226, 2 ) as smallint )
	   SET @SegLength06 = CAST( SUBSTRING( @ControlData, 265, 2 ) as smallint )

--3Task            -Function    02U0FUN                    Activity    05U                        Optional    05U
END
else If ( @Fieldclass_prm =  '115' )
BEGIN
-- Task
       SELECT @ControlData = Control_Data from pjcontrl where control_type = 'FK' and control_code = 'TASK'
	   -- Split out the control data into the parts needed
	   -- First char is the number of segments
	   SET @NumSegs = CAST( SUBSTRING( @ControlData, 1, 1 ) as smallint )
	   SET @Separator00 = SUBSTRING( @ControlData, 18, 1 )
	   SET @Separator01 = SUBSTRING( @ControlData, 18, 1 )
	   SET @Separator02 = SUBSTRING( @ControlData, 18, 1 )
	   SET @Separator03 = SUBSTRING( @ControlData, 18, 1 )
	   SET @Separator04 = SUBSTRING( @ControlData, 18, 1 )
	   SET @Separator05 = SUBSTRING( @ControlData, 18, 1 )
	   SET @Separator06 = SUBSTRING( @ControlData, 18, 1 )

	   SET @SegLength00 = CAST( SUBSTRING( @ControlData, 31, 2 ) as smallint )
	   SET @SegLength01 = CAST( SUBSTRING( @ControlData, 70, 2 ) as smallint )
	   SET @SegLength02 = CAST( SUBSTRING( @ControlData, 109, 2 ) as smallint )
	   SET @SegLength03 = CAST( SUBSTRING( @ControlData, 148, 2 ) as smallint )
	   SET @SegLength04 = CAST( SUBSTRING( @ControlData, 187, 2 ) as smallint )
	   SET @SegLength05 = CAST( SUBSTRING( @ControlData, 226, 2 ) as smallint )
	   SET @SegLength06 = CAST( SUBSTRING( @ControlData, 265, 2 ) as smallint )
END
else
       SELECT @SegLength00 = SegLength00, @SegLength01 = SegLength01, @SegLength02 = SegLength02, @SegLength03 = SegLength03,
       @SegLength04 = SegLength04, @SegLength05 = SegLength05, @SegLength06 = SegLength06, @SegLength07 = SegLength07,
       @Separator00 = Seperator00, @Separator01 = Seperator01, @Separator02 = Seperator02, @Separator03 = Seperator03,
       @Separator04 = Seperator04, @Separator05 = Seperator05, @Separator06 = Seperator06,
	   @NumSegs = NumberSegments From FlexDef Where FieldClass = @FieldClass_prm

SET @Formatted =
		   CASE @NumSegs
	   	   WHEN 8 THEN
	    		RTRIM(LEFT(@Full, @SegLength00)) + @Separator00
	    		+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + 1, @SegLength01)) + @Separator01
	    		+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + @SegLength01 + 1, @SegLength02)) + @Separator02
    	 	   	+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + @SegLength01 + @SegLength02 + 1, @SegLength03)) + @Separator03
	    		+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + @SegLength01 + @SegLength02 + @SegLength03 + 1, @SegLength04)) + @Separator04
	    		+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + @SegLength01 + @SegLength02 + @SegLength03 + @SegLength04 + 1, @SegLength05)) + @Separator05
	    		+
   	    		RTRIM(SUBSTRING(@Full, @SegLength00 + @SegLength01 + @SegLength02 + @SegLength03 + @SegLength04 + @SegLength05 + 1, @SegLength06)) + @Separator06
	    		+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + @SegLength01 + @SegLength02 + @SegLength03 + @SegLength04 + @SegLength05 + @SegLength06 + 1, @SegLength07))
		   WHEN 7 THEN
	    		RTRIM(LEFT(@Full, @SegLength00)) + @Separator00
	    		+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + 1, @SegLength01)) + @Separator01
	    		+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + @SegLength01 + 1, @SegLength02)) + @Separator02
    	 	   	+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + @SegLength01 + @SegLength02 + 1, @SegLength03)) + @Separator03
	    		+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + @SegLength01 + @SegLength02 + @SegLength03 + 1, @SegLength04)) + @Separator04
	    		+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + @SegLength01 + @SegLength02 + @SegLength03 + @SegLength04 + 1, @SegLength05)) + @Separator05
	    		+
   	    		RTRIM(SUBSTRING(@Full, @SegLength00 + @SegLength01 + @SegLength02 + @SegLength03 + @SegLength04 + @SegLength05 + 1, @SegLength06)) 
	   	   WHEN 6 THEN
	    		RTRIM(LEFT(@Full, @SegLength00)) + @Separator00
	    		+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + 1, @SegLength01)) + @Separator01
	    		+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + @SegLength01 + 1, @SegLength02)) + @Separator02
    	 	   	+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + @SegLength01 + @SegLength02 + 1, @SegLength03)) + @Separator03
	    		+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + @SegLength01 + @SegLength02 + @SegLength03 + 1, @SegLength04)) + @Separator04
	    		+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + @SegLength01 + @SegLength02 + @SegLength03 + @SegLength04 + 1, @SegLength05)) 
	   	   WHEN 5 THEN
	    		RTRIM(LEFT(@Full, @SegLength00)) + @Separator00
	    		+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + 1, @SegLength01)) + @Separator01
	    		+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + @SegLength01 + 1, @SegLength02)) + @Separator02
    	 	   	+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + @SegLength01 + @SegLength02 + 1, @SegLength03)) + @Separator03
	    		+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + @SegLength01 + @SegLength02 + @SegLength03 + 1, @SegLength04)) 
	   	   WHEN 4 THEN
	    		RTRIM(LEFT(@Full, @SegLength00)) + @Separator00
	    		+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + 1, @SegLength01)) + @Separator01
	    		+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + @SegLength01 + 1, @SegLength02)) + @Separator02
    	 	   	+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + @SegLength01 + @SegLength02 + 1, @SegLength03))
	   	   WHEN 3 THEN
	    		RTRIM(LEFT(@Full, @SegLength00)) + @Separator00
	    		+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + 1, @SegLength01)) + @Separator01
	    		+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + @SegLength01 + 1, @SegLength02))
	   	   WHEN 2 THEN
	    		RTRIM(LEFT(@Full, @SegLength00)) + @Separator00
	    		+
	    		RTRIM(SUBSTRING(@Full, @SegLength00 + 1, @SegLength01)) 
	   	   ELSE --One segment, no unused segments possible
	    		RTRIM(LEFT(@Full, @SegLength00))

		END  -- CASE @NumSegs

RETURN (@Formatted)
END

