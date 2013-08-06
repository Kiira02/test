using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.UI.WebControls;
using InetMagazLibrary;

namespace MvcApplication10.Models
{
    [DefaultProperty("Text")]
    [ToolboxData("<{0}:AdminMain runat=server></{0}:AdminMain>")]
    public class AdminMain : WebControl
    {
        public DataTable GetData()
        {
            var context = new InetMagazDBDataContext(ConfigurationManager.ConnectionStrings["MyBase"].ConnectionString);

            DataTable dt = new DataTable();
            // define the table's schema
            dt.Columns.Add(new DataColumn("ID", typeof(int)));
            dt.Columns.Add(new DataColumn("Name", typeof(string)));
            dt.Columns.Add(new DataColumn("Password", typeof(string)));
            dt.Columns.Add(new DataColumn("Emai", typeof(string)));
            dt.Columns.Add(new DataColumn("isAdmin", typeof(string)));
            // Create the records

            foreach (var item in context.Users)
            {
                DataRow dr = dt.NewRow();
                dr["ID"] = Convert.ToInt32(item.ID);
                dr["Name"] = item.Name;
                dr["Password"] = item.Password;
                dr["Emai"] = item.Emai;
                dr["isAdmin"] = item.isAdmin;
                dt.Rows.Add(dr);
            }
            dt.DefaultView.Sort = "ID ASC";
            dt = dt.DefaultView.ToTable();
            return dt;
        }

    }

    public class GameAddModel
    {
        [Required]
        [Display(Name = "Game name:")]
        public string GameName { get; set; }

        [Required]
        [Display(Name = "Game Description:")]
        public string GameDescription { get; set; }

        [Required]
        [Display(Name = "Image Url:")]
        public string ImageUrl { get; set; }

        [Required]
        [Display(Name = "Game Price:")]
        public string GamePrice { get; set; }

        [Required]
        [Display(Name = "User Name:")]
        public string UserName { get; set; }

        [Required]
        [Display(Name = "User Password:")]
        public string UserPassword { get; set; }

        [Required]
        [Display(Name = "User Email:")]
        public string UserEmail { get; set; }

        [Required]
        [Display(Name = "Credit Card:")]
        public string CreditCard { get; set; }

        [Required]
        public bool GamesList { get; set; }
    }
}
