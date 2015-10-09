data-bag-faker
==============

This cookbook will only be used for serverspec tests. 

The sumo cookbook requires an access key to connect a collector. 
So this recipe will build a fake databag containing a real access key for a sumo account, by reading an
ENV variable with a valid key, then editing it into an existing databag in the test directory.

To use this recipe, include it in your Kitchen yml runlist, before any other recipes:

    run_list:
      - recipe[data-bag-faker]

Then set an ENV variable for SUMO_ACCESS_ID and SUMO_ACCESS_KEY.


