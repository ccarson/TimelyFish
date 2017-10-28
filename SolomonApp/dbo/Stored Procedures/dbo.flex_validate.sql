
CREATE PROC flex_validate @fieldclassname VARCHAR (15), 
                          @Flex_Data VARCHAR (30)
AS

/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-2001 All Rights Reserved
*
*    Proc Name: flex_validate
*
*++* Narrative: Creates a list of dependencies in tree form for a given proc or view.
*               This program does not report dependencies across databases
*
*    Inputs   : fieldclass_name VARCHAR (15)   type of flex being validated (ie. 'VENDORID') 
*               flex_data	VARCHAR (30)   String being validate (ie. 'VT100')
*
*    Outputs  : 1 row Recordset as follows
*               Flex_Valid      	VARCHAR (1)     Y/N for passes/does not pass validation respectively
*               @Masked_Flex_Data       VARCHAR (30)    Returns upper cased data
*               @Message                INT             Returns messages number based on error		
*							Returns 0 as Valid
*
*                
*   Called by: Common functions dll
* 
*/
SET NOCOUNT ON
-- Declare variables
DECLARE @Flex_Valid VARCHAR (1)
DECLARE @Masked_Flex_Data CHAR (30)
DECLARE @MessageNum INT
DECLARE @LengthArray Char(16)
DECLARE @MaskArray Char(8)
DECLARE @FillArray Char(8)
DECLARE @ValidArray Char(8)
DECLARE @TotalLength INT
DECLARE @NumSegments INT
DECLARE @PTR         INT
DECLARE @ThisSeg     INT
DECLARE @ThisLength     INT

-- INTIALIZE Variables
SET @Flex_Valid = 'Y' 
SELECT @Masked_Flex_Data = UPPER(@Flex_data)
SET @MessageNum = 0
SET @PTR = 1       -- Pointer to the actual char position currently being examined
SET @ThisSeg = 1   -- FlexKey Segment number currently be examined


/** Store Segment info in arrays*/
SELECT @LengthArray = CONVERT(Char(2),SegLength00)+ CONVERT(Char(2),SegLength01)+ CONVERT(Char(2),SegLength02)+ 
              CONVERT(Char(2),SegLength03)+ CONVERT(Char(2),SegLength04)+ CONVERT(Char(2),SegLength05)+ 
              CONVERT(Char(2),SegLength06)+ CONVERT(Char(2),SegLength07),
       @MaskArray =  EditMask00 + EditMask01 + EditMask02 + EditMask03 +
                       EditMask04 + EditMask05 + EditMask06 + EditMask07,
       @FillArray =  FillChar00 + FillChar01 + FillChar02 + FillChar03 +
                       FillChar04 + FillChar05 + FillChar06 + FillChar07,
      @ValidArray = CONVERT(Char(1 ),Validate00)+ CONVERT(Char(1),Validate01)+ CONVERT(Char(1),Validate02)+ 
             CONVERT(Char(1),Validate03)+ CONVERT(Char(1),Validate04)+ CONVERT(Char(1),Validate05)+ 
             CONVERT(Char(1),Validate06)+ CONVERT(Char(1),Validate07),
       @TotalLength = SegLength00 + SegLength01 + SegLength02 + SegLength03 +
                       SegLength04 + SegLength05 + SegLength06 + SegLength07, 
       @NumSegments = NumberSegments
  FROM FlexDef
 WHERE FieldClassName = @FieldClassName

-- Check NotFound to make sure a valid fieldclassname was passed
IF @@ROWCOUNT = 0 OR @@ERROR <> 0 
       GOTO ERROUT

/* 1st Verify total length, Total length must be verified against a varchar since chars always
    return the space-padded total length of the field */
IF DATALENGTH(@Flex_Data) > @TotalLength
   BEGIN
       SET @MessageNum = 12342
       SET @Flex_Valid = 'N'
       GOTO ENDIT
    END

