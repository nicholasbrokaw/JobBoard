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
	public class OpenPositionsController : Controller
	{

		private JobBoardEntities db = new JobBoardEntities();

		// GET: OpenPositions
		[Authorize(Roles = "Admin, Manager, Employee")]
		public ActionResult Index()
		{
			string managerId = User.IsInRole("Manager") ? User.Identity.GetUserId() : null;
			var openPositions = !User.IsInRole("Manager") ? db.OpenPositions.Include(o => o.Location).Include(o => o.Position) : db.OpenPositions.Include(o => o.Location).Include(o => o.Position).Where(o => o.Location.ManagerId == managerId);
			return View(openPositions.ToList());
		}

		// GET: OpenPositions/Details/5
		[Authorize(Roles = "Admin, Manager, Employee")]
		public ActionResult Details(int? id)
		{
			if (id == null)
			{
				return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
			}
			OpenPosition openPosition = db.OpenPositions.Find(id);
			if (openPosition == null | (User.IsInRole("Manager") && openPosition.Location.ManagerId != User.Identity.GetUserId()))
			{
				return HttpNotFound();
			}
			return View(openPosition);
		}

		// GET: OpenPositions/Create
		[Authorize(Roles = "Admin, Manager")]
		public ActionResult Create()
		{
			if (User.IsInRole("Manager"))
			{
				string managerId = User.Identity.GetUserId();
				ViewBag.LocationId = new SelectList(db.Locations.Where(l => l.ManagerId == managerId), "LocationId", "OfficeNumber");
			}
			else
			{
				ViewBag.LocationId = new SelectList(db.Locations, "LocationId", "OfficeNumber");
			}
			ViewBag.PositionId = new SelectList(db.Positions, "PositionId", "Title");
			return View();
		}

		// POST: OpenPositions/Create
		// To protect from overposting attacks, please enable the specific properties you want to bind to, for 
		// more details see https://go.microsoft.com/fwlink/?LinkId=317598.
		[HttpPost]
		[ValidateAntiForgeryToken]
		[Authorize(Roles = "Admin, Manager")]
		public ActionResult Create([Bind(Include = "OpenPositionId,PositionId,LocationId")] OpenPosition openPosition)
		{
			if (ModelState.IsValid)
			{
				if (User.IsInRole("Manager"))
				{
					string managerId = User.Identity.GetUserId();
					int managerLocation = db.Locations.Where(m => m.ManagerId == managerId).Select(l => l.LocationId).Single();
					openPosition.LocationId = managerLocation;
				}
				db.OpenPositions.Add(openPosition);
				db.SaveChanges();
				return RedirectToAction("Index");
			}

			if (User.IsInRole("Manager"))
			{
				string managerId = User.Identity.GetUserId();
				ViewBag.LocationId = new SelectList(db.Locations.Where(l => l.ManagerId == managerId), "LocationId", "OfficeNumber", openPosition.LocationId);
			}
			else
			{
				ViewBag.LocationId = new SelectList(db.Locations, "LocationId", "OfficeNumber", openPosition.LocationId);
			}
			ViewBag.PositionId = new SelectList(db.Positions, "PositionId", "Title", openPosition.PositionId);
			return View(openPosition);
		}

		// GET: OpenPositions/Edit/5
		[Authorize(Roles = "Admin, Manager")]
		public ActionResult Edit(int? id)
		{
			if (id == null)
			{
				return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
			}
			OpenPosition openPosition = db.OpenPositions.Find(id);
			if (openPosition == null | (User.IsInRole("Manager") && openPosition.Location.ManagerId != User.Identity.GetUserId()))
			{
				return HttpNotFound();
			}
			if (User.IsInRole("Manager"))
			{
				string managerId = User.Identity.GetUserId();
				ViewBag.LocationId = new SelectList(db.Locations.Where(l => l.ManagerId == managerId), "LocationId", "OfficeNumber", openPosition.LocationId);
			}
			else
			{
				ViewBag.LocationId = new SelectList(db.Locations, "LocationId", "OfficeNumber", openPosition.LocationId);
			}
			ViewBag.PositionId = new SelectList(db.Positions, "PositionId", "Title", openPosition.PositionId);
			return View(openPosition);
		}

		// POST: OpenPositions/Edit/5
		// To protect from overposting attacks, please enable the specific properties you want to bind to, for 
		// more details see https://go.microsoft.com/fwlink/?LinkId=317598.
		[HttpPost]
		[ValidateAntiForgeryToken]
		[Authorize(Roles = "Admin, Manager")]
		public ActionResult Edit([Bind(Include = "OpenPositionId,PositionId,LocationId")] OpenPosition openPosition)
		{
			if (ModelState.IsValid)
			{
				if (User.IsInRole("Manager"))
				{
					if (db.Locations.Where(l => l.LocationId == openPosition.LocationId).Single().ManagerId == User.Identity.GetUserId())
					{
						db.Entry(openPosition).State = EntityState.Modified;
						db.SaveChanges();
					}
				}
				else
				{
					db.Entry(openPosition).State = EntityState.Modified;
					db.SaveChanges();
				}
				return RedirectToAction("Index");
			}
			if (User.IsInRole("Manager"))
			{
				string managerId = User.Identity.GetUserId();
				ViewBag.LocationId = new SelectList(db.Locations.Where(l => l.ManagerId == managerId), "LocationId", "OfficeNumber", openPosition.LocationId);
			}
			else
			{
				ViewBag.LocationId = new SelectList(db.Locations, "LocationId", "OfficeNumber", openPosition.LocationId);
			}
			ViewBag.PositionId = new SelectList(db.Positions, "PositionId", "Title", openPosition.PositionId);
			return View(openPosition);
		}

		// GET: OpenPositions/Delete/5
		[Authorize(Roles = "Admin, Manager")]
		public ActionResult Delete(int? id)
		{
			if (id == null)
			{
				return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
			}
			OpenPosition openPosition = db.OpenPositions.Find(id);
			if (openPosition == null | (User.IsInRole("Manager") && openPosition.Location.ManagerId != User.Identity.GetUserId()))
			{
				return HttpNotFound();
			}
			return View(openPosition);
		}

		// POST: OpenPositions/Delete/5
		[HttpPost, ActionName("Delete")]
		[ValidateAntiForgeryToken]
		[Authorize(Roles = "Admin, Manager")]
		public ActionResult DeleteConfirmed(int id)
		{
			OpenPosition openPosition = db.OpenPositions.Find(id);
			if (User.IsInRole("Manager"))
			{
				if (openPosition.Location.ManagerId == User.Identity.GetUserId())
				{
					db.OpenPositions.Remove(openPosition);
					db.SaveChanges();
				}
			}
			else
			{
				db.OpenPositions.Remove(openPosition);
				db.SaveChanges();
			}
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
