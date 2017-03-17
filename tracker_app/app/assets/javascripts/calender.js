$(document).ready(function() {
   $("#calendar").fullCalendar({
     events: "/sightings/get_events",
     timeFormat: "LT"
  });
});
