using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Mvc;
using evidence_work.Models;

namespace evidence_work.Controllers
{
    public class TourTypeController : Controller
    {
        TTMSB2DbContext db = new TTMSB2DbContext();
        // GET: TourType
        public ActionResult Index()
        {
            return View(db.TourTypes.Include(x => x.Bookings).ToList());
        }
        public ActionResult Create()
        {
            return View();
        }
        public PartialViewResult CreateTourType()
        {
            return PartialView("_CreateTourType");
        }
        [HttpPost]
        public PartialViewResult CreateTourType(TourType b)
        {
            Thread.Sleep(3000);
            if (ModelState.IsValid)
            {
                db.TourTypes.Add(b);
                db.SaveChanges();
                return PartialView("_Success");
            }
            return PartialView("_Fail");
        }
        public ActionResult Edit(int id)
        {
            ViewBag.Id = id;
            return View();
        }

        public PartialViewResult EditTourType(int id)
        {
            var b = db.TourTypes.First(x => x.TypeId == id);
            return PartialView("_EditTourType", b);
        }
        [HttpPost]
        public PartialViewResult EditTourType(TourType b)
        {
            Thread.Sleep(4000);
            if (ModelState.IsValid)
            {
                db.Entry(b).State = EntityState.Modified;
                db.SaveChanges();
                return PartialView("_Success");
            }
            return PartialView("_Fail");
        }

        [HttpPost]
        public ActionResult Delete(int id)
        {
            TourType t = new TourType() { TypeId = id };
            db.TourTypes.Remove(db.TourTypes.First(x => x.TypeId == id));
            db.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}