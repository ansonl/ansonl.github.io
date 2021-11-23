for nam in *-min.jpg
do
    newname=${nam%-min.jpg}.jpg
    mv $nam $newname
done
