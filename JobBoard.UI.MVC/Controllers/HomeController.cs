using JobBoard.UI.MVC.Models;
using System;
using System.Net;
using System.Net.Mail;
using System.Web.Mvc;

namespace JobBoard.UI.MVC.Controllers
{
	public class HomeController : Controller
	{
		[HttpGet]
		public ActionResult Index()
		{
			return View();
		}

		[HttpGet]
		[Authorize]
		public ActionResult About()
		{
			ViewBag.Message = "Your app description page.";

			return View();
		}

		[HttpGet]
		public ActionResult Help()
		{
			return View();
		}

		[HttpPost]
		public ActionResult Help(ContactViewModel cvm)
		{
			if (!ModelState.IsValid)
			{
				return View(cvm);
			}

			string message = $"Message from: {cvm.FullName} at {cvm.Email}<br />Message: {cvm.Message}";

			MailMessage mm = new MailMessage("admin@nicholasbrokaw.com", "brokawnd@gmail.com", cvm.Subject, message)
			{
				IsBodyHtml = true,
				Priority = MailPriority.High
			};

			mm.ReplyToList.Add(cvm.Email);

			SmtpClient client = new SmtpClient("mail.nicholasbrokaw.com")
			{
				Credentials = new NetworkCredential("d1908nbrokaw", "Twinkie829604")
			};

			try
			{
				client.Send(mm);
			}catch(Exception ex)
			{
				ViewBag.ErrorMessage = ex.StackTrace;
				return View(cvm);
			}

			return RedirectToAction("Contact");
		}

		[HttpPost]
		public ActionResult BuildEmail(ContactViewModel cvm)
		{
			if (!ModelState.IsValid)
			{
				return View(cvm);
			}

			return Content("", "application/json");
		}
	}
}
