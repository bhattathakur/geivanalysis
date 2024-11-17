#This bash command saves the results into a single data.dat file for different isotopes, which is
#then copied to the directory we want to

rm -f data.dat #need to delete if it is present

data_dir=geiv_cornercorner1122    #data dir
number_of_simulations=25M
dest_folder=geiv_cornercorner1122 #destination dir

add1="/home/thakur/geivanalysis/${data_dir}"
add="/home/thakur/mylab/ryanfiles/"

echo "Experimental data and fitted gdf dir: $add1"
echo "Original gdf dir                    : $add"

#create a loop to interateover the isotopes
isotopes=("am241" "pb210" "ra226")

for isotope in ${isotopes[@]}
do
  echo "working with ${isotope}"
  echo "modified time of a fie:"
  ls -lt $add1/${isotope}.dat
  ls -lt $add1/${isotope}.gdf
  sleep 5
  echo 

  arg="${isotope} $add1/${isotope}.dat $add1/${isotope}.gdf $add/nugdf/${isotope}.gdf"
  echo arg: ${arg}
 #run data.py
 ./data.py ${arg}
 #./data.py ${isotope} $add1/${isotope}.dat $add1/${isotope}.gdf $add/nugdf/${isotope}.gdf #if we want to save to individual file
done
 #moving result (data.py)
 save_file="${add1}/data_${data_dir}_${number_of_simulations}.dat"
 echo "saving as: ${save_file}"
 mv data.dat  ${save_file}


#./data.py ba133 $add1/ba133.dat $add1/ba133.gdf $add/nugdf/ba133.gdf
#./data.py co60  $add1/co60.dat  $add1/co60.gdf  $add/nugdf/co60.gdf
#./data.py cs137 $add1/cs137.dat $add1/cs137.gdf $add/nugdf/cs137.gdf
#./data.py eu152 $add1/eu152.dat $add1/eu152.gdf $add/nugdf/eu152.gdf
#./data.py na22  $add1/na22.dat  $add1/na22.gdf  $add/nugdf/na22.gdf
#./data.py pb210 $add1/pb210.dat $add1/pb210.gdf $add/nugdf/pb210.gdf
#./data.py ra226 $add1/ra226.dat $add1/ra226.gdf $add/nugdf/ra226.gdf


#copy data.dat to the distination folder
#echo "copying data.dat to $add1 !"
#mv data.dat ${add1}/data$data_dir.dat
#mv data.dat $file_dir$dest_folder/data$dest_folder.dat
