create proc pAddRecordFieldDefinition
	    @TableName as varchar(50),
	    @DestinationTableName as varchar(50)
AS
BEGIN TRAN

   BEGIN
   INSERT INTO Record(Active,DATFileName,Module,OldRecordName,RecordDescripti,RecordName,
   User1,User2,User3,User4,User5,User6,User7,User8)
   Select 'Y','','CF','','',@DestinationTableName,'','',0,0,'','','1/1/1901','1/1/1901'
   		Insert into Field(
		Active,Caption,ControlType,DArray,DArraySize,DefaultConst,DefaultStructFld,
		DefaultStructRec,FieldName,Heading,MaskType,OldFieldName,pBlankErr,pDecimalPlaces,
		pDefaultType,pDisplayLen,pEnabled,pFalseText,pFieldClass,pFieldDclLen,pFieldDclType,
		pMaxVal,pMinVal,pTrueText,pVisible,PVParmConstant00,PVParmConstant01,PVParmConstant02,
		PVParmConstant03,PVParmField00,PVParmField01,PVParmField02,PVParmField03,PVParmRec00,
		PVParmRec01,PVParmRec02,PVParmRec03,PVParmType00,PVParmType01,PVParmType02,PVParmType03,
		RecField,RecordName,TotalPrecision,User1,User2,User3,User4,User5,User6,User7,User8)
		
		Select 'Y',Caption='',ControlType=0,DArray='N',DArraySize=0,DefaultCont='',DefaultStruct='',
		DefaultStrucRec='',FieldName=left(c.Name,20),Head='',Mask='',OldName='',Blank='N',
		pDecimalPlaces=Case t.Name when 'float' then 2 else 0 end,
		pDefaultType='N',DisplayLen=c.length,pEnable='Y',FalseText='',FieldClass=0,
		FieldLen=c.length,
 		pFieldType=Case t.name when 'float' then 2 when 'smalldatetime' then 3 else 0 end,
		pMax=0,pMin=0,pTrue='',pVisible='Y',Parm1='',parm2='',parm3='',parm4='',parm5='',parm6='',
		parm7='',parm8='',parm9='',parm10='',parm11='',parm12='',parmtyp1='N',parmtype2='N',parmtype3='N',
		parmtype4='N',
		@TableName + left(c.Name,40-len(@DestinationTableName)),
		@DestinationTableName,
		pPrecision =c.xprec,'','',0,0,'','','1/1/1901','1/1/1901'

		from syscolumns c
		JOIN systypes t on c.xusertype=t.xusertype
		WHERE (OBJECT_NAME(id) =@TableName)
		--where c.id=907371243
		and c.Name<>'tstamp'
END


COMMIT TRAN

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pAddRecordFieldDefinition] TO [MSDSL]
    AS [dbo];

