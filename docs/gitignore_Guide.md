# The .gitignore File

In the `src` directory of this app, there is a file called `.gitignore`. The dot there is important, and is part of the filename. 
Generally dotfiles are used for software configuration, and are treated as hidden files. 

The purpose of the `.gitignore` file is to specify to git which files you want git to ignore, so that git does not track them. 

Normally if you make a new file or modigy an existing one, git will tell you that the file is untracked or modified. 
If that file is in the `.gitignore`, then git does not do this and completely ignores the file. 
This also means that any files in the `.gitignore` will not be published to GitHub when you do push actions.

In the `.gitignore` file, you can write comments with a `#`, and otherwise can type out an exact filename for git to ignore it 
(you may have to specify a path depending on the directory relative to the location of the `.gitignore`).
You can also type directory names by including a `/` at the end. 

There are a lot of possible patterns to specify different folders/files for git to ignore. You can find a lot more detail in 
official documentation **[here](https://git-scm.com/docs/gitignore).**


## What should go into the .gitignore file?

If you have any files in your app with sensitive information, API keys, data files for your database, etc., 
it is a good idea to add them to your `.gitignore` file so that those files are not published on GitHub for everyone to see. 

By default in this repo, a lot of what Rails automatically generates is already in the `.gitinore`, like logs for example, 
and files which are automatically generated when you install the app anyways.