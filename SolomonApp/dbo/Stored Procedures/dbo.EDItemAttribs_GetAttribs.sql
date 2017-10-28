 Create Proc EDItemAttribs_GetAttribs @InvtId varchar(30) As
Select Attrib00, Attrib01, Attrib02, Attrib03, Attrib04, Attrib05, Attrib06, Attrib07,
Attrib08, Attrib09 From ItemAttribs Where InvtId = @InvtId


