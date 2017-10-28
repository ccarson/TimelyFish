using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.IO;
using QRCode;
using System.Drawing;

public partial class UserDefinedFunctions
{
    [Microsoft.SqlServer.Server.SqlFunction]
    public static SqlBinary EncodeQR(String value)
    {
        MemoryStream ms = new MemoryStream();
        QRCodeEncoder QRCode = new QRCodeEncoder()
        {
            QRCodeVersion = 0
        };
        Bitmap qrImage;
        try
        {
            QRCode.QRCodeEncodeMode = QRCodeEncoder.ENCODE_MODE.ALPHA_NUMERIC;
            qrImage = QRCode.Encode(value);
        }
        catch (Exception x1)
        {
            throw new Exception("Encoding Exception", x1);
        }
        try
        {
            qrImage.Save(ms, System.Drawing.Imaging.ImageFormat.Bmp);
        }
        catch (Exception x2)
        {
            throw new Exception("Image Save Exception", x2);
        }
        return ms.ToArray();
    }
}
