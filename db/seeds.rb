# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).


### MEETUPS ###

meetups = ["Tampflex", "Konklux", "Y-find", "Voyatouch", "Duobam"]
descriptions = ["Corrupti illum quis dolor sunt ipsam similique. Placeat facilis ut magnam hic excepturi sed. Sunt labore et. Quidem quod et itaque voluptates tempore enim.",
 "Aspernatur ipsam deserunt perspiciatis est voluptatem labore architecto. Sequi reprehenderit sint sint. Earum sapiente provident enim. Nam distinctio voluptates nesciunt et sed. Non enim est.",
 "Et animi quia. Quisquam et accusantium culpa. Assumenda tempora voluptatem voluptas porro consequuntur.",
 "Aut aut consequatur quis et dignissimos. Atque accusamus autem aliquid. Quidem tempore aut consectetur eos quae aut expedita. Nisi rerum tenetur sint.",
 "Quo minima ratione corrupti architecto pariatur. Eaque nobis laborum optio sequi in. Et ipsam dolorem magni laborum ad ex. Laborum quia voluptatem. Quia provident accusantium similique iusto id."]

5.times do |i|
  Meetup.create(
    user_id: i + 1,
    name: meetups[i],
    description: descriptions[i]
  )
end
