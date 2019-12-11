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
		public ActionResult Index(int? positionId)
		{
			string managerId = User.IsInRole("Manager") ? User.Identity.GetUserId() : null;
			List<OpenPosition> openPositions;
			if (positionId != null)
			{
				openPositions = !User.IsInRole("Manager") ? db.OpenPositions.Include(o => o.Location).Include(o => o.Position).Where(o => o.PositionId == positionId).ToList() : db.OpenPositions.Include(o => o.Location).Include(o => o.Position).Where(o => o.Location.ManagerId == managerId && o.PositionId == positionId).ToList();
			}
			else
			{
				openPositions = !User.IsInRole("Manager") ? db.OpenPositions.Include(o => o.Location).Include(o => o.Position).ToList() : db.OpenPositions.Include(o => o.Location).Include(o => o.Position).Where(o => o.Location.ManagerId == managerId).ToList();
			}

			return View(openPositions);
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
				ViewBag.LocationId = new SelectList(db.Locations.Where(l => l.ManagerId == managerId), "LocationId", "FullSummary");
			}
			else
			{
				ViewBag.LocationId = new SelectList(db.Locations, "LocationId", "FullSummary");
			}
			ViewBag.PositionId = new SelectList(db.Positions, "PositionId", "Title");
			return View();
		}

		[Authorize(Roles = "Admin, Manager")]
		public ActionResult CreateFor(int positionId, bool isFetch)
		{
			if (isFetch)
			{
				string managerId = User.Identity.GetUserId();
				int managerLocationId = db.Locations.Where(m => m.ManagerId == managerId).Select(l => l.LocationId).Single();

				OpenPosition openPosition = new OpenPosition() { PositionId = positionId, LocationId = managerLocationId };

				db.OpenPositions.Add(openPosition);
				db.SaveChanges();

				return Content("{\"success\": true}", "application/json");
			}
			else
			{
				OpenPosition openPosition = new OpenPosition() { PositionId = positionId };
				ViewBag.LocationId = new SelectList(db.Locations, "LocationId", "FullSummary");
				ViewBag.PositionId = new SelectList(db.Positions, "PositionId", "Title", openPosition.PositionId);

				return View("Create", openPosition);
			}
		}

		//[Authorize(Roles = "Admin")]
		//public ActionResult Create(int positionId, string managerId)
		//{
		//	int managerLocationId = db
		//	return Content("{\"success\": true}", "application/json");
		//}

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
					int managerLocationId = db.Locations.Where(m => m.ManagerId == managerId).Select(l => l.LocationId).Single();
					openPosition.LocationId = managerLocationId;
				}
				db.OpenPositions.Add(openPosition);
				db.SaveChanges();
				return RedirectToAction("Index");
			}

			if (User.IsInRole("Manager"))
			{
				string managerId = User.Identity.GetUserId();
				ViewBag.LocationId = new SelectList(db.Locations.Where(l => l.ManagerId == managerId), "LocationId", "FullSummary", openPosition.LocationId);
			}
			else
			{
				ViewBag.LocationId = new SelectList(db.Locations, "LocationId", "FullSummary", openPosition.LocationId);
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
			if (openPosition.Applications.Count > 0)
			{
				return new HttpStatusCodeResult(HttpStatusCode.Forbidden);
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
			if (openPosition.Applications.Count > 0)
			{
				return new HttpStatusCodeResult(HttpStatusCode.Forbidden);
			}

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
