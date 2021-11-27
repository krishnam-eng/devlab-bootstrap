Having convention makes it easy for autocomplete to suggest relevent available cmds and also easy for me to remember. I use this convention for any custom func or alias I create

## Abbrev Conventions

### Who

|Prefix|WHO/SUBJECT|
|----:|---|
|b|brew|
|d|docker|
|di|docker image|
|dc|docker container|
|dco|docker-compose|
|g|git|
|m|mvn|
|tm|tmux|
|ng|nginx|

##### What 

|Abbrev|WHAT / ACTION|
|----:|---|
|rm|remove|
|ls|list|
|st|start, stash|
|sp|stop|
|rs|restart, restore|
|up|up|
|dn|down|
|ps|process|
|ss|status|
|lg|logs|
|lf|log follow e.g, log -f |
|ld|load|
|rl|reload|
|qt|quit|
|ap|apply|
|cf|config|
|cl|clone|
|co|checkout|

|Abbrev|WHAT / ACTION|
|----:|---|
|a|add|
|b|build, branch|
|c|create, clean, clear, commit|
|e|edit, execute|
|f|fetch|
|u|update|
|p|push|
|l|pull|
|r|run|
|k|kill|
|v|view|



|Abbrev|WHAT / ACTION|
|----:|---|
|prstn|pristine|
|prn|prune|

##### Where

|Suffix|WHERE / CONTEXT|
|----:|---|
|A|all|
|G|global|
|L|local|
|S|staged|
|D|detached|
|V|verbose|
|H|help|


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