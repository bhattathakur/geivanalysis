#for running data.py and sim.py at the same time
#this file requires isotop.dat, isotopsim.dat, isotop.mac, isotope.gdf, isotopsim.gdf, isotop.gdf (from nudat)
data_dir=geiv_cornercorner1122    #data dir obtained using dat2chn to .chn (it has time information)
dest_folder=geiv_cornercorner1122 #destination dir for saving the results

add1="/home/thakur/geivanalysis/${data_dir}"
add="/home/thakur/mylab/ryanfiles/"

#add1="/home/thakur/mylab/ryanfiles/$data_dir" #data obtained from .Chn
#file_dir=/home/thakur/mylab/ryanfiles/multisimulation/

echo "Experimental data and fitted gdf dir: $add1"
echo "Original gdf dir                    : $add"

#create a loop to interateover the isotopes

isotopes=("am241" "pb210" "ra226")  #isotpes in use

for isotope in ${isotopes[@]}
do
  data_file="data.dat"
  sim_file="sim.dat"
  if [ -e "${data_file}" ];then
    echo "${data_file} exists...romoving it "
    rm -rf data.dat #removing if exists
  else
    echo "${data_file} doesnot exist"
  fi
  if [ -e "${sim_file}" ];then
    echo "${sim_file} exists...romoving it "
    rm -rf data.dat #removing if exists
  else
    echo "${sim_file} doesnot exist"
  fi

  echo "working with ${isotope}"
 data_arg="${isotope} $add1/${isotope}.dat $add1/${isotope}.gdf $add/nugdf/${isotope}.gdf"
 sim_arg="${isotope} $add1/${isotope}.mac $add1/${isotope}sim.gdf $add/nugdf/${isotope}.gdf"
 echo data arg: ${data_arg}
 echo sim arg: ${sim_arg}

 #run data.py
 ./data.py ${data_arg}

 #run sim.py
 ./sim.py ${sim_arg}

 #moving result (data.py)
 data_save_file="${add1}/data_${isotope}_$data_dir.dat"
 sim_save_file="${add1}/sim_${isotope}_$data_dir.dat"
 echo "saving ${data_file} as: ${data_save_file}"
 echo "saving ${sim_file} as: ${sim_save_file}"
 mv data.dat  ${data_save_file}
 mv sim.dat  ${sim_save_file}

done

