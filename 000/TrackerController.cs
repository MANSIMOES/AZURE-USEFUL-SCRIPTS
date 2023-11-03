using Microsoft.AspNetCore.Mvc;
using GoOne06.Models;  // Replace with the namespace where your DbContext is located
using System.Linq;
using NuGet.DependencyResolver;
using System.Globalization;

[Route("api/[controller]")]
[ApiController]
public class TrackerController : ControllerBase
{
    private readonly TrackingDbContext _context;

    public TrackerController(TrackingDbContext context)
    {
        _context = context;
    }

    [HttpGet("statusbreakdown")]
    public IActionResult GetStatusBreakdown()
    {
        var statusBreakdown = _context.Trackers
            .GroupBy(t => t.TrackerStatus)
            .Select(g => new
            {
                Status = g.Key,
                Count = g.Count()
            }).ToList();

        return Ok(statusBreakdown);
    }

    [HttpGet("{id}")]
    public IActionResult GetTrackerById(int id)
    {
        var trackerItem = _context.Trackers.Find(id);
        if (trackerItem == null)
        {
            return NotFound();
        }
        return Ok(trackerItem);
    }

    [HttpPut("{id}")]
    public IActionResult UpdateTracker(int id, [FromBody] TrackerItem tracker)
    {
        var trackerItem = _context.Trackers.Find(id);
        if (trackerItem == null)
        {
            return NotFound();
        }

        // Update the tracker item with the new details
        trackerItem.TrackerSummary = tracker.TrackerSummary;
        trackerItem.TrackerReminderPolicy = tracker.TrackerReminderPolicy;
        trackerItem.TrackerEndDate = tracker.TrackerEndDate;
        trackerItem.TrackerFirstRegistered = tracker.TrackerFirstRegistered;
        trackerItem.TrackerStatus = tracker.TrackerStatus;

        _context.SaveChanges();

        return NoContent();  // Return a 204 No Content response on success
    }

    [HttpGet("{id}/events")]
    public IActionResult GetTrackerEvents(int id)
    {
        // Check if the tracker exists first
        var trackerExists = _context.Trackers.Any(t => t.IdTrackerItem == id);
        if (!trackerExists)
        {
            return NotFound($"Tracker with ID {id} not found.");
        }

        // Fetch the related events for the given tracker ID
        var hasEvents = _context.TrackerEvents.Any(te => te.IdTrackerItem == id);

        if (!hasEvents)
        {
            return NotFound($"No events found for tracker with ID {id}.");
        }

        var trackerEvents = _context.TrackerEvents.Where(te => te.IdTrackerItem == id).ToList();

        return Ok(trackerEvents);
    }

    [HttpPut("{trackerId}/events/{eventId}")]
    public IActionResult UpdateTrackerEvent(int trackerId, int eventId, [FromBody] TrackerEvent updatedEvent)
    {
        var trackerItem = _context.Trackers.Find(trackerId);
        if (trackerItem == null)
        {
            return NotFound();
        }

        // Fetch the specific event for the tracker using both the tracker ID and the event ID
        var currentEvent = _context.TrackerEvents.FirstOrDefault(te => te.IdTrackerItem == trackerId && te.IdTrackerEvent == eventId);
        if (currentEvent != null)
        {
            // Update properties of the current event using the updated event details
            currentEvent.EventDate = updatedEvent.EventDate;
            currentEvent.Description = updatedEvent.Description;
            // Add other properties as needed

            _context.SaveChanges();
        }
        else
        {
            // There was no existing event for the given event ID, return an error
            return NotFound("Event not found for the given event ID.");
        }

        return NoContent();  // Return a 204 No Content response on success
    }



    [HttpPost("UpdateTrackerEvent")]
    public IActionResult UpdateTrackerEvent([FromBody] TrackerEventUpdateRequest request)
    {
        // Find the specific TrackerEvent by ID
        var trackerEvent = _context.TrackerEvents.Find(request.Id);
        if (trackerEvent == null)
        {
            return NotFound("TrackerEvent not found.");
        }

        try
        {
            switch (request.Column)
            {
                case 1:  // Assuming column 1 corresponds to EventDate
                    trackerEvent.EventDate = DateTime.ParseExact(request.Value, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                    break;
                case 2:  // Assuming column 2 corresponds to Description
                    if (!string.IsNullOrWhiteSpace(request.Value) && request.Value.Length <= 255)  // Assuming a max length of 255 for description
                    {
                        trackerEvent.Description = request.Value;
                    }
                    else
                    {
                        return BadRequest("Invalid description value.");
                    }
                    break;
                // Add more cases if there are more columns to update
                default:
                    return BadRequest("Invalid column index.");
            }

            _context.SaveChanges();
            return Ok();
        }
        catch (Exception ex)
        {
            // Log the exception
            return StatusCode(500, "Internal server error");
        }
    }


    [HttpPost("TrackerEvent")]
    public IActionResult AddTrackerEvent([FromBody] TrackerEvent trackerEvent)
    {
        if (trackerEvent == null)
        {
            return BadRequest("Invalid data.");
        }

        _context.TrackerEvents.Add(trackerEvent);
        _context.SaveChanges();

        return Ok(new { Message = "TrackerEvent added successfully." });
    }


    [HttpDelete("TrackerEvents")]
    public IActionResult DeleteTrackerEvents([FromBody] List<int> idsToDelete)
    {
        if (idsToDelete == null || idsToDelete.Count == 0)
        {
            return BadRequest("Invalid data.");
        }

        var trackerEventsToDelete = _context.TrackerEvents.Where(te => idsToDelete.Contains(te.IdTrackerEvent)).ToList();

        _context.TrackerEvents.RemoveRange(trackerEventsToDelete);
        _context.SaveChanges();

        return Ok(new { Message = "TrackerEvents deleted successfully." });
    }


}

