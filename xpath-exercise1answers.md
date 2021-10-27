# XPath Exercise 1

1.

a. `//div` (9 results)
b. `//listPerson` (6 results)
c. `//div[listPerson]`(4 results)
d. `//div[listPlace]` (1 result)
e. `/listPlace/place` (204 results)
f. //place/placeName First expression is 263 results and the second expression is 400 results. 

2.

a. 19 results
b. `//list[@sortKey="animals"]/*` or `//list[@sortKey="animals"]/element() - 29 results
c. `//*[@sortKey]` or `//element()[@sortKey]` - 19 results

3.

a. 1//person` - 1223 results
b. `//person[@sex]` - 1107 results
C. `//person[@sex] => count()` - 1107 and `count(//person[@sex])` - 1107
d. //person[@sex] => count() div
E. //person[@sex="f"] => count() div //person => count() * 100
f. count(//person[@sex="f"])  div count(//person[@sex]) * 100