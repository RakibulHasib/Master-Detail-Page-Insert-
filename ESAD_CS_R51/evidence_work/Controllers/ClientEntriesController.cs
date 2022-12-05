using evidence_work.Models;
using evidence_work.ViewModel;
using System;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Web.Mvc;

namespace evidence_work.Controllers
{
    public class ClientEntriesController : Controller
    {
        private readonly TTMSB2DbContext db = new TTMSB2DbContext();
        // GET: ClientEntries
        public ActionResult Index()
        {
            var data = db.Clients
                .Include(x => x.EntrySpots.Select(y => y.Booking))
                .ToList();

            return View(data.OrderByDescending(x => x.ClientId).ToList());
        }
        public ActionResult Create()
        {
            ViewBag.Bookings = db.Bookings.ToList();
            var data = new BookingEntryInputModel();
            data.Bookings.Add(new BookingViewModel());
            return View(data);
        }

        [HttpPost]
        public ActionResult Create(BookingEntryInputModel model, int[] BookingId)
        {
            if (ModelState.IsValid)
            {
                var et = new Client
                {
                    ClientName = model.ClientName,
                    Age = model.Age,
                    BirthDate = model.BirthDate,
                };
                foreach (var x in BookingId)
                {
                    et.EntrySpots.Add(new EntrySpot { BookingId = x });
                }
                if (model.Picture.ContentLength > 0)
                {
                    string ext = Path.GetExtension(model.Picture.FileName);
                    string fileName = Guid.NewGuid() + ext;
                    model.Picture.SaveAs(Path.Combine(Server.MapPath("~/Uploads"), fileName));
                    et.Picture = fileName;
                }
                db.Clients.Add(et);
                db.SaveChanges();
            }
            ViewBag.Bookings = db.Bookings.ToList();
            return PartialView("_Success");
        }

        public JsonResult GetFee(int id)
        {
            var t = db.Bookings.FirstOrDefault(x => x.BookingId == id);
            return Json(t == null ? 0 : t.Fee);
        }

        public ActionResult CreateNewField(BookingEntryInputModel data)
        {
            ViewBag.Bookings = db.Bookings.ToList();
            data.Bookings.Add(new BookingViewModel());
            return PartialView(data);
        }
        public PartialViewResult CreateClientEntry()
        {
            ViewBag.Bookings = db.Bookings.ToList();

            return PartialView("_BookingEntry");
        }
    }
}