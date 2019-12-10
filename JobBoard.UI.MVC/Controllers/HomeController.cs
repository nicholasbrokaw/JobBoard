using JobBoard.UI.MVC.Models;
using JobBoard.DATA.EF;
using System;
using System.Net;
using System.Net.Mail;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;

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
		public ActionResult Help()
		{
			return View();
		}

		[HttpPost]
		[Authorize]
		[ValidateAntiForgeryToken]
		public ActionResult Help(ContactViewModel cvm)
		{
			if (!ModelState.IsValid)
			{
				return View(cvm);
			}

			JobBoardEntities db = new JobBoardEntities();

			string fullName = db.UserDetails.Find(User.Identity.GetUserId()).FullName;
			string email = User.Identity.GetUserName();

			string message = $"Message from: {fullName} at {email}<br />Message: {cvm.Message}";

			MailMessage mm = new MailMessage("sender@email.com", "recipient@email.com", cvm.Subject, message)
			{
				IsBodyHtml = true,
				Priority = MailPriority.High
			};

			mm.ReplyToList.Add(email);

			SmtpClient client = new SmtpClient("mailServer")
			{
				Credentials = new NetworkCredential("username", "password")
			};

			try
			{
				//client.Send(mm);
				TempData["demoMode"] = true;
			}
			catch (Exception ex)
			{
				ViewBag.emailError = ex;
				return View(cvm);
			}

			TempData["emailSuccess"] = true;

			return RedirectToAction("Help");
		}
	}
}
