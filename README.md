# WEEK 4

This week, we will cover:

* The Bootstrap CSS Framework
* HTTP Requests and Responses
  * Structure
  * Status codes
* Domain Modeling

### IMPORTANT DATES

* February 12th (week 6)
  * Midterm (2nd half of class) [20% of final grade]
  * Project Milestone: Feb 12th [20% of final grade]
* March 5 (week 9)
  * Final Project [30% of final grade]
  * Quiz #2: [5% of final grade]


### 0. Bootstrap

CSS frameworks save us time by leveraging the knowledge of professional
front-end developers.  One of the most useful components of the framework
is the "grid system".  See the [Notes on the Bootstrap Grid](notes-bootstrap.pdf).

### 1. HTTP Requests and Responses

HTTP 1.x is a call-and-response protocol.  

1. The client uses either port 80 or port 443 to make a request to the server's IP
2. A request consists of two parts: a list of _headers_ (key-value text pairs) and a body (text)
3. The client waits until it receives a response from the server
4. The response consists of three parts: a status code, a list of _headers_ (key-value text pairs), and a body (text).  

HTTP 2.x is a binary protocol but uses the same underlying structure. Web application
frameworks will perform the binary-to-text conversions transparently,
so that our programming environments will remain virtually the same.

### 3. Domain Modeling

In software engineering, a domain model is a conceptual model of the problem domain.
 The domain model describes both behavior and data.
 See https://en.wikipedia.org/wiki/Domain_model.

See the [Notes on Rails Models](notes-models.md) in this folder.

### 3. RESTful Architecture

REST is an acronym for Representational State Transfer, as described in Roy Fielding's
Ph.D dissertation here:
 https://www.ics.uci.edu/~fielding/pubs/dissertation/rest_arch_style.htm
 (you're not required to read the dissertation but I provide the link here for those
that are very interested in software architectural styles.)

For our purposes, the important part of the dissertation says:

1. URLs are nouns
2. HTTP methods are verbs
3. HTTP clients manipulate internet-based resources by specifying a combination of a both verb and a noun, which is HTTP Method plus a URL.

See the [Notes on RESTful development](notes-restful.md).

### 4. Helpful links

* https://httpstatuses.com/
* http://guides.rubyonrails.org/layouts_and_rendering.html#using-redirect-to
* http://api.rubyonrails.org/v5.1.1/classes/ActionView/Helpers/FormTagHelper.html

### 5. Extra Rails Goodies

**5.1 Controller Instance Variables**

Views are not responsible for gathering the data
they need to display.  That's the controller's job.
An action method can load data into member instance variables
and the corresponding view will have access to those same
variables.

``` ruby
class FavoritesController < ApplicationController

  def index
    @my_faves = ["cookies", 21, "Ruby"]
  end

end
```

``` html
<!-- index.html.erb -->
<h1>My Favorites</h1>

<ul>
<% @my_faves.each do |fave| %>
  <li><%= fave %></li>
<% end %>
</ul>
```

HTTP is stateless.  All instance variables are destroyed once the response has
been sent back. Instance variables cannot be used between one action and the next.


**5.2 Named Routes (optional feature)**

Each URL listed in your `routes.rb` file can be _named_.  Naming a URL
provides a level of indirection between the rest of you application code
and the URL itself.  The name establishes two Ruby methods that you can
call whenever you need the URL.  Instead of hardcoding URLs as strings
all over your application, you can invoke the named methods instead.


We add names to each URL by using the `as:` option.

``` ruby
# config/routes.rb
Rails.application.routes.draw do

  get '/' => 'stations#index', as: 'root'

  get '/stations' => 'stations#index', as: 'station_list'
  get '/stations/:id' => 'stations#show', as: 'station'

  # You can add more routes anywhere in this file
  # if needed.

end
```

This means that elsewhere in your application, instead of code like this:

``` erb
<%= link_to "See The List of Stations", "/stations" %>
```

you can write

``` erb
<%= link_to "See The List of Stations", stations_path %>
```

and instead of

``` erb
<%= link_to "My Station", "/stations/456" %>
```

you can write

``` erb
<%= link_to "My Station", station_path(456) %>
```

In controllers, you should use the fully-qualified URL by using the `*_url`
version:

``` ruby
def create
  # ...
  redirect_to stations_url
end
```

Remember: [view the source, Luke!](https://www.youtube.com/watch?v=o2we_B6hDrY)


**5.3 Redirection**

* HTTP defines a 301 status code, which tells the browser
that it must submit another request to a different resource.  
* If you send back a 301, you also need to include
a location header that provides the URL of the other location.  
* `redirect_to` can be used to respond with a properly-formatted
301 response.  It also supports an option to generate a "flash message" to display to the user.
* Flash messages can be displayed by adding code to the application layout to display notices and/or alerts.
