$(document).ready(function() {

  $('#join-meetup').click(function(event) {
    event.preventDefault();

    meetup_id = $(this).attr('value')


    if($(this).text() === 'Join!') {
      joinMeetup(meetup_id);
    } else {
      leaveMeetup(meetup_id);
    }
  });
});

function toggleButton() {
  var button = $('#join-meetup');
  var text = button.text() === 'Join!' ? 'Leave Meetup' : 'Join!';
  button.text(text);
}

/// FIX ALL THIS ///

function joinMeetup(meetup_id) {
  $.ajax({
    method: 'POST',
    url: '/meetups_join.json',
    data: { meetup_id: meetup_id }
  })
  .done(function(attendee) {
    toggleButton();
    addAttendeeElem(attendee);
  });
}

function leaveMeetup(meetup_id) {
  $.ajax({
    method: 'POST',
    url: '/meetups_leave.json',
    data: { meetup_id: meetup_id }
  })
  .done(function(attendee) {
    toggleButton();
    deleteAttendeeElem(attendee.id);
  });
}

function addAttendeeElem(attendee) {
  $('#attendees').append(
    "<li userid="+attendee.id+">" +
      "<img class='avatar' src="+attendee.avatar_url+"><br />" +
      attendee.username +
    "</li>"
  );
}


function deleteAttendeeElem(user_id) {
    $("[userid='" + user_id + "']").remove();
}
