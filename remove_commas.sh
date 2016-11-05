# removes commas from a list of versions in order to make it conveniently iteratable via for loop
# Expects a filename as argument
sed -i 's/,//g' $1
