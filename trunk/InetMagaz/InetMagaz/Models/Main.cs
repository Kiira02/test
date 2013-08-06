using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using InetMagazLibrary;

namespace MvcApplication10.Models
{
    [DefaultProperty("Text")]
    [ToolboxData("<{0}:Main runat=server></{0}:Main>")]
    public class Main : WebControl
    {


        private const string ConnectionName = "MyBase";

        private string GetDatabaseConnection(string name)
        {
            ConnectionStringSettings settings = ConfigurationManager.ConnectionStrings[name];
            string conn = settings.ConnectionString;
            return conn;
        }

        public List<Dictionary<string, string>> GetProducts()
        {
            List<Dictionary<string, string>> products = new List<Dictionary<string, string>>();

            var context = new InetMagazDBDataContext(ConfigurationManager.ConnectionStrings["MyBase"].ConnectionString);

            foreach (var item in context.Products)
            {
                Dictionary<string, string> tovar = new Dictionary<string, string>();
                tovar.Add("Name", item.Name);
                tovar.Add("ProductID", item.ProductID.ToString());
                tovar.Add("Description", item.Description);
                tovar.Add("ImageUrl", item.ImageUrl);
                tovar.Add("Price", item.Price.ToString());
                products.Add(tovar);
            }

            return products;
        }

        public int SearchForProducts(string Name)
        {
            var context = new InetMagazDBDataContext(ConfigurationManager.ConnectionStrings["MyBase"].ConnectionString);
            var result = -1;
            foreach (var item in context.Search(Name))
            {
                result = Convert.ToInt32(item.RESULT);
            }
            return result;
        }

        public AuthorizationData LogOn(string email, string password)
        {
            var connectionString = GetDatabaseConnection(ConnectionName);
            AuthorizationData data = new AuthorizationData();
            
            using (var conn = new SqlConnection(connectionString))
            using (var command = new SqlCommand("GetUser", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@Email", email);
                command.Parameters.AddWithValue("@Password", password);
                conn.Open();
                SqlDataReader reader = command.ExecuteReader();

                int id = -1;
                string name = "";

                while (reader.Read())
                {
                    // 0 - Id row
                    // 1 - Name row
                    id = reader.GetInt32(0);
                    name = reader.GetString(1);
                }
                conn.Close();



                if (id == -1)
                {
                    data.Status = false;

                }
                else
                {
                    data.Status = true;
                    data.userName = name;
                    data.userId = id;
                    data.userEmail = email;
                }
            }
            return data;
        }

        public AuthorizationData Register(string name, string email, string password)
        {
            var connectionString = GetDatabaseConnection(ConnectionName);
            AuthorizationData data = new AuthorizationData();

            using (var conn = new SqlConnection(connectionString))
            using (var command = new SqlCommand("InsertUser", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@UserName", name);
                command.Parameters.AddWithValue("@Email", email);
                command.Parameters.AddWithValue("@Password", password);
                var returnParameter = command.Parameters.Add("@ReturnVal", SqlDbType.Int);
                returnParameter.Direction = ParameterDirection.ReturnValue;
                conn.Open();
                command.ExecuteNonQuery();
                var result = Convert.ToBoolean(returnParameter.Value);
                conn.Close();

                if (result == false)
                {
                    data.Status = false;
                }
                else
                {
                    data.Status = true;
                }
            }
            return data;
        }

        public AuthorizationAuto AutoLogin(string iDuser)
        {
            var connectionString = GetDatabaseConnection(ConnectionName);
            AuthorizationAuto data = new AuthorizationAuto();
            
            using (var conn = new SqlConnection(connectionString))
            using (var command = new SqlCommand("AutoLogin", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@ID", Convert.ToInt32(iDuser));
                conn.Open();
                SqlDataReader reader = command.ExecuteReader();

                int id = -1;
                string name = "";

                while (reader.Read())
                {
                    id = reader.GetInt32(0);
                    name = reader.GetString(1);
                }
                conn.Close();

                data.UserName = name;
                data.UserId = id;
            }
            return data;
        }

        public History AddToHistory(string gameId, string userId)
        {
            var connectionString = GetDatabaseConnection(ConnectionName);
            History data = new History();
            using (var conn = new SqlConnection(connectionString))
            using (var command = new SqlCommand("InsertHistory", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@productId", gameId);
                command.Parameters.AddWithValue("@userId", userId);
                conn.Open();
                command.ExecuteNonQuery();
                conn.Close();
            }
            return data;
        }
        
    }

    public class GetProducts
    {
        public string Description { get; set; }
        public int ProductID { get; set; }
        public string Name { get; set; }
        public string ImageUrl { get; set; }
    }

    [Serializable]
    public class AuthorizationData
    {
        public bool Status;
        public string userName;
        public int userId;
        public string userEmail;
    }

    [Serializable]
    public class AuthorizationAuto
    {
        public string UserName;
        public int UserId;
    }

    [Serializable]
    public class History
    {
        public int GameId;
        public int UserId;
    }

}
