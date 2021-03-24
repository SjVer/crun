# crun
A simple bash script that allows you to easily run any csharp script conviniently.
Adding an alias for executing this script is highly reccomended.

> Needed packages
- mono-mcs
- mono

> usage
`crun myscript.cs <flags and args>`
Where 'crun' is the alias.
Any given args will be passed to the execution of the compiled script.

Flags:
  --keep  will preserve the .exe file after execution (deleted by default)
  --clear will clear the terminal before execution
  --help  will display some information

This script was made on linux
