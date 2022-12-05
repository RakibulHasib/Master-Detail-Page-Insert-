using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace evidence_work.ViewModel
{
    public class BookingViewModel
    {
        [Required]
        public int BookingId { get; set; }
        [Display(Name = "Spot Price")]
        public decimal Fee { get; set; }
    }
}