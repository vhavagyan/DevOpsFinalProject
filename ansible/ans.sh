



check () {
sudo ansible all -m ping
}
check


if [[ $? = 0 ]]
then
        echo "Unreacheble"
        exit 1 
else 
       echo "status up"

fi

