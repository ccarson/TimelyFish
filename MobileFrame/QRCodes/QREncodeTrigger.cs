using System;
using System.Data;
using System.Data.SqlClient;
using Microsoft.SqlServer.Server;

public partial class Triggers
{
    // Enter existing table or view for the target and uncomment the attribute line
    [SqlTrigger(Name = @"QREncode", Target = "[dbo].[CFT_ANIMALTAG]", Event = "FOR INSERT, UPDATE")]
    public static void QREncodeTrigger()
    {
        SqlCommand command;
        SqlTriggerContext triggContext = SqlContext.TriggerContext;
        SqlPipe pipe = SqlContext.Pipe;
       

        switch (triggContext.TriggerAction)
        {
            case TriggerAction.Insert:
                // Retrieve the connection that the trigger is using  
                using (SqlConnection connection = new SqlConnection(@"context connection=true"))
                {
                    connection.Open();
                    command = new SqlCommand(@"Update [dbo].[CFT_ANIMALTAG] SET QRCODE = dbo.EncodeQR(t.TagNBR) FROM [dbo].[CFT_ANIMALTAG] t JOIN Inserted d on t.ID=d.ID;", connection);
                    pipe.Send(command.CommandText);
                    command.ExecuteNonQuery();
                }

                break;

            case TriggerAction.Update:
                // Retrieve the connection that the trigger is using  
                using (SqlConnection connection = new SqlConnection(@"context connection=true"))
                {
                    connection.Open();
                    //SqlCommand cmd = new SqlCommand("select top 0 * from [dbo].[CFT_ANIMALTAG]", connection);
                    //SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SchemaOnly);
                    //int columnOrdinal = dr.GetOrdinal("TAGNBR");
                    //dr.Close();
                    //if (SqlContext.TriggerContext.IsUpdatedColumn(columnOrdinal))
                    //{
                        command = new SqlCommand(@"Update [dbo].[CFT_ANIMALTAG] SET QRCODE = dbo.EncodeQR(t.TagNBR) FROM [dbo].[CFT_ANIMALTAG] t JOIN Inserted I on t.ID=I.ID inner join deleted D (nolock) on D.id = I.id where (D.tagNbr <> I.tagNbr or D.QRCODE is null) and d.PRIMARYTAG = 1;", connection);
                        pipe.Send(command.CommandText);
                        command.ExecuteNonQuery();
                    //}
                    //else
                    //{
                    //    pipe.Send("tagNbr was not updated: ");
                    //}
                }

                break;

        }
    }
}

