document.addEventListener("DOMContentLoaded", async function () {
    var ctx = document.getElementById('statusPieChart').getContext('2d');

    // Fetch data from the server
    const serverData = await fetchData();
    console.log(serverData);

    // Extract labels and data from the API response
    const labels = serverData.map((item) => item.status);
    const data = serverData.map((item) => item.count);

    // Define a function to generate distinct colors
    function generateColors(count) {
        // ... (same as before)
    }

    // Generate distinct colors based on the number of unique statuses
    const backgroundColors = generateColors(labels.length);

    // Create the data object with dynamic background colors
    const chartData = {
        labels: labels,
        datasets: [
            {
                data: data,
                backgroundColor: backgroundColors,
            },
        ],
    };

    var pieChart = new Chart(ctx, {
        type: 'pie',
        data: chartData,
        options: {
            tooltips: {
                callbacks: {
                    label: function (tooltipItem, data) {
                        var dataset = data.datasets[tooltipItem.datasetIndex];
                        var total = dataset.data.reduce((previousValue, currentValue) => previousValue + currentValue);
                        var currentValue = dataset.data[tooltipItem.index];
                        var percentage = Math.floor(((currentValue / total) * 100) + 0.5);
                        return `${data.labels[tooltipItem.index]}: ${percentage}%`;
                    }
                }
            }
        }
    });



    element.addEventListener('blur', function (event) {
        const oldValue = event.target.getAttribute('data-old-value');
        const newValue = event.target.textContent;

        if (oldValue !== newValue) {
            // Update the database using AJAX
            updateDatabase(event.target.closest('tr').querySelector('input[name="selectedTrackerEvents"]').value, event.target.cellIndex, newValue);

            // Update the old value data attribute
            event.target.setAttribute('data-old-value', newValue);
        }
    });
});

async function fetchData() {
    try {
        const response = await fetch('/api/tracker/statusbreakdown');
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    } catch (error) {
        console.log("There was a problem with the fetch operation:", error.message);
        // Handle the error or display a message to the user here
    }
}

function generateColors(count) {
    const colors = [];
    for (let i = 0; i < count; i++) {
        const hue = (i * 360) / count;
        const saturation = 70; // Adjust as needed
        const lightness = 60; // Adjust as needed
        const color = `hsl(${hue}, ${saturation}%, ${lightness}%)`;
        colors.push(color);
    }
    return colors;
}

function toggleMenu() {
    var verticalMenu = document.querySelector('.vertical-menu');
    var contentWrapper = document.querySelector('.content-wrapper');
    var collapseIcon = document.querySelector('#collapseIcon');

    if (verticalMenu.classList.contains('collapsed')) {
        verticalMenu.classList.remove('collapsed');
        contentWrapper.style.marginLeft = '250px'; // Adjust the width as needed
        collapseIcon.classList.remove('fa-arrow-right'); // Remove right arrow class
        collapseIcon.classList.add('fa-arrow-left'); // Add left arrow class
    } else {
        verticalMenu.classList.add('collapsed');
        contentWrapper.style.marginLeft = '0';
        collapseIcon.classList.remove('fa-arrow-left'); // Remove left arrow class
        collapseIcon.classList.add('fa-arrow-right'); // Add right arrow class
    }
}


async function updateDatabase(id, columnIndex, newValue) {
    const eventId = parseInt(id, 10);
    const data = {
        EventDate: columnIndex === 1 ? newValue : undefined,
        Description: columnIndex === 2 ? newValue : undefined
    };

    try {
        const response = await fetch(`/api/Tracker/events/${eventId}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });

        if (!response.ok) {
            const responseData = await response.json();  // Assuming the server returns a JSON with error details
            console.error("Error updating database:", responseData.message || "Unknown error");
            alert('Failed to update the database.');
        }
    } catch (error) {
        console.error("Network error:", error);
        alert('Network error while updating the database.');
    }
}




