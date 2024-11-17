rm -rf sim.dat #need to delete if present as new data are appended

dir_name="geiv_cornercorner1122"
position='cornercorner'
number_of_simulations=25M

add1="/home/thakur/geivanalysis/${dir_name}" 

add="/home/thakur/mylab/ryanfiles"                        #org gdf same as used for data

echo "sim data file and fitting gdf dir: ${add1}"
echo "org gdf file dir: ${add}"


sleep 3

isotopes=('am241' 'pb210' 'ra226')

#exit 0
#
for iso in ${isotopes[@]}
do
echo "----------------------------------------------------------------- "
echo "time_stamp:"
sim_file=${add1}/${iso}sim.dat
gdf_file=${add1}/${iso}sim.gdf
nugdf_file=${add}/nugdf/${iso}.gdf
mac_file=${add1}/${iso}_${position}_${number_of_simulations}.mac
ls -lt ${sim_file}
ls -lt ${gdf_file}
ls -lt ${mac_file}
ls -lt ${nugdf_file}
sleep 5
args="${iso} ${mac_file} ${gdf_file} ${nugdf_file}"
echo 
echo "args: ${args}"

./sim.py ${args}

echo 
echo "------------------------------------------------------------------ "

done

#./sim.py eu152 $add1/eu152.mac $add1/eu152sim.gdf $add/nugdf/eu152.gdf

#copy sim.dat to add1
echo 
echo "copy sim.dat to dir: ${add1}"
sleep 3
mv -v sim.dat ${add1}/sim_${dir_name}_${number_of_simulations}.dat
echo "file created: ${add1}/sim_${dir_name}_${number_of_simulations}.dat"
ls -lt ${add1}/sim_${dir_name}_${number_of_simulations}.dat
echo
