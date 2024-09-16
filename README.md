# CARC_Tutorial
This is a tutorial designed to demonstrate how to use the USC CARC remote computing resources. Additionally, the various files in this repository can be used as templates for designing your own job submissions (using either a batch construction or direct submission).

## Using git on CARC
Using git on CARC is a very easy process as the CARC system operates using modules that are installed directly onto the remote system by the CARC support team. These modules represent versions of various software that can be directly used by loading those modules into your workspace. In our case, to access git all we have to do is run the following command:
```
module load git
```
That's it! Now we have access to all of the git functions that we will need for the remainder of this tutorial! If you don't want to have to run `module load git` each time you login, consider adding this command to your `.bashrc` file, which sets up your remote workspace each time you log in. If you happen to be interested in what other modules you may be able to use during your time working on CARC, you can always run `module avail` to see what modules are available to be loaded into your workspace.

## Cloning a git repository to a CARC folder
Now that we've loaded git into our remote workspace, we want to clone a repository from Github so that we can now generate and edit code with version control while working on the CARC remote system. CARC has a general [support page](https://www.carc.usc.edu/user-guides/hpc-systems/software/git) for using git that may be useful to refer to throughout this tutorial. 

Before we can get to cloning repositories, we first need to set up an ***ssh key*** on our Github account that lets Github know to trust any interactions we create between our local folder on CARC and our git repository hosted on Github. To do this, we need to log into CARC from our terminal and run the following:
```
ssh-keygen -t ed25519
```
**Note: you do not have to provide a title and should not provide a passphrase for this ssh key, when prompted**

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

Now that we've successfully set up our ***ssh key*** we're ready to clone this repository to continue our tutorial. First, we want to navigate to the `project` directory where all coding projects should be stored. When you log into CARC you are dropped into your `home1` directory by default. Navigate to your `project` directory by typing the following command:
```
cd /project/nmherrer_110/<your username>
```
This will ensure that the clone you create of this Github repository is on the `project` directory, where we have access to significantly more memory. Now, on your Github webpage click on the green *Code* widget, navigate to the *HTTPS* tab and copy the text. It should look like this:
```
https://github.com/ryanreyn/CARC_Tutorial.git
```
After copying this line, run the following command in your terminal:
```
git clone <repo link> <repo directory>
```
with the `<repo link>` set to the above `.git` line and `<repo directory>` set to whatever name you want the folder to have on your local CARC environment. Typically, we use the same name for this folder as the name of the Github repository itself. Now you should have a copy of everything in this **CARC_Tutorial** repository present in the folder name you substituted for `<repo directory>`.

## Running jobs on CARC
With our tutorial repository in hand, and a strong fundamental understanding of how to set up git for version control in the CARC remote environment, let's go ahead and learn how to run some jobs. Jobs are managed on CARC using a specific job scheduling software called ***Slurm***. ***Slurm*** basically does all the heavy lifting of finding compute nodes to run your job on with the right specifications, and passing the code you want to run there and then passing back any output to the locations you specify.

### Types of jobs and Slurm file structure
There are two kinds of jobs you can run on CARC: *direct* submissions where you simply write a ***Slurm*** script detailing the necessary computational specs and run a script a single time in that job, and *batch* submissions where you create many individual jobs that each run the same process on one specific set of conditions. This tutorial includes files for running submissions both ways. Regardless of the job submission type, your `.slurm` file being in the following format
```
#!/bin/bash
#SBATCH -p <partition name>
#SBATCH -A <account name>
#SBATCH -t 2-00:00:00
#SBATCH --mem=32gb
#SBATCH --cpus-per-task=8
#SBATCH --out=<output file>
#SBATCH --error=<error file>
```
The first line, `#!/bin/bash` tells our `.slurm` file that we want to use *bash* as our interpreting language. The remaining lines that begin with `#SBATCH` are key for telling our job submission file what specifications to use. The `-p <partition name>` and `-A <account name>` flags are particularly important as they dictate to the job what compute nodes it is allowed to use, and the account that is authorized to run these jobs. For a complete list of possible `#SBATCH` flags that can be used for job submission you can review this [support page](https://www.carc.usc.edu/user-guides/hpc-systems/using-our-hpc-systems/slurm-cheatsheet) created by CARC. After adding these lines to sufficiently define the specifications and resources for the job, we can add whatever lines we need to call the necessary programs and files to execute the process we are interested in running. Typically, it is recommended to create a separate code file in whatever language you are using (e.g., Bash, Python, R script) and call that file in our `.slurm` submission file. For instance, in the `submit-test_script.slurm` file provided here, we set up our job before calling a python script titled `example-code.py` to execute the process itself.

### Batch submitting jobs
To batch submit a job, we need to create additional *shell* scripts (scripts that use *bash* as the interpreting language) to manage the creation and execution of a list of job files. Batch submissions typically encompass the following scripts/files:
- Job file spawn script (*bash*)
- Template job submission script (*slurm*)
- Job submission manager script (*bash*)
- Data file(s) (*.tsv, etc.*)
- Template run file (*bash, python, R, etc.*)
Some of these, such as the run file, job submission script, and data file(s) are files we already encountered while learning about direct submissions, but will each have specific tweaks to accomodate a batch architecture. An example of each of these files is provided as part of this tutorial with descriptions throughout to demonstrate the purpose and construction of each file type. The key difference between direct and batch submissions is that the run and job files for a batch submissions are ***templates*** rather than fully complete files. These template files can no longer be run directly and require the user to substitute in specific values for dummy variables present throughout each file. For example, in `batch-submit-test_script.slurm` we see that the line calling python to run our run scripts says `python sub_python` rather than `python example-code.py`. The variable `sub_python` now stands as a placeholder for the name of any `.py` script. This template structure allows us to use a script such as `spawn-runs.sh` to create a many copies of the job submission and run files that each runs a specific combination of values for the independent variables in our run script as defined in the data file. These values can be substituted into copies of the template file using the *stream editor* program, `sed`. For instance, we can substitute the value `sub_python` from our job submission script for a unique `<run name>` using `sed`
```
sed -i -e s@sub_python@${<run name>}@g batch-submit-test_script.slurm
```
This specific `sed` command would substitute the value `sub_python` in place in our template submission file, so in practice we would create a unique name for the resulting `.slurm` file based on the current run conditions, so as to avoid overwriting our template file.

### Typical workflow of a batch submission
To actually create and run the job files created by our batch scripts, batch submission typically happens in the following order:
- Creating the necessary template files for the `.slurm` job submission file and run file (in whatever language you are using)
- Making sure the relevant data files and support scripts are added to the working directory of your job files
- Spawning the runs using the `spawn-runs.sh` script
- Submitting the runs using the `jobs-submitter.sh` script
- Supervising the jobs, checking error and output, and fixing code bugs
- Repeating the spawn and submission with new versions of the template files
In practice, calling these scripts would look like this, with some standard output after each functional call
```
./spawn-runs.sh
<some standard output letting you know files were generated without issues>
./jobs-submitter.sh
<some standard output letting you know the jobs were successfully submitted>
```
The `./` is an easy way to tell the command line to run a *bash* script. If you get a permissions error, remember that you can use `chmod 755` to give the command line the proper permissions to run your scripts. The oftern iterative nature of this approach is one of the many reasons that projects with advanced batch submission requirements are excellent candidates for version control via a Github repository as you can `commit` and `push` versions of the template (and other) files to ensure you never lose previous versions in the event you create a major code error while modifying your files!
