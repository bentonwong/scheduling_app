# WhenUWork

WhenUWork is an employee scheduling application.  A working demonstration version of this application is available at https://whenuwork-x-bw.herokuapp.com/.

## Getting Started

To run this application locally, a copy of it is available for download or cloning at https://github.com/bentonwong/scheduling_app.

### How to get the application to run locally

1. Clone this repo from GitHub at the above address.
2. Change over to the directory in your terminal.
3. Start the application up by typing `rails s` to boot up the rails server.
4. If prompted, run `rake db:migrate` to set up the database.
5. Optional: Run `rake db:seed` to establish sample employee accounts, which includes an admin account.
6. View and use the application at http://localhost:3000 or the indicated port.
7. If no user accounts exists, there is a link at the bottom of the login page to create an admin account, enabling creation of other employee user accounts.

## How to run the tests

Explain how to run the automated tests for this system

## How to use the application

###Logging In

Select a user account and click on the arrow button next to it to log into that account. Since this is application is for demonstration purposes only, no password is required to enter other accounts including the admin account.

###Admin

The admin pages is divided into two main sections, employees and teams, with shifts as a subsection of teams.  Employees designated as an admin will have the ability to create, view, edit team and employee information.  

Admins can create weekly shifts for employees by team either for specific individual employees or random employees to the next available open shift(s). If a random assignment is selected  Individual shifts can be edited to reassign the employee or workdays in that shift.  Individual shifts can also be deleted.  Assigned shifts will appear on a team calendar with the assigned employee's name on the date.  Clicking on the name will reveal the entire shift's detail.

The scheduling feature assigns shifts by week starting Sunday through Saturday to those days of the week designated as a workday in that team's details page.  When shifts are assigned, US holidays are taken into account and automatically designates those days as non-workdays.  However, an admin can override this designation and set it as a workday.

###Employee

The non-admin employee section is divided into two pages, the dashboard and any of their team's shift details.

On the dashboard, the employee will see that employee's next shift, select and view the work schedule/calendar for teams in which the employee is a member, and information related to relevant requests to switch shifts.  Swap requests from other employees requesting to switch a shift will also appear with the option to accept or decline the switch.

Recent swap requests made by the employee are also displayed on the employee dashboard.  Recent swap requests include only those shifts that have not started yet.

The dashboard links the details of any listed shift such as the workdays and any holidays.  

Shifts belonging to the logged in employee will display the option to switch with only eligible shifts.  Eligible shifts are those that have not started and do not belong to the logged in employee.  An employee may select multiple potential swaps.  The first employee to accept the swap request will result in the immediate swapping of those shifts.  However, employees have the option to decline a request, which then removes the request from the dashboard.  The other employee will be notified of the decline in that shift's detail page.

While the swap request is pending, the shift detail page will show that there is a pending request with a list of recipients along with their response status.  The employee offering the swap has the option to cancel it before anyone has accepted it.  Cancelling it will prevent other employees from accepting it and removes the request from their respective dashboards.

Expiration of swap requests: The opportunity to response to accept a request will be cancelled if the requesting or the responding shift has already started.  If the requesting shift has started the entire request is cancelled.  The platform will run automatic checks daily to see if any of those shifts have started.  If a shift has started, that directly attached request or response is canceled or expired, respectively.

###Logging Out

In order to access other accounts, users must logout of an account before proceeding to log into other accounts.

## Deployment

This application can be deployed to cloud platform providers such as Heroku and AWS.  Since this application relies on time based triggers to update and expire employee swap shift requests, it is recommended to use a cron utility to schedule recurring jobs.  The above Heroku deployment of this application uses its Scheduler feature to run 'rake update_reqs_resps' everyday at midnight UTC to check to see if any shifts have started and cancels swap requests or opportunities to respond where a shift has already started.

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
