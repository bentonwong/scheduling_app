# WhenUWork

WhenUWork is an employee scheduling application.  A working demonstration version of this application is available at https://whenuwork-x-bw.herokuapp.com/.

## Getting Started

To run this application locally, a copy of it is available for download or cloning at https://github.com/bentonwong/scheduling_app.

### Prerequisites

A modern web browser
A copy of this repo

### How to get the application to run locally

1. Clone this repo from GitHub at the above address.
2. Change over to the directory in your terminal.
3. Start the application up by typing `rails s` to boot up the rails server.
4. If prompted, run `rake db:migrate` to set up the database.
5. Execute `rake db:seed` to establish user accounts, which includes an admin account.
6. View and use the application at http://localhost:3000

## How to run the tests

Explain how to run the automated tests for this system

## How to use the application

Logging



Admin

Employee

## Deployment

This application can be deployed to PaaS providers such as Heroku.  Since this application relies on time based triggers to update and expire employee swap shift requests, it is recommended to use a cron utility to schedule recurring jobs.  The above Heroku deployment of this application uses its Scheduler feature to run 'rake update_reqs_resps' everyday at midnight UTC to check to see if any shifts have started and cancels swap requests or opportunities to respond where a shift has already started.

## Built With

* [Ruby on Rails](http://rubyonrails.org/) - The web application framework used
* [Materialize](http://materializecss.com/) - Front-end framework
* [Ruby Holidays Gem](https://github.com/holidays/holidays) - A set of functions to deal with holidays in Ruby
* [Whenever](https://github.com/javan/whenever) - Provides a clear syntax for writing and deploying cron jobs

## Authors

* **Benton Wong**

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Calendar/Date Picker Feature - http://railscasts.com/episodes/213-calendars-revised
