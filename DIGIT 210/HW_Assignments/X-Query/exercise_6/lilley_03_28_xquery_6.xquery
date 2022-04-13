xquery version "3.1";
declare variable $blues := collection('/db/blues');
declare variable $ThisFileContent :=
<html>
    <head>
        <title>Blues Songs</title>
    </head>
<body>
    <h1>Information about The Blues Songs Collection</h1>
   <h2>Full Table of Artists and Their Song Titles</h2>
   <table>
        <tr><th>SongTitle</th><th>SongWriters</th><th>Artists</th></tr>
    
    {
        let $titles := $blues//metadata/title ! normalize-space() => sort()
   for $t in $titles
     
   let $songwriters := $blues[descendant::title ! normalize-space() = $t]/metadata/songwriter/name ! normalize-space() => distinct-values() => sort()
    
    for $s at $pos in $songwriters
    
    let $artists := $blues[descendant::title ! normalize-space() = $t]//metadata/artist ! normalize-space() => sort()
        for $a at $p in $artists
    (:Each artist is associated with a series of songs. Let's get the titles of each song per artist.:)
    
    return 
       <tr>
         <td>{$t}</td>
          <td>
              
              <ol><li>{$s}</li></ol>
              
          </td>
         <td>{$a}</td>
         
          
    
       
   </tr> 
   }
   </table>
   
   
   
</body>
</html> ;
$ThisFileContent

(:  :let $filename := "bluesArtistTable.html"
let $doc-db-uri := xmldb:store("/db/2022-ClassExamples", $filename, $ThisFileContent, "html")
return $doc-db-uri  :) 
  (: output at :http://exist.newtfire.org/exist/rest/db/2022-ClassExamples/bluesArtistTable.html ) :)     


