#!/bin/bash

here=`pwd`
jobslist=${here}'/conditions.txt' # can change this to title of your joblist file
there='Runs'

#------Create run folder and move unique files into the run folder----------------------------------#
if [[ -d ${there} ]]
then
rm -r ${there}
mkdir ${there}

else
mkdir ${there}

fi

cp ${jobslist} ${there}

#-------------- Determine number of jobs you need to run  ----------------
#---------------------------------#
num_jobs=`wc -l ${jobslist} | awk '{print $1 }'`

echo 'Number of runs: ' ${num_jobs} '...'

#-------------- Loop over all polys (start after headed line)  ----------------------------#
iter=1

while [ ${iter} -lt ${num_jobs} ]
do
   let iter=${iter}+1
   curr_var=`head -${iter} ${jobslist} | tail -1 | cut -f 1`
   runname="run-${curr_var}-code"

   #This is not recommended but for this example I am explicitly extracting all
   #of the variables from the jobslist file
   person=`head -${iter} ${jobslist} | tail -1 | cut -f 1`
   commute=`head -${iter} ${jobslist} | tail -1 | cut -f 2`
   
   ####
   
   echo 'Run #'${iter}': creating files for '${runname}'...'
   
   #Create destination file names
   genPY=${there}"/run-${curr_var}-code"'.py'
   genSLURM=${there}'/submit-'${curr_var}'.slurm'
   
   #---- copy template and data files to runs folder 
cp -f ${here}'/batch-code.py' ${genPY}
cp -f ${here}'/batch-submit-test_script.slurm' ${genSLURM}
   # # # NOTE: This is currently making all files in the /Runs/ directory.
   # # # You can split the files to have them save in separate folders per job as well.
   
# ------- Editing the python code file ------- #
   joboutname=${runname}'_out'
   joberrname=${runname}'_err'
   
   sed -i -e s@sub_person@${person}@g\
          -e s@sub_commute@${commute}@g    ${genPY}
  
            
# ------- Editing the Slurm files ------- #
joboutname=${there}'/'${runname}'_out'
joberrname=${there}'/'${runname}'_err'

sed -i -e s@sub_out@${joboutname}@g  \
       -e s@sub_err@${joberrname}@g  \
       -e s@sub_python@${genPY}@g    ${genSLURM}

echo 'Run files successfully modified'
  
done