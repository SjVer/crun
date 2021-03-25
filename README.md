# crun
A simple bash script that allows you to easily run any csharp script conviniently.
To use add the contents of crun.sh in your .bash_aliases file.

> Needed packages
- mono-mcs
- mono
- bc

> usage <
`crun myscript.cs <flags and args>`
Where 'crun' is the alias.
Any given args will be passed to the execution of the compiled script.

Flags:
  --keep  will preserve the .exe file after execution (deleted by default)
  --clear will clear the terminal before execution
  --help  will display some information

This script was made on linux
