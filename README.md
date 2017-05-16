# High level architecture overview

## Main features
* Site will have two main features
  * Allow a user to login in order to view subscription videos
    * I will have a barebones authentication system that depends on Zype OAuth. I'll store the `access_token` gotten from a Zype authentication request as well as the `expires_in` value to make sure users past the expire date are not considered logged in. I could have a User model, but in this quick setup, there is no need for one. This will then be heavily dependent on Zype's OAuth as it should be.
  * Make calls to the Zype API and display those videos.
    * One option is to make a `Video` model and store the data from the API in that model. But I will opt to always make calls to the API instead of saving any of that info in my DB. That way I always have the latest info. I will communicate with the Zype API via a `VideosController` as detailed below. This means that, as is, this app will not need any models. I will leave the database configuration in place though, as future features will likely need it.

## Organization of code
* `SessionsController` will hit the Zype OAuth endpoint. `access_token`, `refresh_token` email and `expires_in` will be stored in the `session`. I'm storing the email so I can show it in the nav bar. I'll test if a user is logged in by the expiration date of the token or if the token is even stored. If it's expired, log the user out and remove `access_token` from session.
* Videos will be displayed with a `VideosController`. I'll use HTTParty so send requests to the API and get the videos. This will have both an `index` and `show` action. The `show` will be used to display the video details or paywall.
  * for subscription videos, I'll first do a check to see if the subscription is required. If so, do a check if the user is signed in. Display details or paywall accordingly

## Diagram
![Zype diagram](./public/zype-diagram.png)

## Tests
* Meant to be at a high level and not exhaustive. I did feel it was important to include some in this assignment, even though it was not part of the requirements.
* I use Rspec as my testing framework and Webmock to mock API calls
* Test login ability
  * handle correct credentials
  * handle incorrect credentials
* Test Videos
  * I get list of videos
  * show if subscription required and not logged in
  * show video if logged in
* Capybara for feature tests (only testing that videos are display appropriately based on subscription requirements and if user is signed in)

## ENV Variables

I felt the `app_key` and urls were not necessary to make as ENV variables or to hide from the code. But it's my first instinct to do so. Now they are globally accessible and can change based on environment. In order to run the app locally, please add values for the following:
* client_id
* client_secret
* app_key
* authentication_url
* video_url
(default values in the `secrets.yml` file)

Tests will run even without setting these ENV variables.

I used the Figaro gem to manage my ENV variables, but the Dotenv gem is great as well. Or just your `.bashrc` file.
