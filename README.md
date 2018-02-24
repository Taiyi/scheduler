# Scheduler
An application for scheduling the bug engineer for the week.

Written in Ruby

## Requirements
Required gems:

- sinatra
- haml
- gon-sinatra
- rspec

## Interface

- Selected an engineer via the dropdown menu.  Upon selection, links near the calander should appear.
- Click a link to register the selected engineer as the engineer of the corresponding week.
- If an engineer already exists for that week, then the selected engineer will replace the first engineer. If the selected engineer had a previous timeslot, the first engineer will take that as his or her new week.
- The "None" option at the end of the engineer list will remove the engineer from his or her timeslot.
- Once the desired schedule is created, the save changes link will commit all changes so the new schedule can be accessed later.

## Issues
- Accessing the website from multiple browsers or tabs will cause concurrency issues when saving.

## Running

- Move CLI to root directory.
- Run command "ruby main.rb".  Website can then be accessed at localhost:4567.
- Alternatively you can run the command "rackup".  Website will still be located at localhost:4567.

## Testing

- Move CLI to root directory.
- Run command "rspec spec" to automatically run all unit tests.

## Deployment

- App has additionally been deployed using Heroku
- URL is https://shen-jared-scheduler.herokuapp.com/
