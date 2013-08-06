using System;
using System.Web.Mvc;
using MvcApplication10.Models;

namespace MvcApplication10.Controllers
{
    public class DatabaseController : Controller
    {
        //
        // GET: /Database/
        public ActionResult Index()
        {
            return null;
        }

        [HttpPost]
        public ActionResult LogOn(user user)
        {
            Main main = new Main();
            return Json(main.LogOn(user.email, user.password));
        }

        [HttpPost]
        public ActionResult Register(user user)
        {
            Main main = new Main();
            return Json(main.Register(user.name, user.email, user.password));
        }

        [HttpPost]
        public ActionResult GetProducts()
        {
            Main main = new Main();
            return Json(main.GetProducts());
        }

        [HttpPost]
        public ActionResult SearchForProducts(user user)
        {
            Main main = new Main();
            return Json(main.SearchForProducts(user.name));
        }

        [HttpPost]
        public ActionResult AutoLogin(user user)
        {
            Main main = new Main();
            return Json(main.AutoLogin(user.ID));
        }

        [HttpPost]
        public ActionResult AddToHistory(user user)
        {
            Main main = new Main();
            return Json(main.AddToHistory(user.GameId, user.UserId));
        }

    }

    [Serializable]
    public class user
    {
        public string ID { get; set; }
        public string name { get; set; }
        public string email { get; set; }
        public string password { get; set; }
        public string GameId { get; set; }
        public string UserId { get; set; }
    }
}
