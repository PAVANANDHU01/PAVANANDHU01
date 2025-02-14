
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Web_authentication_project.Models;

namespace Web_authentication_project.Controllers
{
    public class OrderController : Controller
    {
        LoginDBEntities3 d = new LoginDBEntities3();
        // GET: Order
        public ActionResult Index()
        {
            return View(d.OrderDBs.ToList());            
        }

        public ActionResult create()
        {
            ViewBag.Fooditem = new SelectList(d.FoodcatDBs, "Fooditem", "Fooditems");
            ViewBag.FoodName = new SelectList(d.MenuDBs, "Id", "items");
            return View();
        }

        [HttpPost]
        public ActionResult Create(OrderDB user)
        {
            if (ModelState.IsValid)
            {
                if (!string.IsNullOrEmpty(user.customer_name) && user.Quantity > 0)
                {
                    user.date_of_order = DateTime.Now.ToString();
                    var selectedItem = d.MenuDBs.Find(user.FoodName);
					var g = user.FoodName;
                    MenuDB S = d.MenuDBs.Find(g);
                    user.total_price = user.Quantity * S.Price_per_unit;
                    if (selectedItem != null)
                    {
                        if (selectedItem.Quantity <= 0)
                        {
                            ModelState.AddModelError("", "Stock Not Available");
                            PopulateDropdowns();
                            return View(user);
                        }
                        else if (selectedItem.Quantity < user.Quantity)
                        {
                            ModelState.AddModelError("", "Stock Available only: " + selectedItem.Quantity + " Quantity. Please enter Quantity as per stock available");
                            PopulateDropdowns();
                            return View(user);
                        }
                        else
                        {
                            selectedItem.Quantity -= user.Quantity;
                            user.total_price = user.Quantity * selectedItem.Price_per_unit;
                            user.FoodName = selectedItem.Id; // Assigning the Id of the selected food item
                            d.OrderDBs.Add(user);
                            d.SaveChanges();
                            return RedirectToAction("Index");
                        }
                    }
                }
                else
                {
                    ModelState.AddModelError("", "Please fill all the fields");
                }
            }
            PopulateDropdowns();
            return View(user);
        }


        private void PopulateDropdowns()
        {
            ViewBag.Fooditem = new SelectList(d.FoodcatDBs, "Fooditem", "Fooditems");
            ViewBag.FoodName = new SelectList(d.MenuDBs, "Id", "Items");
        }


        public ActionResult edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            MenuDB user = d.MenuDBs.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            ViewBag.Fooditem = new SelectList(d.FoodcatDBs, "Fooditem", "Fooditems");
            return View(user);
        }
        [HttpPost]
        public ActionResult edit(MenuDB user)
        {
            if (ModelState.IsValid)
            {
                ViewBag.Fooditem = new SelectList(d.FoodcatDBs, "Fooditem", "Fooditems");
                user.Total_price = user.Quantity * user.Price_per_unit;
                d.Entry(user).State = EntityState.Modified;
                d.SaveChanges();
                return RedirectToAction("foodlist");
            }
            ViewBag.Fooditem = new SelectList(d.FoodcatDBs, "Fooditem", "Fooditems");
            return View();
        }

        public ActionResult delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            OrderDB od = d.OrderDBs.Find(id);
            if (od == null)
            {
                return HttpNotFound();
            }
            return View(od);
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult deleteconfirm(int id,MenuDB menu,OrderDB order)
        {
            OrderDB od = d.OrderDBs.Find(id);            
            var F = od.FoodName;
            MenuDB p = d.MenuDBs.Find(F);
            if (d.OrderDBs.Remove(od) != null)
            {
                p.Quantity += od.Quantity;
                p.Total_price = p.Quantity * p.Price_per_unit;
            }
            d.SaveChanges();
            return RedirectToAction("Index");
        }

        //public ActionResult filter(string Fooditem = null)
        //{
        //    List<MenuDB> filteredOrders;

        //    if (Fooditem == "VEG")
        //    {
        //        filteredOrders = d.MenuDBs.Where(o => o.FoodcatDB != null && o.FoodcatDB.Fooditems == "VEG").ToList();
        //    }
        //    else if (Fooditem == "NON-VEG")
        //    {
        //        filteredOrders = d.MenuDBs.Where(o => o.FoodcatDB != null && o.FoodcatDB.Fooditems == "NON-VEG").ToList();
        //    }
        //    else
        //    {
        //        filteredOrders = d.MenuDBs.ToList();
        //    }
        //    ViewBag.FoodType = new SelectList(new[] { "All", "VEG", "NON-VEG" }, Fooditem);
        //    return View(filteredOrders);
        //} 
        public JsonResult GetFoodNames(int foodItem)
        {
            var filteredFoodNames = d.MenuDBs.Where(m => m.Fooditem == foodItem)
                                              .Select(m => new { Id = m.Id, Items = m.Items })
                                              .ToList();
            return Json(filteredFoodNames, JsonRequestBehavior.AllowGet);
        }

    }
}


