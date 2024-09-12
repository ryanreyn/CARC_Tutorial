# CARC_Tutorial
This is a tutorial designed to demonstrate how to use the USC CARC remote computing resources. Additionally, the various files in this repository can be used as templates for designing your own job submissions (using either a batch construction or direct submission).

## Using git on CARC
Using git on CARC is a very easy process as the CARC system operates using modules that are installed directly onto the remote system by the CARC support team. These modules represent versions of various software that can be directly used by loading those modules into your workspace. In our case, to access git all we have to do is run the following command:
```
module load git
```
That's it! Now we have access to all of the git functions that we will need for the remainder of this tutorial! If you don't want to have to run `module load git` each time you login, consider adding this command to your `.bashrc` file, which sets up your remote workspace each time you log in.

## Cloning a git repository to a CARC folder
Now that we've loaded git into our remote workspace, we want to clone a repository from Github so that we can now generate and edit code with version control while working on the CARC remote system. CARC has a general [support page](https://www.carc.usc.edu/user-guides/hpc-systems/software/git) for using git that may be useful to refer to throughout this tutorial. 

Before we can get to cloning repositories, we first need to set up an ***ssh key*** on our Github account that lets Github know to trust any interactions we create between our local folder on CARC and our git repository hosted on Github. To do this, we need to log into CARC from our terminal and run the following:
```
ssh-keygen -t ed25519
```
This will create an ssh key pair (a public and private key) that you will be able to use to effectively link your CARC account directly to Github for version control capabilities. Once you have generated this key, on Github navigate to your *Settings* by clicking on your profile icon at the top right of your web page. Once in your setting click on *SSH and GPG keys* and click *New SSH key*. Give the key a catchy title that will help you remember what the key is associated to, like **USC CARC** for example. Then, run the following command in your terminal window to see the contents of the public version of the key:
```
cat ~/.ssh/id_ed25519.pub
```
Copy the contents of this output and paste them directly into the text box titled *Key* in your Github window. Lastly, open the ssh config file `~/.ssh/config` in your favorite editor and add the following lines to the end of the file:
```
Host github.com
    IdentityFile ~/.ssh/id_ed25519
```
Complete the process of adding your key to Github by pressing the *Add SSH key* button and you're ready to interface between your CARC account and Github directly!

Now that we've successfully set up our ***ssh key*** we're ready to clone this repository to continue our tutorial. First, we want to navigate to the ***project*** directory where all coding projects should be stored. When you log into CARC you are dropped into your ***home1*** directory by default. Navigate to your ***project*** directory by typing the following command:
```
cd /project/nmherrer_110/<your username>
```
This will ensure that the clone you create of this Github repository is on the ***project*** directory, where we have access to significantly more memory. Now, click on the green *Code* widget, navigate to the *SSH* tab and copy the text. It should look like this:
```
git@github.com:ryanreyn/CARC_Tutorial.git
```
Now, in your terminal, run the following command:
```
git clone <repo link> <repo directory>
```
with the `<repo link>` set to the above `.git` line and `<repo directory>` set to whatever name you want the folder to have on your local CARC environment. Typically, we use the same name for this folder as the name of the Github repository itself. Now you should have a copy of everything in this **CARC_Tutorial** repository present in the folder name you substituted for `<repo directory>`.

## Running jobs on CARC
With our tutorial repository in hand, and strong fundamental understanding of how to set up git for version control in the CARC remote environment, let's go ahead and learn how to run some jobs. Jobs are managed on CARC using a specific job scheduling software called ***Slurm***. ***Slurm*** basically does all the heavy lifting of finding compute nodes to run your job on with the right specifications, and passing the code you want to run there and then passing back any output to the locations you specify.

There are two kinds of jobs you can run on CARC: *direct* submissions where you simply write a ***Slurm*** script detailing the necessary computational specs and run a script a single time in that job, and *batch* submissions where you create many individual jobs that each run the same process on one specific set of conditions. This tutorial includes files for running submissions both ways.