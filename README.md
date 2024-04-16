# Robot-Framework

[Robot Framework with Python- Selenium/API Automation Testing](https://www.udemy.com/course/robot-framework-with-python-selenium/?couponCode=ST14MT32124)

* Run tests with command `robot -d Reports tests`. This will create a new directory `Reports` where output files will be
  stored.

* Framework supports taking screenshot for each and every step using `Take Screenshot` keyword. Image file is attached
  to relevant step automatically in `Reports` file.

* Documentation
  for [SeleniumLibrary](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#library-documentation-top) can
  be found here

* Documentation
  for [BuiltIn library](https://robotframework.org/robotframework/latest/libraries/BuiltIn.html#library-documentation-top)
  can be found here

* To know more about data-driven testing using csv files, check test `test_csv_data_driven.robot`. Execute it with
  command `robot -d Reports .\tests\test_csv_data_driven.robot.robot`

* To see the flavor of having custom keywords defined fitting to automation purpose, check
  test/files `tests/test_user_defined_keywords.robot` & `user_defined_lib/UserDefinedFuncs.py`

* Parallel run is achieved through [Pabot](https://pabot.org/) plugin. Read more about it to get better info.

```commandline
pabot -d Reports .
```

* Run using test name `robot -d Reports -t "Validate unsuccessful login" ./tests`

* For tag-based run `robot -d Reports --include "Smoke" .`

* Multiple tags for tests `robot -d Reports --include "SmokeORRegression" .`

* Running only failed tests `robot -d Reports --rerunfailed ./Reports/output.xml .`

* Pass arguments from command line `pabot -d Reports --variable browser:"Headless Chrome" .`