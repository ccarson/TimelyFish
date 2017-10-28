Create Procedure dbo.cfpIssue_IssueID
	@IssueID varchar (10) 
	as
    	Select * from cftIssue
	Where IssueId Like @IssueID 
	Order by IssueId


GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfpIssue_IssueID] TO [MSDSL]
    AS [dbo];

