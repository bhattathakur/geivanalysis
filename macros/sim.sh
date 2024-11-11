rm -rf sim.dat #need to delete if present as new data are appended

dir_name="geiv_cornercorner1122"
add1="/home/thakur/geivanalysis/${dir_name}" 

#isotopesim.dat/gdf
#add1="/home/thakur/mylab/ryanfiles/multisimulation/door-s-0.3-t-0.11-d-1.68" #sim.dat and sim.gdf

add="/home/thakur/mylab/ryanfiles"                        #org gdf same as used for data

echo "sim data file and fitting gdf dir: ${add1}"
echo "org gdf file dir: ${add}"


sleep 3

#exit 0
#
echo "----------------------------------------------------------------- "
./sim.py am241 $add1/am241_cornercorner.mac $add1/am241sim.gdf $add/nugdf/am241.gdf
echo "------------------------------------------------------------------ "
./sim.py pb210 $add1/pb210_cornercorner.mac $add1/pb210sim.gdf $add/nugdf/pb210.gdf
echo "------------------------------------------------------------------ "
./sim.py ra226 $add1/ra226_cornercorner.mac $add1/ra226sim.gdf $add/nugdf/ra226.gdf
echo "------------------------------------------------------------------ "

#echo "----------------------------------------------------------------- "
#./sim.py ba133 $add1/ba133.mac $add1/ba133sim.gdf $add/nugdf/ba133.gdf
#echo "------------------------------------------------------------------ "
#./sim.py co60  $add1/co60.mac  $add1/co60sim.gdf $add/nugdf/co60.gdf
#echo "------------------------------------------------------------------ "
#./sim.py cs137 $add1/cs137.mac $add1/cs137sim.gdf $add/nugdf/cs137.gdf
#echo "------------------------------------------------------------------ "
#./sim.py eu152 $add1/eu152.mac $add1/eu152sim.gdf $add/nugdf/eu152.gdf
#echo "------------------------------------------------------------------ "
#./sim.py na22  $add1/na22.mac  $add1/na22sim.gdf $add/nugdf/na22.gdf
#echo "------------------------------------------------------------------ "
#echo "------------------------------------------------------------------ "

#copy sim.dat to add1
sleep 3
echo "copy sim.dat to: ${add1}"

sleep 3
mv sim.dat ${add1}/sim_${dir_name}.dat
echo "file created: ${add1}/sim_${dir_name}.dat"
