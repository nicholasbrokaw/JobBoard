using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace JobBoard.UI.MVC.Models
{
	public class ContactViewModel
	{
		[Required(ErrorMessage = "*")]
		[StringLength(100, ErrorMessage = "Value can be a maximum of 100 characters")]
		public string Subject { get; set; }

		[Required(ErrorMessage = "*")]
		public string Message { get; set; }
	}
}