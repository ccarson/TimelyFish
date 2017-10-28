 CREATE Proc EDPackIndicator_ItemAndGlobal @InvtId varchar(30) As
Select PackIndicator, Description From EDPackIndicator Where InvtId = @InvtId Or
(InvtId = '*' And PackIndicator Not In (Select PackIndicator From EDPackIndicator Where
InvtId = @InvtId))


