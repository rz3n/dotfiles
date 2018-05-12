== my dotfiles

This is a simple example of dotfiles. The most important thing is the *bootstrap.py* script.

The script will copy all files (you can define exceptions :)) in his directory. This files will be "dotted" in your destination folder (usually your home folder, but you can define that too :D). Untill here nothing big, there are a dozen of scripts like these outhere.

The difference is. This script go down in the directory tree creating directories and linking files.

For example:
:You already have a .config file, but you don't want keep all those files in your dotfiles repository. This script will only create links to the wanted files.

Thank you for reading this and trying use my script. Feel free to make suggestions or submit a pull request to implement your ideas.

I'm not a python programmer, so this script probably can be inproved, but works :)

PS. The script is really simle. I didn't put any "pretty message", just does the job.
