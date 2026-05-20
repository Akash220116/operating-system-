read -p "enter your age " age
if [ age -lt 18 ]
then
   echo " he is  child"
elif [[ $age -ge 18 && $age -le 80 ]]
then
    echo " he is adult" 
else 
   echo "old"
fi