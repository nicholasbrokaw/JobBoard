using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using JobBoard.DATA.EF;
using Microsoft.AspNet.Identity;

namespace JobBoard.UI.MVC.Controllers
{
	public class ApplicationsController : Controller
	{
		private JobBoardEntities db = new JobBoardEntities();

		// GET: Applications
		[Authorize(Roles = "Admin, Manager, Employee")]
		public ActionResult Index(int? openPositionId)
		{
			System.Linq.IQueryable<Application> applications;
			if (User.IsInRole("Admin"))
			{
				applications = openPositionId == null ? db.Applications.Include(a => a.ApplicationStatus).Include(a => a.OpenPosition).Include(a => a.UserDetail) : db.Applications.Include(a => a.ApplicationStatus).Include(a => a.OpenPosition).Include(a => a.UserDetail).Where(a => a.OpenPositionId == openPositionId);
			}
			else if (User.IsInRole("Manager"))
			{
				string managerId = User.Identity.GetUserId();
				applications = openPositionId == null ? db.Applications.Include(a => a.ApplicationStatus).Include(a => a.OpenPosition).Include(a => a.UserDetail).Where(a => a.OpenPosition.Location.ManagerId == managerId) : db.Applications.Include(a => a.ApplicationStatus).Include(a => a.OpenPosition).Include(a => a.UserDetail).Where(a => a.OpenPosition.Location.ManagerId == managerId && a.OpenPositionId == openPositionId);
			}
			else
			{
				string employeeId = User.Identity.GetUserId();

				applications = db.Applications.Include(a => a.ApplicationStatus).Include(a => a.OpenPosition).Include(a => a.UserDetail).Where(a => a.UserId == employeeId);
			}
			return View(applications.ToList());
		}

		// GET: Applications/Details/5
		[Authorize(Roles = "Admin, Manager, Employee")]
		public ActionResult Details(int? id)
		{
			if (id == null)
			{
				return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
			}
			Application application = db.Applications.Find(id);
			if (application == null)
			{
				return HttpNotFound();
			}
			return View(application);
		}

		//// GET: Applications/Create
		//public ActionResult Create()
		//{
		//	ViewBag.ApplicationStatusId = new SelectList(db.ApplicationStatuses, "ApplicationStatusId", "StatusName");
		//	ViewBag.OpenPositionId = new SelectList(db.OpenPositions, "OpenPositionId", "OpenPositionId");
		//	ViewBag.UserId = new SelectList(db.UserDetails, "UserId", "FirstName");
		//	return View();
		//}

		// POST: Applications/Create
		// To protect from overposting attacks, please enable the specific properties you want to bind to, for 
		// more details see https://go.microsoft.com/fwlink/?LinkId=317598.
		[HttpGet]
		[Authorize(Roles = "Employee")]
		public ActionResult Apply(int openPositionId)
		{
			string userId = User.Identity.GetUserId();
			string resumeFilename = db.UserDetails.Find(userId).ResumeFilename;

			if (resumeFilename == null)
			{
				TempData["openPosition"] = openPositionId;
				return RedirectToAction("Index", "Manage");
			}

			Application application = new Application();
			application.OpenPositionId = openPositionId;
			application.UserId = userId;
			application.ApplicationDate = DateTime.Now;
			application.ApplicationStatusId = db.ApplicationStatuses.Where(s => s.StatusName.ToLower() == "pending").Select(s => s.ApplicationStatusId).Single();
			application.ResumeFilename = resumeFilename;

			db.Applications.Add(application);
			db.SaveChanges();
			return RedirectToAction("Index");

			//ViewBag.ApplicationStatusId = new SelectList(db.ApplicationStatuses, "ApplicationStatusId", "StatusName", application.ApplicationStatusId);
			//ViewBag.OpenPositionId = new SelectList(db.OpenPositions, "OpenPositionId", "OpenPositionId", application.OpenPositionId);
			//ViewBag.UserId = new SelectList(db.UserDetails, "UserId", "FirstName", application.UserId);
		}

		// GET: Applications/Edit/5
		[Authorize(Roles = "Manager")]
		public ActionResult Edit(int? id)
		{
			if (id == null)
			{
				return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
			}
			Application application = db.Applications.Find(id);
			if (application == null || User.Identity.GetUserId() != application.OpenPosition.Location.ManagerId || application.ApplicationStatusId != db.ApplicationStatuses.Where(s => s.StatusName.ToLower() == "pending").Select(s => s.ApplicationStatusId).Single())
			{
				return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
			}
			ViewBag.ApplicationStatusId = new SelectList(db.ApplicationStatuses, "ApplicationStatusId", "StatusName", application.ApplicationStatusId);
			ViewBag.OpenPositionId = new SelectList(db.OpenPositions, "OpenPositionId", "OpenPositionId", application.OpenPositionId);
			ViewBag.UserId = new SelectList(db.UserDetails, "UserId", "FirstName", application.UserId);
			return View(application);
		}

		// POST: Applications/Edit/5
		// To protect from overposting attacks, please enable the specific properties you want to bind to, for 
		// more details see https://go.microsoft.com/fwlink/?LinkId=317598.
		[HttpPost]
		[ValidateAntiForgeryToken]
		[Authorize(Roles = "Manager")]
		public ActionResult Edit([Bind(Include = "ApplicationId,OpenPositionId,UserId,ApplicationDate,ManagerNotes,ApplicationStatusId,ResumeFilename")] Application application)
		{
			if (ModelState.IsValid)
			{
				var oldApplication = db.Applications.Find(application.ApplicationId);
				if (oldApplication.ApplicationStatusId == db.ApplicationStatuses.Where(s => s.StatusName.ToLower() == "pending").Select(s => s.ApplicationStatusId).Single())
				{
					oldApplication.ManagerNotes = application.ManagerNotes;
					oldApplication.ApplicationStatusId = application.ApplicationStatusId;

					db.Entry(oldApplication).State = EntityState.Modified;
					db.SaveChanges();
				}
				return RedirectToAction("Index");
			}

			ViewBag.ApplicationStatusId = new SelectList(db.ApplicationStatuses, "ApplicationStatusId", "StatusName", application.ApplicationStatusId);
			ViewBag.OpenPositionId = new SelectList(db.OpenPositions, "OpenPositionId", "OpenPositionId", application.OpenPositionId);
			ViewBag.UserId = new SelectList(db.UserDetails, "UserId", "FirstName", application.UserId);
			return View(application);
		}

		protected override void Dispose(bool disposing)
		{
			if (disposing)
			{
				db.Dispose();
			}
			base.Dispose(disposing);
		}
	}
}
