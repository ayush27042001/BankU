using System;
using NeoXPayout.Models;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;

namespace NeoXPayout.Controllers
{
    public class FileUploadingController : ApiController
    {
        [HttpPost]
        [Route("api/FileUploading/UploadFile")]
        public async Task<LoginModel> UploadFile()
        {
            LoginModel Res = new LoginModel();
            var ctx = HttpContext.Current;
            var root = ctx.Server.MapPath("~/productpic");
            var provider =
                new MultipartFormDataStreamProvider(root);

            try
            {
                await Request.Content
                    .ReadAsMultipartAsync(provider);

                foreach (var file in provider.FileData)
                {
                    DateTime dtNow = DateTime.Now;
                    Random r = new Random();
                    string n = r.Next(1, 1000).ToString();

                    var name = file.Headers
                        .ContentDisposition
                        .FileName;

                    name = name.Trim('"');

                    var localFileName = file.LocalFileName;
                    var filePath = Path.Combine(root, name);
                    FileInfo fi = new FileInfo(name);
                    string extn = fi.Extension;
                    if (extn.ToLower() == ".jpeg" || extn.ToLower() == ".png" || extn.ToLower() == ".pdf" || extn.ToLower() == ".jpg")
                    {
                        File.Move(localFileName, filePath);
                        Res.Status = "SUCCESS";
                        Res.Message = "File Uploaded Successfully";
                        Res.Data = "/productpic/" + name;
                    }
                    else
                    {
                        Res.Status = "ERR";
                        Res.Message = "Transaction Failed";
                        Res.Data = "Please choose valid file";
                    }
                }
            }
            catch (Exception e)
            {
                Res.Status = "ERR";
                Res.Message = e.Message;
                Res.Data = e.Message;
            }
            return Res;
        }        
    }
}
