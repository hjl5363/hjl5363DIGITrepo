# XPath Exercise 3 Solutions

1. Exploring the `<sd>` elements for stage directions in Goldeneye.

    a. Write an XPath to return a count of all the <code>sd</code> elements in the document.
    
   **Answer**: `//sd => count()` or `count(//sd)` returns 524 `<sd>` elements.
    
    b. What XPath expression returns all the stage directions that contain the word (or partial word) "Russian"? How many are there?
    
   **Answer**: `//sd[contains(., "Russian")]`  or
    `//sd[contains(., "Russian")] => count()` (for practicing with the count() function) 
    
    The `contains(., "something")` takes two bits of input or *arguments* and we think of these as the haystack and the needle (as in finding a needle in a haystack). The haystack is the first argument: it's the self:: node referred to with the dot `.`. Look inside the node. And the needle is the second argument, a string of literal text you are looking for: "something". We nearly always use this in a predicate filter: find the node where it's true that it contains a string of special text: `//node[contains(., "special string")]`

        Of course, you can also write: `count(//sd[contains(., "Russian")])` to wrap around the sequence. 
    11 stage directions contain the string "Russian" (as in "Russian" or "Russians").
    
    c. There is usually a pretty important stage direction after a scene change. Each scene is contained in a <code>Scene</code> element, and in each Scene the first element child is a <code>Heading</code> element. How can you reliably find <em>the first stage direction immediately following that Heading element</em>? 
    
    **Answer**: Take this in stages to familiarize yourself with the coding of scenes and headings first of all:
    
    `//Scene` returns 174 `<scene>` elements
    
    `//Scene/Heading` returns 174 `<Heading>` children of `<Scene>`, and we can see these are always the first element inside each `<Scene>`.
    
    How do we reach the very next stage direction (`<sd>`) element after a `<Heading>`? Both are children of the same parent, `<Scene>`, so they are related as siblings. What we want is the *first following-sibling element after each `<Heading>`*. So let's move to the `following-sibling::` axis in our XPath:
    
    `//Scene/Heading/following-sibling::sd`
    
    That returns too many results: we get all of the following-sibling `<sd>` elements, so we need to trim this back to get only the very first ones after a `<Heading>`: 
    
    `//Scene/Heading/following-sibling::sd[1]` 
    
    This returns 172 `<sd>` elements. 
    
    *Alternative answer*: We get the same results with a simpler XPath, just looking for the very first stage direction inside each scene. This solution is also correct:
    
    `//Scene/sd[1]`
    Both solutions return 172 results. (Interesting, because there are 174 Scene elements...that tells us that some scenes do not include any stage directions, leading us to one of our later questions on this exercise.)
    
    
    d. Of these these stage directions that come immediately following <code>Heading</code> elements, we are interested in the ones that feature computers in the scene. How can you find out which ones contain the string "computer"? (Hint: add a predicate). 
    
    **Answer**: `//Scene/Heading/following-sibling::sd[1][contains(., "computer")]` 
    
    or more simply:
    
    `//Scene/sd[1][contains(., "computer")]`
    
    e. Some unusual scenes in the <i>Goldeneye</i> script contain no stage directions at all. Write an XPath expression to isolate any <code>Scene</code> elements without <code>sd</code> elements inside. How many of these scenes are there? (Hint: use a predicate with the <code>not()</code> function.)
    
    **Answer**: There are two such scenes that lack stage directions.
    
      `//Scene[not(sd)]`  This checks only on the child axis from Scene. so to be more thorough in our checking, we can look down the descendant axis.
    
    `//Scene[not(descendant::sd)]` or `//Scene[not(.//sd)]` Notice how we write the second expression with the predicate like this `[.//sd]`.  When we use the `//` shorthand in a predicate it *always* returns to the root node of the document and loses track of the *context node* and return the wrong answer (in this case, zero nodes, because the *entire document* certainly *does* contain sd elements).   
    So if we use the shorthand, we need to add the dot `.` to the predicate to say stop on the **self node** and look down the tree from here. That way we return the two results we're looking for. 
    
