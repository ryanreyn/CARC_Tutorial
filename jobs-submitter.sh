#!/bin/sh

# # # THIS SUBMITTER FILE WILL READ FROM YOUR joblist.txt FILE. # # #

here=`pwd`
joblist=${here}'/conditions.txt'
there=${here}'/Runs'


#-------------- Determine the number of jobs to run based on file list  --------------------
-----------------------------#
num_jobs=`wc -l ${joblist} | awk '{print $1 }'`

echo 'Number of runs to submit: ' ${num_jobs} '...'


#-------------- Loop over all polys (start after headed line)  ----------------------------#
iter=0

while [ ${iter} -lt ${num_jobs} ]
do
   let iter=${iter}+1
   curr_var=`head -${iter} ${joblist} | tail -1 | cut -f 1`
   runname="run-${curr_var}-code"
   genSLURM=${there}'/submit-'${curr_var}'.slurm' ### Be sure this location for your .slurm files is correct. ###

echo "Running ${runname} under job name ${runname}"

sbatch ${genSLURM} ### This is the command that actually submits your jobs. ###

runconfirm="Run # ${iter} : Job name ${runname} - submitted..."
  
echo ${runconfirm}
       
done