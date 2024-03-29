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
	[Authorize(Roles = "Admin")]
	public class LocationsController : Controller
	{
		private JobBoardEntities db = new JobBoardEntities();

		// GET: Locations
		public ActionResult Index()
		{
			var locations = db.Locations.Include(l => l.UserDetail);
			return View(locations.ToList());
		}

		// GET: Locations/Details/5
		public ActionResult Details(int? id)
		{
			if (id == null)
			{
				return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
			}
			Location location = db.Locations.Find(id);
			if (location == null)
			{
				return HttpNotFound();
			}
			return View(location);
		}

		// GET: Locations/Create
		public ActionResult Create()
		{
			ViewBag.ManagerId = new SelectList(db.UserDetails.Where(x => db.AspNetUserRoles.Where(y => y.AspNetRole.Name.ToLower() == "manager").Select(y => y.UserId).Contains(x.UserId)), "UserId", "FullName");
			return View();
		}

		// POST: Locations/Create
		// To protect from overposting attacks, please enable the specific properties you want to bind to, for 
		// more details see https://go.microsoft.com/fwlink/?LinkId=317598.
		[HttpPost]
		[ValidateAntiForgeryToken]
		public ActionResult Create([Bind(Include = "LocationId,OfficeNumber,City,State,ManagerId")] Location location)
		{
			if (ModelState.IsValid)
			{
				db.Locations.Add(location);
				db.SaveChanges();
				return RedirectToAction("Index");
			}

			ViewBag.ManagerId = new SelectList(db.UserDetails.Where(x => db.AspNetUserRoles.Where(y => y.AspNetRole.Name.ToLower() == "manager").Select(y => y.UserId).Contains(x.UserId)), "UserId", "FullName", location.ManagerId);
			return View(location);
		}

		// GET: Locations/Edit/5
		public ActionResult Edit(int? id)
		{
			if (id == null)
			{
				return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
			}
			Location location = db.Locations.Find(id);
			if (location == null)
			{
				return HttpNotFound();
			}
			ViewBag.ManagerId = new SelectList(db.UserDetails.Where(x => db.AspNetUserRoles.Where(y => y.AspNetRole.Name.ToLower() == "manager").Select(y => y.UserId).Contains(x.UserId)), "UserId", "FullName", location.ManagerId);
			return View(location);
		}

		// POST: Locations/Edit/5
		// To protect from overposting attacks, please enable the specific properties you want to bind to, for 
		// more details see https://go.microsoft.com/fwlink/?LinkId=317598.
		[HttpPost]
		[ValidateAntiForgeryToken]
		public ActionResult Edit([Bind(Include = "LocationId,OfficeNumber,City,State,ManagerId")] Location location)
		{
			if (ModelState.IsValid)
			{
				db.Entry(location).State = EntityState.Modified;
				db.SaveChanges();
				return RedirectToAction("Index");
			}
			ViewBag.ManagerId = new SelectList(db.UserDetails.Where(x => db.AspNetUserRoles.Where(y => y.AspNetRole.Name.ToLower() == "manager").Select(y => y.UserId).Contains(x.UserId)), "UserId", "FullName", location.ManagerId);
			return View(location);
		}

		// TODO: Only attempt deletion if it is possible
		// GET: Locations/Delete/5
		public ActionResult Delete(int? id)
		{
			if (id == null)
			{
				return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
			}
			Location location = db.Locations.Find(id);
			if (location == null)
			{
				return HttpNotFound();
			}
			if (location.OpenPositions.Count > 0)
			{
				return new HttpStatusCodeResult(HttpStatusCode.Forbidden);
			}
			return View(location);
		}

		// POST: Locations/Delete/5
		[HttpPost, ActionName("Delete")]
		[ValidateAntiForgeryToken]
		public ActionResult DeleteConfirmed(int id)
		{
			Location location = db.Locations.Find(id);
			if (location.OpenPositions.Count > 0)
			{
				return new HttpStatusCodeResult(HttpStatusCode.Forbidden);
			}

			db.Locations.Remove(location);
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
