[![Our logo](https://github.com/rjmascolo/module-one-final-project-guidelines-web-100817/blob/master/Images/Logo.png)](https://www.youtube.com/watch?v=3XcI1QN2a9c&t)
Not sure what HII does?  [Check out our intro video on YouTube!](https://www.youtube.com/watch?v=3XcI1QN2a9c&t)


### Basic Design: ###
HII is designed to allow the user to find the health grade history
of a restaurant based on the name and location. Users will also be able to look up
restaurants near them with the most and least violations, and can specify a type
of cuisine if they prefer.

The score of the restaurant is pulled from the NYC health inspection information publicly available at https://data.cityofnewyork.us, as are the violation definitions and codes.

More information about health code assignments can be found here - http://www1.nyc.gov/assets/doh/downloads/pdf/rii/how-we-score-grade.pdf

### How to Run: ###  
First, make sure to migrate and seed that database using the commands ```rake db:migrate``` and ```rake db:seed```.  Seeding may take quite a while, since it's pulling in and crunching a ton of data.

After that, 'run.rb' is your run file. From the command line inside of the project folder ```ruby bin/run.rb``` will get you up and running.  The program is simple to operate and merely requires that you follow the on-screen prompts.

*If you'd like to demo the program with a smaller dataset, change the limit at the end of  line 6 of 'api_communicator.rb' to 1000 or 10,000.  We found that it takes about a minute to seed for every 10,000 records.*

```  restaurants = RestClient.get("https://data.cityofnewyork.us/resource/9w7m-hzhe.json?$limit=10000")```

---

This project is licensed under the MIT license. See LICENSE.txt for more details.

##### Contributors: Ryan Mascolo, Dick Ward ######
