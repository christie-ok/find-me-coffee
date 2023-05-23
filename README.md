# FindMeCoffee

"The coldest winter I ever spent was a summer in San Francisco" is a quote attributed to Mark Twain. It's actually uncertain if he ever said that, but the sentiment remains - Bay Area natives know that May, June, and July tend to be gray, foggy, and chilly in San Francisco. 

So as summer approaches, this is a little CLI tool to help you keep warm until Bay Area summer actually starts (probably not until early September).

Download this mix project and run the task from your command line to get a list of all the food trucks in San Francisco who are serving nice hot coffee!

## Installation
Clone the repo:
```
> git clone https://github.com/christie-ok/find-me-coffee.git
```

Go to the script folder:
```
> cd find-me-coffee
```

Grab necessary dependancies:
```
> mix deps.get
```

Run the script:
```
> mix find_me_coffee
```

Choose a spot that looks good and enjoy!

# Assumptions & Improvements with More Time
- My focus with this project was to create something useful, clear, and well tested within the timeframe. This project has no web frontend or database. For a more detailed example of a full stack Elixir application I am developing, please take a look at my Babysitting Co-Op app (https://github.com/christie-ok/babysitting). It's still under contruction.
- This project assumes that all food trucks returned by the city's dataset are open 24 hours/day. With more time to work on this, datapoints like opening hours and approval status could be incorporated to return a more accurate list of trucks open when a user is looking for coffee.
- The API call has no query params - it returns a list of every truck in the database and then the list is filtered in memory. I felt this was okay for an MVP since I could see that the list of trucks is not more than 500 records - a very digestible amount for Elixir. However, to further develop the project, I would include some parameterization to return only trucks that are likely to have coffee.
- It is also assumed that only trucks whose food item list includes coffee actually sell coffee. This is very likely excluding trucks that have coffee, but don't list it which is something that could be addressed in a later iteration.
- There is also almost no error handling at this time. Given more time, I would improve error handling and error messaging to make clear the problem if something goes wrong with the API call.