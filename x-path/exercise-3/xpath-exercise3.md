# X-Path Exercise 3

1. a. `//sd => count()` or `count(//sd)` returns 524 elements
1. b. `//sd[contains(., "Russian")] => count()`
1. c. `//Scene` returns 174 elements
1. d. `//Scene/sd[1][contains(., "computer")]`
1. e. `//Scene[not(.//sd)]`

2. a. `//sp ! string()`
2. b. `//sp/text()`
2. c. `//sp ! text() ! string-length()`
2. d. `//sp/text() ! string-length() => max()` 
2. e. `//sp/text()[string-length() = 462]`

3. a. `//spk[parent::sp[contains(., "Iraq")]]`
3. b. `//spk ! lower-case(.)`
3. c. `//spk ! substring(., 2) ! lower-case(.)`
3. d. `//spk ! substring(., 1, 1)`
3. e. substring($i, 2) ! lower-case(.)`
