$("document").ready(function() {

  $("#add_new_animal_button").on(
    "click",
    function() {
      // Data to be submitted
      newAnimal = {
        // create the animal object
        "animal": {
          // the animal has a common_name
          "common_name": $("#common_name").val(),
          // the animal has a latin_name
          "latin_name": $("#latin_name").val(),
          // the animal has a kingdom
          "kingdom": $("#kingdom").val(),
        }
      } // end new_animal variable
      // create the Ajax call.
      $.ajax({
        // tell the server that we are talking JSON
        dataType: 'json',
        // tell the server what resource to retrieve
        url: '/animals',
        // the HTTP method to store information on the server
        method: 'POST',
        // data to be sent. In this case it is the newWine object that was created
        data: newAnimal,
        // call this function if call to server was successful
        success: function(dataFromServer) {
          add_to_animal_table(dataFromServer)
        },
        // call this function if call to server was not successful
        error: function(jqXHR, textStatus, errorThrown) {
          alert("Add new animal failed: " + errorThrown);
        }
      });// end ajax
  });// end add animal
  // resets the form so it displays empty
  // $("#new_animal_form").reset();

  // add new sighting to the animal
  $("#add_new_sighting_button").on(
    "click",
    function() {
      // Data to be submitted
      newSighting = {
        // create the animal object
        "sighting": {
          // the sighting has a date
          "date": $("#date").val(),
          // the sighting has a time
          "time": $("#time").val(),
          // the sighting has a latitude
          "latitude": $("#latitude").val(),
          // the sighting has a longitude
          "longitude": $("#longitude").val(),
          // the sighting has a region
          "region": $("#region").val(),
        }
      } // end  new_sighting variable
      // create the Ajax call.
      $.ajax({
        // tell the server that we are talking JSON
        dataType: 'json',
        // tell the server what resource to retrieve
        url: '/animals/',
        // the HTTP method to store information on the server
        method: 'POST',
        // data to be sent. In this case it is the newWine object that was created
        data: newSighting,
        // call this function if call to server was successful
        success: function(dataFromServer) {
          add_to_sighting_table(dataFromServer)
        },
        // call this function if call to server was not successful
        error: function(jqXHR, textStatus, errorThrown) {
          alert("Add new sighting failed: " + errorThrown);
        }
      });// end ajax
  });// end add sighting
  // resets the form so it displays empty
  // $("#new_sighting_form").reset();
}); // end document ready

// Function to be called after animal data has been successfully submitted
function add_to_animal_table(data) {
  $("#animal_table tr:last").after(
    '<td>' + data.common_name + '</td>' +
    '<td>' + data.latin_name + '</td>' +
    '<td>' + data.kingdom + '</td>' +
    '<td><a href="' + '/animals/' + data.id + '">' + 'Show' + "</a></td>" +
    '<td><a href="' + '/animals/' + data.id + '/edit' + '">' + 'Edit' + "</a></td>"
    );
};

// Function to be called after animal data has been successfully submitted
function add_to_sighting_table(data) {
  $("#sighting_table tr:last").after(
    '<td>' + data.date + '</td>' +
    '<td>' + data.time + '</td>' +
    '<td>' + data.latitude + '</td>' +
    '<td>' + data.longitude + '</td>' +
    '<td>' + data.region + '</td>' +
    '<td><a href="' + '/sightings/' + data.id + '/edit' + '">' + 'Edit' + "</a></td>"
    );
};