2. This set of questions explores what you can find out with the XPath <code>string-length()</code> function, which indicates the number of characters in the XML node that you visit.

    a.  This time, let’s work with the speeches in the screenplay, coded in <code>sp</code> elements. Write an XPath to locate all of the speeches (and notice how they are coded with a <code>spk</code> element inside). Now, use the simple map <code>!</code> operator to apply the <code>string()</code> function to each <code>sp</code> element one by one. How is this return with <code>string()</code> different from just returning the <code>sp</code> elements? (Respond with your XPath expression, and a brief explanation of what you are seeing in the return window: How did the <code>string()</code> function change your results?)
    
    **Answer**: `//sp ! string()` 
    
    This is different from returning just `//sp` because with `//sp ! string()` we can see the speakers' names output alongside the text of the speech, and the XPath location on the tree is removed. This shows us something important about the family of `string()` functions, which includes `string()`, `substring()`, `string-length()` and others. These functions reach down the descendant axis from the node you designate to pull **all of the text nodes** from this point all the way down the tree. So in this case, we return a string that includes the text of the `<spk>` element inside the `<sp>`.
    
    b. Change the previous XPath expression to remove the <code>string()</code> function, and instead, step to the <code>text()</code> node child of <code>sp</code>. How does this change the results in the return window? (Note: <code>text()</code> is a node in the XML tree, so this is not a function, but a path step from parent to child. Tecnically, <code>text()</code> is a child of the parent element.)
    
    **Answer**: `//sp ! text()`  or `//sp/text()` 
    
    This returns only the text of the speeches (without the names in the spk elements). Also, we can see that the text of each speech has an XPath location on the tree. 
    
    c. Now that we have isolated the speeches in the screenplay, write an XPath expression that returns their <code>string-length()</code>. What does this return?
    
    **Answer**: `//sp/text() ! string-length()` or `//sp ! text() ! string-length()` 
    
    This returns a series of numbers for each of the 649 speeches in Goldeneye. The numbers indicate a count of each character in the string of each speech. So there are 34 characters (letters and punctuation and spaces) in the first speech.
    
    d. Send those results to the <code>max()</code> function to find out the longest length of a stage direction in the <i>Goldeneye</i> script.
    
    **Answer**: `//sp/text() ! string-length() => max()` 
    
    The longest string-length of any speech in *Goldeneye* appears to be 462 characterws. We need the arrow operator here to send the *sequence* of results to the function so it can locate the maximum or highest string-length() number. We could also wrap `max()` around the whole expression like this: `max(//sp/text() ! string-length())`
    
    e. The <code>string-length()</code> and <code>max()</code> functions took us off the XML tree to yield calculated results. How can we write XPath to return the XML element <code>sp</code> that has the maximum <code>string-length()</code>? Hint: Try searching for <code>sp</code> elements with a predicate that checks to see if the <code>string-length()</code> <em>is equal to</em> the maximum string-length you found in the previous step.
    
    **Answer**: You can do this in two ways: Easy way: take the numerical value you retrieved in the previous question and apply it in the predicate of this one: 
    
    `//sp/text()[string-length() = 462]` 
    
    But if we didn't know that `string-length()` value, we could write the expression like this, to poke the calculation of the maximum string-length into the predicate:
    
    `//sp/text()[string-length() = //sp/text() ! string-length() => max()]` 
    
    or
    
    `//sp/text()[string-length() = max(//sp/text() ! string-length())]`
    
    Notice how we can put a whole path expression inside our predicate. The speech in question is:
    
    ```
     <sp><spk>ALEC</spk> Once again your faith was misplaced. They knew. We're both orphans, James.
   While your parents had the luxury of dying in a climbing accident, mine survived the British
   betrayal and Stalin's execution squads. But my father couldn't let himself or my mother live with
   the shame of it. MI6 figured I was too young to remember. And one of life's little ironies, their
   son goes to work for the government who caused a father to kill himself and his wife.</sp>
    ```
    
