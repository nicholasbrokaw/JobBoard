﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using JobBoard.DATA.EF;

namespace JobBoard.UI.MVC.Controllers
{
	public class ApplicationStatusesController : Controller
	{
		private JobBoardEntities db = new JobBoardEntities();

		// GET: ApplicationStatus
		[Authorize(Roles = "Admin, Manager")]
		public ActionResult Index()
		{
			return View(db.ApplicationStatuses.ToList());
		}

		// GET: ApplicationStatus/Create
		[Authorize(Roles = "Admin")]
		public ActionResult Create()
		{
			return View();
		}

		// POST: ApplicationStatus/Create
		// To protect from overposting attacks, please enable the specific properties you want to bind to, for 
		// more details see https://go.microsoft.com/fwlink/?LinkId=317598.
		[HttpPost]
		[ValidateAntiForgeryToken]
		[Authorize(Roles = "Admin")]
		public ActionResult Create([Bind(Include = "ApplicationStatusId,StatusName,Description")] ApplicationStatus applicationStatus)
		{
			if (ModelState.IsValid)
			{
				db.ApplicationStatuses.Add(applicationStatus);
				db.SaveChanges();
				return RedirectToAction("Index");
			}

			return View(applicationStatus);
		}

		// GET: ApplicationStatus/Edit/5
		[Authorize(Roles = "Admin")]
		public ActionResult Edit(int? id)
		{
			if (id == null)
			{
				return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
			}
			ApplicationStatus applicationStatus = db.ApplicationStatuses.Find(id);
			if (applicationStatus == null)
			{
				return HttpNotFound();
			}
			return View(applicationStatus);
		}

		// POST: ApplicationStatus/Edit/5
		// To protect from overposting attacks, please enable the specific properties you want to bind to, for 
		// more details see https://go.microsoft.com/fwlink/?LinkId=317598.
		[HttpPost]
		[ValidateAntiForgeryToken]
		[Authorize(Roles = "Admin")]
		public ActionResult Edit([Bind(Include = "ApplicationStatusId,StatusName,Description")] ApplicationStatus applicationStatus)
		{
			if (ModelState.IsValid)
			{
				db.Entry(applicationStatus).State = EntityState.Modified;
				db.SaveChanges();
				return RedirectToAction("Index");
			}
			return View(applicationStatus);
		}

		// GET: ApplicationStatus/Delete/5
		[Authorize(Roles = "Admin")]
		public ActionResult Delete(int? id)
		{
			if (id == null)
			{
				return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
			}
			ApplicationStatus applicationStatus = db.ApplicationStatuses.Find(id);
			if (applicationStatus == null)
			{
				return HttpNotFound();
			}
			if (applicationStatus.Applications.Count > 0 || applicationStatus.StatusName.ToLower() == "pending")
			{
				return new HttpStatusCodeResult(HttpStatusCode.Forbidden);
			}
			return View(applicationStatus);
		}

		// POST: ApplicationStatus/Delete/5
		[HttpPost, ActionName("Delete")]
		[ValidateAntiForgeryToken]
		[Authorize(Roles = "Admin")]
		public ActionResult DeleteConfirmed(int id)
		{
			ApplicationStatus applicationStatus = db.ApplicationStatuses.Find(id);
			if (applicationStatus.Applications.Count > 0 || applicationStatus.StatusName.ToLower() == "pending")
			{
				return new HttpStatusCodeResult(HttpStatusCode.Forbidden);
			}

			db.ApplicationStatuses.Remove(applicationStatus);
			db.SaveChanges();
			return RedirectToAction("Index");
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
