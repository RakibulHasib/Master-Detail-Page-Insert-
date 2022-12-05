using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using System.Threading;
using evidence_work.Models;

namespace evidence_work.Controllers
{
    public class BookingController : Controller
    {
        TTMSB2DbContext db = new TTMSB2DbContext();
        // GET: Booking
        public ActionResult Index()
        {
            return View(db.Bookings.Include(t1 => t1.TourType).ToList());
        }
        public ActionResult Create()
        {
            return View();
        }
        public PartialViewResult CreateBooking()
        {
            ViewBag.TourTypes = db.TourTypes;
            return PartialView("_CreateBooking");
        }

        [HttpPost]
        public PartialViewResult CreateBooking(Booking b)
        {
            Thread.Sleep(3000);
            if (ModelState.IsValid)
            {
                db.Bookings.Add(b);
                db.SaveChanges();
                return PartialView("_Success");
            }
            ViewBag.TourTypes = db.TourTypes;
            return PartialView("_Fail");
        }
        public ActionResult Edit(int id)
        {
            ViewBag.TourTypes = db.TourTypes;
            ViewBag.Id = id;
            return View();
        }
        public PartialViewResult EditBooking(int id)
        {
            ViewBag.TourTypes = db.TourTypes;
            var b = db.Bookings.First(x => x.BookingId == id);
            return PartialView("_EditBooking", b);
        }

        [HttpPost]
        public PartialViewResult EditBooking(Booking b)
        {
            Thread.Sleep(4000);
            if (ModelState.IsValid)
            {
                db.Entry(b).State = EntityState.Modified;
                db.SaveChanges();
                return PartialView("_Success");
            }
            ViewBag.TourTypes = db.TourTypes;
            return PartialView("_Fail");
        }
        public ActionResult Delete(int id)
        {
            Booking b = new Booking() { BookingId = id };
            db.Bookings.Remove(db.Bookings.First(x => x.BookingId == id));
            db.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}