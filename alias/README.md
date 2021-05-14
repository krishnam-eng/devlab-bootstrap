Having convention makes it easy for autocomplete to suggest relevent available cmds and also easy for me to remember. I use this convention for any custom func or alias I create

#### Pattern

alias name logic
```
         who-abbrev{1,2} 'ng'

       + what-abbrev{1,2} 'e -edit, v -view, cd, sp - stop'                                                 

       + where-abbrev{2,3} 'log, cf - config'                                                               
```                                                                            
abbrev logic                                                                                        
```
         =^(.) + (.)$ if the word is [ middle && what && length >2 ]                                 
         =word if the word is [ (middle || last) && length <=2 ]
         =^(.) + (.)$ if the word is [ last && what && length >3 ]                                 
         =^(.) + (.)$ if the word is [ last && where && length >3 ]                                 
        +=^(.) for word in compound-word                                                             
```

#### Abbrev Conventions

|abbrev|who|
|----:|---|
|g|git|

|abbrev|who|
|----:|---|
|tm|tmux|
|ng|nginx|

|abbrev|what|
|----:|---|
|c|create|
|e|edit|
|k|kill|
|m|monitor - e.g tail flow|
|v|view|

|abbrev|what|
|----:|---|
|cd|change directory|
|rm|remove|
|ls|list|
|st|start|
|sp|stop|
|rl|reload|
|qt|quit|
|ss|status|

|abbrev|where|
|----:|---|
|cf|conf|
|log|log|
