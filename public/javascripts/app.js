$(document).ready(function() {

  $('#join-meetup').click(function(event) {

    event.preventDefault();
    if($(this).text() === 'Join!') {
      joinMeetup();
      $(this).text('Joined!');
    } else {
      unjoinMeetup();
      $(this).text('Join!');
    }


  });

});

function joinMeetup() {
}

function unjoinMeetup() {
}
