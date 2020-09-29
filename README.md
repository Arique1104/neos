# Mod 3 Refactoring Workshop

## Background

Near Earth Objects is an educational command line tool that strives to interrupt the monotony of day to day living by allowing users to understand how close to extinction life on earth is at any given point in time. Every day thousands of NEOs (Near Earth Objects) i.e. comets, astroids, meteors pass by the earth at alarmingly close distances. One slight shift in the cosmos would cause these NEOs to crash into the earth, setting off a series of catastrophic events that would lead to the end of life as we know it (much like the fate of the dinosaurs). Now that we've discussed this, please take a moment to appreciate 3 small things in your life that you take for granted and assume will always be there...
1. my breathe
2. my son
3. my sanity

## Instructions

Please follow these instructions for further enlightenment.

- Clone this repo
- Run `bundle install` to download and install all of the necessary dependencies
- This project uses NASA's Astroids - NeoWs API. Please signup for an API key [here](https://api.nasa.gov/)
- Once you have your api key, run `bundle exec figaro install`. This should create a file called `application.yml` located in the `config` folder. **Note:** This file is automatically gitignored and many IDEs do not show gitignored files by default. You may have to change your IDE's settings to show gitignored files.
- Append your api_key to `application.yml` in the following format `nasa_api_key: <Your API KEY Goes Here>`
- This project uses minitest. You can run the tests with the following command `ruby near_earth_objects_test.rb`
- To use the command line tool run `ruby start.rb`. You will be prompted to enter a date. Enter the date in the following format `YYYY-MM-DD` i.e. `2019-03-30`. Once you hit enter you will see information about the objects that came near to the earth on that day.

## Workshop

### Explore the code (15 min)

With your partner look through `start.rb` and `near_earth_objects.rb`
# Working with Priya on Refactoring
### Explore the code
1. With your partner look through start.rb and near_earth_objects.rb
1. Discuss is this 'good' or 'bad' code? Why?
  #### START
      - In the start file, there is a good chunk of code that is just about making a table
      - Even the print information can be contained in the class or separate file?
      - lines 3-6 convert into class method or new file (possible def intro_message in NearEarthObjects)
      - Line 8 belongs where? can it live in the method with message above? Or stay in the runner?
      - Pretty much lines 33-41 should be mostly what is in it, with changes for how they are called
      #### START
      - Whats up with the figaro information outside the class? (line 7-8)
      - Looks like 1 very large self method
      - Misspelled 'asteroid' in various locations
      - Ln 14, 'date' is the passed param which comes from the start.rb which comes from CLI
      - FEELING MOST CONFIDENT: converting NearEarthObjects from a single self. to an instance fo NearEarthObjects that we can call various methods upon
      - regarding the figaro info: perhaps we CAN put this in it's own file, be cautious since this is how our API key is reading? Would this be a module?
### Identify the responsibilities
1. With your Partner, identify the different responsibilities that exist in each file.
- Responsibility #1 = Figaro read and load
- Responsibility #2 = Create data from Faraday.new (looks like AN INSTANCE VARIABLE) && (shouldn't date also be an instance variable)
- Responsibility #3 = Faraday get and parse - data method
- Responsibility #4 = Largest Asteroid (smells like a method)
- Responsibility #5 = Count of Asteroids (also smells methody)
- Responsibility #6 = Formatting Data
- Responsibility #7 = Final hash return can belong formatted data, it's own methods, etc... (AKA - we shouldn't be returning a final hash, we need to access this information through methods or instance variables)
    1. Does this adhere to SRP?
        - ABSOLUTELY NOT
    1. How would you utilize encapsulation and abstraction to refactor this code?
        - We are thinking of refactoring the class NearEarthObjects as an instance with initialize and methods
        - We are thinking Figaro might be a module
        - We are thinking that the table creation in the start file might be its own class
    1. What tools/strategies could you utilize to make this code adhere to SRP?
        - We brainstormed the various responsibilities (see 7 above)
        - We can TDD for each concept and test each "return" separately
### Refactor
1. Declarative Programming:
    1. Write the code you wish existed above the existing code
    Keep the code that is currently working. Don't delete it until the new code is working. This way you will always have a passing solution
1. Red, Green, Refactor:
    1. Utilize tests to keep you moving in the right direction
    Follow the errors in the test to guide you each step of the way
