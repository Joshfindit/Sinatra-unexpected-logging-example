Repository for https://github.com/sinatra/sinatra/issues/1246


## Option 1

* $ `docker-compose up`
* http://IP:3001/artefacts_broken/
* http://IP:3001/artefacts_working/


## Option 2

* $ `docker-compose run railstest irb -r ./notesapp_sinatra.rb`
* irb(main):001:0> `show_error`