/* Step through each segment */
WHILE @ThisSeg <= @NumSegments 
  BEGIN
      SELECT @ThisLength = CONVERT(INT,SUBSTRING(@LengthArray,((@ThisSeg-1)*2)+1,2))

      -- If Validate is checked, 1st check against valid values table
      IF (SELECT SUBSTRING(@ValidArray,@ThisSeg,1)) = '1'
        BEGIN
          IF (SELECT COUNT(*) FROM SEGDEF
                        WHERE FieldClassName = @FieldClassName
                          AND CONVERT(INT,SegNumber)      = @ThisSeg
                          AND ID = SubString(@Masked_Flex_Data,@Ptr,@Thislength)) = 0
            BEGIN
              SET @MessageNum = 12344
              SET @Flex_Valid = 'N'
              GOTO ENDIT
            END
            IF @@ERROR <> 0 GOTO ErrOut
        END 
      
      -- Loop through each character in this segment
      WHILE @ThisLength > 0
        BEGIN
            -- Verify Each Character is valid for mask
            IF SubString(@MaskArray,@ThisSeg,1) = 'U'   --ASCII (excluding lowercase alpha)                                        
                 OR SubString(@MaskArray,@ThisSeg,1) = 'Q' --ASCII with question mark mask is supported like ASCII
               BEGIN
                  IF ASCII(SUBSTRING(@Masked_Flex_Data,@Ptr,1)) NOT BETWEEN 32 and 96 
                        AND ASCII(SUBSTRING(@Masked_Flex_Data,@Ptr,1)) NOT BETWEEN 123 AND 127
                    BEGIN
                      SET @MessageNum = 12343
                      SET @Flex_Valid = 'N'
                      GOTO ENDIT
                    END
               END
           IF SubString(@MaskArray,@ThisSeg,1) = '9'   --Numeric
               BEGIN
                  IF ASCII(SUBSTRING(@Masked_Flex_Data,@Ptr,1)) NOT BETWEEN 48 and 57
                    BEGIN
                      SET @MessageNum = 12343
                      SET @Flex_Valid = 'N'
                      GOTO ENDIT
                    END
               END
           IF SubString(@MaskArray,@ThisSeg,1) = 'V'   --Alpha UpperCase
               BEGIN
                  IF ASCII(SUBSTRING(@Masked_Flex_Data,@Ptr,1)) NOT BETWEEN 65 and 90
                    BEGIN    
                       IF @PTR <= DATALENGTH(@Flex_Data)
                                     -- do not check trailing spaces if fill is space
                          BEGIN
                             SET @MessageNum = 12343
                             SET @Flex_Valid = 'N'
                             GOTO ENDIT
                          END
                    END
               END
           IF SubString(@MaskArray,@ThisSeg,1) = 'W'   --AlphaNumeric (alpha is upper only)
               BEGIN
                  IF (ASCII(SUBSTRING(@Masked_Flex_Data,@Ptr,1)) NOT BETWEEN 48 and 57 
                        AND ASCII(SUBSTRING(@Masked_Flex_Data,@Ptr,1)) NOT BETWEEN 65 AND 90)
                    BEGIN
                      IF @PTR <= DATALENGTH(@Flex_Data) OR SubString(@FillArray,@ThisSeg,1) <> 'B' 
                                 -- do not check trailing spaces if fill is space
                          BEGIN
                             SET @MessageNum = 12343
                             SET @Flex_Valid = 'N'
                             GOTO ENDIT
                          END
                    END
               END
           SET @ThisLength = @ThisLength - 1 
           SET @Ptr = @Ptr + 1
         END
       SET @ThisSeg = @ThisSeg + 1     
    END

GOTO ENDIT

-- Error Handler for Fatal/SQL errors
ErrOut:
SET @MessageNum = 501
SET @Flex_Valid = 'N'
 
-- Return message
Endit:
Select @Flex_Valid, @Masked_Flex_Data, @MessageNum



GO
GRANT CONTROL
    ON OBJECT::[dbo].[flex_validate] TO [MSDSL]
    AS [dbo];

