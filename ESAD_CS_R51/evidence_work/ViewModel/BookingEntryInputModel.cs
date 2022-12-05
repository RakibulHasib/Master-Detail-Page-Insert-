using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace evidence_work.ViewModel
{
    public class BookingEntryInputModel
    {
        [Display(Name = "Client Id")]
        public int ClientId { get; set; }
        [Required, StringLength(50), Display(Name = "Client Name")]
        public string ClientName { get; set; }
        [Required, Display(Name = "Picture")]
        public HttpPostedFileBase Picture { get; set; }
        [Required, Display(Name = "Age"),]
        public int Age { get; set; }

        [Required, DataType(DataType.Date), Display(Name = "Birth Date"), DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime BirthDate { get; set; }
        public List<BookingViewModel> Bookings { get; set; } = new List<BookingViewModel>();
    }
}