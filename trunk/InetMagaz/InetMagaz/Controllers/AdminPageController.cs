using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using InetMagazLibrary;
using MvcApplication10.Models;

namespace MvcApplication10.Controllers
{
    public class AdminPageController : Controller
    {
        //
        // GET: /AdminPage/
        public ActionResult Index()
        {
            if (Request.Cookies["ID"] != null) {
                return View();
            } else {
                return RedirectToAction("Login", "Account");
            }
        }

        private const string ConnectionName = "MyBase";

        private string GetDatabaseConnection(string name)
        {
            ConnectionStringSettings settings = ConfigurationManager.ConnectionStrings[name];
            string conn = settings.ConnectionString;
            return conn;
        }

        [HttpPost]
        public ActionResult Index(string button, GameAddModel model, HttpPostedFileBase image)
        {
            var connectionString = GetDatabaseConnection(ConnectionName);
            AuthorizationData data = new AuthorizationData();
            using (var conn = new SqlConnection(connectionString))

            switch (button)
            {
                case "Add User":
                    using (var command = new SqlCommand("InsertUser", conn) { CommandType = CommandType.StoredProcedure })
                    {
                        command.Parameters.AddWithValue("@UserName", model.UserName);
                        command.Parameters.AddWithValue("@Email", model.UserEmail);
                        command.Parameters.AddWithValue("@Password", model.UserPassword);
                        var returnParameter = command.Parameters.Add("@ReturnVal", SqlDbType.Int);
                        returnParameter.Direction = ParameterDirection.ReturnValue;
                        conn.Open();
                        command.ExecuteNonQuery();
                        var result = Convert.ToBoolean(returnParameter.Value);
                        conn.Close();

                        if (result == false) {
                            data.Status = false;
                        } else {
                            data.Status = true;
                        }
                    }
                    if (data.Status == true) {
                        ModelState.AddModelError("", "The user with this email already exist.");
                        return View(model);
                    }
                    break;
                case "Add Game":
                    string path = @"C:\1\IMZ\trunk\InetMagaz\InetMagaz\Content\Images\";

                    if (image != null) image.SaveAs(path + image.FileName);

                    string saveToBaseUrl = "./Content/Images/";

                    using (var command = new SqlCommand("InsertGame", conn) { CommandType = CommandType.StoredProcedure })
                    {
                        command.Parameters.AddWithValue("@Name", model.GameName);
                        command.Parameters.AddWithValue("@Description", model.GameDescription);
                        command.Parameters.AddWithValue("@ImageUrl", (saveToBaseUrl + image.FileName));
                        command.Parameters.AddWithValue("@Price", Convert.ToInt32(model.GamePrice));
                        conn.Open();
                        command.ExecuteNonQuery();
                        conn.Close();
                    }
                    break;
            }
            return View();
        }
    }
}
