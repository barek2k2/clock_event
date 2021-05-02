# README
* Online viewable at https://clock-event.herokuapp.com/

### My approaches
* I built the clock event entry application and ensured sequential events happens.
  An user should not able to clock out before clock in and should not be able to clock in before clock out next time
* For an editable event, the time should not be greater than next event and should not be less than the previous event
  so that event sequence is maintained properly and historically.  
* I used git and github for source code repository
* Followed TDD(Test Driven Development) approach
* Tried to make my code DRY as far as I can
* Used PostgreSQL relational database to design the database schema
* Used bootstrap to make the UI(basic) responsive
* My Development environment was Linux(Ubuntu, Rubymine IDE, Ruby 2.6.6, Rails 5.2.5, google chrome)
* Normally I try to design scalable software. I do analysis and do feasibility study before coding.
  For this application I changed one of my plans. Initially I thought `event` record would contain
  columns like `clocked_in_at clocked_out_at`. However I introduced `event_type` to make it more scalable
  because the software can be scaled(in future perhaps) to track other events like `lunch` `meeting` `conference` `delivery` `pingpong` etc

### Schema design
```
  create_table "events", force: :cascade do |t|
    t.integer "user_id"
    t.string "event_type"
    t.datetime "event_at"
    t.string "location_ip"
    t.text "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end
```
* I designed 2 tables namely `users` and `events` where user has_many events and event 
  belongs to user. I tried my best to avoid data redundancy  in this schema and relationships.
  `users` table is used for the authentication and `events` table is used for storing authenticated user's events
* Introduced event_type(`clock_in`, `clock_out`) so that the event type can be extended(in the future) to other types
  like `lunch`, `meeting`, `conference`, etc 
* Introduced `location_id` and `user_agent` to track user location and device
  for collecting more valuable user's logs(generating more reports in future) under the hood
* Alternatively I would choose NoSQL database like mongoDB or AWS RDS could be used  
  
### If I were given another day and had more time
* I would like to develop microservice architecture using AWS(EC2, RDS, SES, Load Balancing), Twilio, Redis, etc
* I would like to setup background job(like Sidekiq) to notify(if user forgets to clock out) the user via email/sms
  to get clocked out after a certain time(like if the tracked hours is more than 8 hours a day)
* I would design the database and architect the software like a SAAS(Software As A Service) 
* I would split the software architecture into frontend(React, Redux, JavaScript, NodeJS) and backend(JWT token based API in Rails) for better UX
* I would setup CI(perhaps github actions) for continuous integration and automated deployment.
* I would recommend another server for staging
* I would like to develop a mobile app using React Native


## RSpec test
* `rake db:create RAILS_ENV=test`
* `rake db:migrate RAILS_ENV=test`
* `rspec`