#!/bin/bash

#make changes in the files
#change in the file sim.sh

#folder=nov18-den1.22-side0.90corner
#folder=nov18-den1.68-side0.90corner
#folder=nov18-den2.55-side0.95corner
den=1.68  #1.22,1.68,2.55
side=0.3
t=0.11
folder=door-s-${side}-t-${t}-d-${den}

echo "................................"
echo "FOLDER==> ${folder}"
echo "................................"
#folder=sep30-frontleftcorner-confine-defaultdeadlayer-ceramic-den3


#data_dir=geiv_frontleftcorner_data    #front left corner data
#data_dir=geiv_frontleft_data_0317     #geiv frotleft data on 02/17/2023


#data_dir=geiv_door_data  #2020 data
data_dir=geiv_door_data_0317          #geiv door data on 02/17/2023

#data_dir=geiv_corner_data            #folder including fitted detector data

#data_dir=geiv_corner_data
#msg="CHANGE THE FITTED DATA @ "
#src='door'
#folder=2.0-40.2-ra          #dir name
#2.0-40.2-1.5door-ra226
echo "WARNING! you are comparing the simulation with "${data_dir}
echo "=======================================================>>>>>"

files=20                               #number of simulation files

datapy="orgdata.py"
datash="orgdata.sh"
orgfile="orgsim.sh"
simpy="orgsim.py"
plotsimpy="orgplotSim.py"
orgcorr="orgcorrection.py"
corsh="orgcorrection.sh"
corplotsh="orgplotCorrection.sh"
orgplotcorr="orgplotCorrection.py"
orgplotcorrs="orgplotCorrections.py"

#echo "ALERT !!!"$msg$orgcorr

#check if the dir exists otherwise exit
if [ -d "../multisimulation/$folder" ]
then 
  echo "$folder  dir exists !"
  echo "OK!"
else
  echo "Error: $folder dir doesnot exists!"
  echo "Exiting !!!"
  exit 0
fi

#data.sh file
echo "Editing $datash ..." 
sed -e "s/DATADIR/$data_dir/;s/DESTDIR/$folder/" "${datash}" > data.sh #sed commandas seperated with ;
#sed "s/DESTDIR/$folder/" "${datash}" > data.sh

#run the file data.sh
bash data.sh #it calls data.py
#exit

echo "Editing file: ${simpy}"
sed  "s/N_files/${files}/" "${simpy}" >sim.py

echo "Editing file: ${orgfile}"
sed "s/simdir/${folder}/" "${orgfile}" > sim.sh

#run the file sim.sh
echo "Running sim.sh file..."
bash sim.sh

sleep 3
#modify orgplotSim.py
echo "Editing file: ${plotsimpy}"
sed "s/simdir/${folder}/" "${plotsimpy}" > plotSim.py 
#echo "Chaning the source position"
echo ""
#sed "s/SOURCE/${src}/g" "${plotsimpy}" > plotSim.py 

sleep 3
#running the file plotSim.py
#echo "running the file plotSim.sh"

sleep 3
#edit the file orgcorrection.sh
echo "Editing file: ${corsh}"
sed "s/simdir/${folder}/g" "${corsh}" > correction.sh 


sleep 3
#edit the file orgcorrection.py
#data  information is here
echo "Editing file: ${orgcorr}"
sed "s/simdir/${folder}/" "${orgcorr}" > correction.py 
echo "running the file correction.sh"
bash correction.sh
sleep 3

#edit the file plotCorrection.sh
echo "Editing file: ${corplotsh}"
sed "s/simdir/${folder}/g" "${corplotsh}" > plotCorrection.sh 

sleep 3

#edit the file orgplotCorrection.py
echo "Editing file: ${orgplotcorr}"
sed "s/simdir/${folder}/" "${orgplotcorr}" > plotCorrection.py 
echo "running the file plotCorrection.sh"
bash plotCorrection.sh

sleep 3




###edit the file orgplotCorrections.py
#echo "Editing file: ${orgplotcorrs}"
#sed "s/simdir/${folder}/" "${orgplotcorrs}" > plotCorrections.py 
#echo "running the file plotCorrections.py"
#python3 plotCorrections.py
echo "================================"
echo "DONE with ${folder}"
echo "================================"
