using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Newtonsoft.Json;
using NuGet.DependencyResolver;
using System.Text;
using GoOne06.Models;  // This directive was added
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;

namespace GoOne06.Pages
{
    public class EditTrackerModel : PageModel
    {
        private readonly IHttpClientFactory _clientFactory;

        public EditTrackerModel(IHttpClientFactory clientFactory)
        {
            _clientFactory = clientFactory;
            var client = _clientFactory.CreateClient("TrackerClient");
            Tracker = new TrackerItem();
        }

        [BindProperty]
        public TrackerItem? Tracker { get; set; }

        [BindProperty]
        public List<TrackerEvent> TrackerEvents { get; set; }

        public async Task OnGetAsync(int id)
        {
            var client = _clientFactory.CreateClient("TrackerClient");

            // Fetch the TrackerItem
            var trackerResponse = await client.GetAsync($"/api/tracker/{id}");
            if (trackerResponse.IsSuccessStatusCode)
            {
                var trackerJsonContent = await trackerResponse.Content.ReadAsStringAsync();
                Tracker = JsonConvert.DeserializeObject<TrackerItem>(trackerJsonContent);
            }

            // Fetch the associated TrackerEvents
            var eventsResponse = await client.GetAsync($"/api/tracker/{id}/events");
            if (eventsResponse.IsSuccessStatusCode)
            {
                var eventsJsonContent = await eventsResponse.Content.ReadAsStringAsync();
                TrackerEvents = JsonConvert.DeserializeObject<List<TrackerEvent>>(eventsJsonContent);
            }
        }

        public async Task<IActionResult> OnPostAsync()
        {
            if (ModelState.IsValid)
            {
                var client = _clientFactory.CreateClient("TrackerClient");

                var jsonContent = JsonConvert.SerializeObject(Tracker);
                Console.WriteLine(jsonContent);
                var content = new StringContent(jsonContent, Encoding.UTF8, "application/json");

                if (Tracker == null)
                {
                    ModelState.AddModelError(string.Empty, "Tracker is null.");
                    return Page();
                }

                var response = await client.PutAsync($"/api/tracker/{Tracker.IdTrackerItem}", content);

                if (response.IsSuccessStatusCode)
                {
                    return RedirectToPage("/Trackers", new { id = Tracker.IdTrackerItem });
                }
                else
                {
                    ModelState.AddModelError(string.Empty, "Failed to update tracker.");
                }
            }

            return Page();
        }
    }
}
