using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace JobBoard.DATA.EF
{
	public class ApplicationMetadata
	{
		[Required(ErrorMessage = "*")]
		public int OpenPositionId { get; set; }

		[Required(ErrorMessage = "*")]
		[StringLength(128, ErrorMessage = "Value can be a maximum of 128 characters")]
		public string UserId { get; set; }

		[Required(ErrorMessage = "*")]
		public System.DateTime ApplicationDate { get; set; }

		[StringLength(2000, ErrorMessage = "Value can be a maximum of 2000 characters")]
		[UIHint("MultilineText")]
		public string ManagerNotes { get; set; }

		[Required(ErrorMessage = "*")]
		public int ApplicationStatusId { get; set; }

		[Required(ErrorMessage = "*")]
		[StringLength(75, ErrorMessage = "Filename can be a maximum of 75 characters")]
		public string ResumeFilename { get; set; }
	}

	[MetadataType(typeof(ApplicationMetadata))]
	public partial class Application { }

	public class ApplicationStatusMetadata
	{
		[Required(ErrorMessage = "*")]
		[StringLength(50, ErrorMessage = "Value can be a maximum of 50 characters")]
		public string StatusName { get; set; }

		[StringLength(250, ErrorMessage = "Value can be a maximum of 250 characters")]
		[DisplayFormat(NullDisplayText = "n/a")]
		public string Description { get; set; }
	}

	[MetadataType(typeof(ApplicationStatusMetadata))]
	public partial class ApplicationStatus { }

	public class LocationMetadata
	{
		[Required(ErrorMessage = "*")]
		[StringLength(10, ErrorMessage = "Value can be a maximum of 10 characters")]
		public string OfficeNumber { get; set; }

		[Required(ErrorMessage = "*")]
		[StringLength(50, ErrorMessage = "Value can be a maximum of 50 characters")]
		public string City { get; set; }

		[Required(ErrorMessage = "*")]
		[StringLength(2, MinimumLength = 2, ErrorMessage = "Value must be 2 characters (e.g. \"KS\" for \"Kansas\")")]
		public string State { get; set; }

		[Required(ErrorMessage = "*")]
		[StringLength(128, ErrorMessage = "Value can be a maximum of 128 characters")]
		public string ManagerId { get; set; }
	}

	public partial class Location { }

	public class OpenPositionMetadata
	{
		[Required(ErrorMessage = "*")]
		public int PositionId { get; set; }

		[Required(ErrorMessage = "*")]
		public int LocationId { get; set; }
	}

	[MetadataType(typeof(OpenPositionMetadata))]
	public partial class OpenPosition { }

	public class PositionMetadata
	{
		[Required(ErrorMessage = "*")]
		[StringLength(50, ErrorMessage = "Value can be a maximum of 50 characters")]
		public string Title { get; set; }

		[UIHint("MultilineText")]
		[DisplayFormat(NullDisplayText = "There is no description for this position.")]
		public string Description { get; set; }
	}

	[MetadataType(typeof(PositionMetadata))]
	public partial class Position { }

	public class UserDetailMetadata
	{
		[Required(ErrorMessage = "*")]
		[StringLength(50, ErrorMessage = "Value can be a maximum of 50 characters")]
		public string FirstName { get; set; }

		[Required(ErrorMessage = "*")]
		[StringLength(50, ErrorMessage = "Value can be a maximum of 50 characters")]
		public string LastName { get; set; }

		[StringLength(75, ErrorMessage = "Value can be a maximum of 75 characters")]
		[DisplayFormat(NullDisplayText = "n/a")]
		public string ResumeFilename { get; set; }
	}

	[MetadataType(typeof(UserDetailMetadata))]
	public partial class UserDetail { }

}
