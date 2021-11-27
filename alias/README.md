Having convention makes it easy for autocomplete to suggest relevent available cmds and also easy for me to remember. I use this convention for any custom func or alias I create

## Alias Conventions

### General Pattern

alias name logic
```
         who-abbrev{1,2} 'ng'

       + what-abbrev{1,2} 'e -edit, v -view, cd, sp - stop'

       + where-abbrev{1} 'A - all, G - global'
```

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
|c|create, clean, clear, commit|
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
|s|search|
|si|search case insensitive|

|Abbrev|WHAT / ACTION|
|----:|---|
|a|add|
|b|build, branch|
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

|Suffix|WHERE / CONTEXT or HOW|
|----:|---|
|A|All|
|G|Global|
|L|Local|
|S|Staged|
|D|Detached, Deamon|
|V|Verbose|
|Q|Quite|
|R|Recursively|
|!|Force|
|H|Help|



### Shell CMDs Alias

|Suffix|WHERE / CONTEXT|
|----:|---|
|h|history|


