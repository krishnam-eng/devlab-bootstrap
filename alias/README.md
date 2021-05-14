Having convention makes it easy for autocomplete to suggest relevent available cmds and also easy for me to remember. I use this convention for any custom func or alias I create


alias pattern:
```
         who-abbrev{1,2} 'ng'

       + what-abbrev{1,3} 'e -edit, v -view, cd, sp - stop'                                                 

       + where-abbrev{2,3} 'log, cf - config'                                                               
```                                                                            
abbrev:                                                                                       
```
         =^(.) + (.)$ if the word is ((last || middle) && length >4)                                 

        +=^(.) for word in compound-word                                                             
```