3. Now we will turn our attention to the <code>spk</code> elements, to return information about the speakers.

    a. Notice how <code>spk</code> elements are nested as children inside the <code>sp</code> elements. Write an XPath expression to return all the <strong>speakers</strong> who deliver speeches that contain the word "Iraq". (Hint: Try breaking this down: first return all of the speeches that contain "Iraq" and then take a step to return the <code>spk</code> element.
    
    **Answer:** `//sp[contains(., "Iraq")]/spk`  
    
    An alternative way of writing this would step to the `spk` elements and filter them based on whether the parent `sp` contains the word "Iraq", like this:
    
    `//spk[parent::sp[contains(., "Iraq")]]`
    
    Both XPath expressions return the same result, landing on just one <spk> node containing "BOND". 
    
    
    b. All the <code>spk</code> elements are entered in block caps. Use the XPath <code>lower-case()</code> function to return all the spk elements lower-cased instead and record your expression. Hint: For this special function, you will need to refer to the self:: node using the dot like this: <code>lower-case(.)</code>
    
    **Answer**: `//spk ! lower-case(.)`
    
    This function needs the dot `.` to refer to the node it is altering. It is a little like the string-finding functions like `contains(., "something")` in this. (In fact, one way we frequently use `lower-case(.)` or its cousin `upper-case(.)` is to convert all the characters to the *same* case to do a "case-insensitive" search for a something that may or may not be capitalized.) 
    
    c. We don’t really want to make the speakers names all lower-case. We just want to lower-case the letters after the first one, to change BOND to Bond. We can do that kind of <q>string-surgery</q> in XPath by working with substrings. <a href="https://developer.mozilla.org/en-US/docs/Web/XPath/Functions/substring">Consult this page to learn about the XPath <code>substring()</code> function and see how to write it out</a>. Now, see if you can apply the <code>substring()</code> function to isolate the 2nd letter onward in the <code>spk</code> elements. Then, <code>lower-case()</code> that substring!
    
    **Answer**: `//spk ! substring(., 2) ! lower-case(.)` 
    
    This applies the substring() function to the spk node, and indicates that the substring starts with the second character. Without a third argument, this function will just grab the rest of the string to the end of each speaker's name. We then apply the lower-case(.) function at the end of this as a series of process. So for "BOND" we return "ond". 
    
    d. Now, if you could apply the  <code>substring()</code> to isolate letters 2 to the end, you should be able to change it to return only the very first letter. (This time, we do <strong>not</strong> want to apply the lower-case function, because we want to preserve the upper case of the first letter.) Try it and record your expression.
    
    **Answer**: `//spk ! substring(., 1, 1)`
    
    This time, for "BOND" we return "B".
    
    e. One last challenge. If we can isolate part of the speakers' names to lower-case the 2nd letter to the end, we should be able to connect the first (capital) letter to the rest of the lower-cased letters. For this we want to use the XPath <code>concat()</code> function, and there is a convenient shorthand for it in XPath 3.1 which sets two vertical bars <code>||</code> between the expressions you want to connect. However, we need to be careful because concatenation requires joining <em>exactly one</em> thing to <em>exactly one</em> other thing. (XPath can't figure out on its own how to concat (or tie together) the whole sequence of substrings of the first letter to the whole sequence of the substrings of the rest.) To help XPath to work one at a time over sequences of <code>spk</code> substrings, look up the <code>for $i in (sequence) return ...</code> XPath sequence. (This is a <dfn>for-loop</dfn> in XPath, and <code>$i</code> is known as a range variable that isolates each member of the series, one by one.) With the for-loop, you can go one step at a time through the series of <code>//spk</code> nodes and return a concatenation of the substring functions you figured out, using <code>$i</code> as the first argument of your substring functions. See if you can work out how to write this XPath.
    
    **Answer**: Okay, we always try to throw something ambitious into the very last XPath question. Here's how we **concatenated** (or "tied together") the first and last parts of each speaker's name, with the first letter capitalized and the rest lower-cased. 
    
    This is tricky to work out, but we wanted to show you an XPath "for loop" in action: This "for loop" steps through a sequence of XPath results and handles them one at a time. It's a little bit like simple map, but it can accomplish a little more, like let us use a concat() function to put substrings together. We introduced the XPath 3 shorthand using `||` to concatenate our substrings like this::
    
    `for $i in //spk return substring($i, 1, 1) || substring($i, 2) ! lower-case(.)`
    
    A longhand way to write this  using `concat()` looks like this:
    
    `for $i in //spk return concat(substring($i, 1, 1) , substring($i, 2) ! lower-case(.))`
    
   We rarely actually use this XPath expression in Real Life, though we **often** need to work with `substring()` and other code that does string-surgery, tokenizes into pieces, remixes strings, upper-cases or lower-cases them. In Real Life we use these string-altering functions in XSLT or XQuery, and this processing code lets us work with one node at a time in a way that is designed to be easier to read. More on this in the next lesson where we introduce XSLT! 
    
    
    
    



    
    
    
    
      
 
    
    
  
