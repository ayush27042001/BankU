using System;
using System.Web;
using System.IO;

namespace NeoXPayout
{
    /// <summary>
    /// Summary description for SaveImageHandler
    /// </summary>
    public class SaveImageHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            string json;
            using (var reader = new StreamReader(context.Request.InputStream))
            {
                json = reader.ReadToEnd();
            }

            // Extract base64 image string
            var imageBase64 = json.Split(new[] { "\"image\":\"" }, StringSplitOptions.None)[1];
            imageBase64 = imageBase64.Split('"')[0]
                                     .Replace("data:image/png;base64,", "")
                                     .Replace(" ", "+");

            byte[] bytes = Convert.FromBase64String(imageBase64);

            string fileName = $"UserPhoto_{DateTime.Now.Ticks}.png";
            string folderPath = context.Server.MapPath("~/CapturedImages/");
            Directory.CreateDirectory(folderPath);

            string filePath = Path.Combine(folderPath, fileName);
            File.WriteAllBytes(filePath, bytes);

            context.Response.Write("CapturedImages/" + fileName); // return relative path
        }

        public bool IsReusable { get { return false; } }
    }
}