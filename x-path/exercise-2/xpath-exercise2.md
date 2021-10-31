# X-Path Exercise 2

1. `//occupation/@type`

2. distinct-values(//occupation/@type)

3. //occupation/@type => distinct-values() => count()

4a. 66 answers, `//occupation[@type="artist"]`

4b. `//person[occupation[@type="artist"]]` (returns 41 `<person?` elements)

4c. //person[@sex="f"][occupation[@type="artist"]], returns 4 women artists

4d. //person[occupation[@subtype="engraver"]]`, returns 8 engravers

4e. `//person[occupation[@subtype="engraver"]][birth/@when="1787"]`, William Finden is the engraver born in 1787.

4f. //person[occupation[@subtype="engraver"]]/birth/@*

4g. `//person[occupation[@subtype="engraver"]]/birth/@*`, The earliest date is November 10th, 1967.

5. The first part locates the first <occupation> and the second part "walks the whole tree".