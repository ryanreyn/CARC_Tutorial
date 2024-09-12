#This is a small python script with a modifiable input
import pandas as pd
import numpy as np
import random

def catch_the_train(person,commute):
    #Establish the train schedule numerically and as strings
    num_train_schedule=np.array([805,815,825,835,845,855])
    train_schedule=np.array(["8:05","8:15","8:25","8:35","8:45","8:55"])

    #Establist a random time to depart for the train, and a random delay in the train arrival
    depart_time=random.randint(800,860)
    train_delay=random.randint(-2,2)
    num_train_schedule=num_train_schedule+train_delay

    #Check for special cases
    if (person == "Naomi"):
        print("Naomi doesn't take the train!\n")
        return
    if (depart_time>=855):
        print(f"{person} left too late and missed all the trains!\n")
        return

    #Compute arrival time and see when the next train is
    arrival_time=depart_time+commute
    print(f"{person} is departing at {depart_time}")
    coming_trains=[i for i in range(len(num_train_schedule)) if num_train_schedule[i] >= depart_time]
    next_train=coming_trains[0]
    next_train_time=num_train_schedule[next_train]
    next_train_str=train_schedule[next_train]

    #Check to see if the person makes the train
    if arrival_time<=next_train_time:
        print(f"{person} left at {depart_time} and made it to the {next_train_str} train just in time!\n")
    else:
        print(f"{person} left at {depart_time} and did not make the {next_train_str} train and will have to wait for the next one!\n")
    return

#Import our dataset and pass it through our function to see if we can catch 
#the train
print("Running our first job!\n")

#Read in the dataframe to run
Data=pd.read_csv("conditions.txt",sep="\t")

#The person and commute time will be directly inserted by the job generation script
for i in range(len(Data["Person"])):
    curr_person=Data["Person"][i]
    curr_commute=Data["Commute"][i]
    catch_the_train(curr_person,curr_commute)


    