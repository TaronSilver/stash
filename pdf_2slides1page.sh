#!/bin/sh
# Takes a pdf file in argument.
# The pdf file must have two slides per page.
# The script returns another pdf file in the mother directory with one slide per page.
# The daughter file is takes the name of the original file with prepended "burst_".

fileName="$@"
mkdir burst_folder
cp "$fileName" burst_folder/.
cd burst_folder
pdftk "$fileName" burst

pw=`cat doc_data.txt  | grep PageMediaDimensions | head -1 | awk '{print int($2)}'`
ph=`cat doc_data.txt  | grep PageMediaDimensions | head -1 | awk '{print int($3)}'`
w2px=$(( pw*10 ))
hpx=$((  ph/2 ))
hpx2=$(( ph*5))
for f in pg_*.pdf ; do
    bf=bottom_$f
    tf=above_$f
    gs -o ${bf} -sDEVICE=pdfwrite -g${w2px}x${hpx2} -c "<</PageOffset [0 0]>> setpagedevice" -f ${f}
    gs -o ${tf} -sDEVICE=pdfwrite -g${w2px}x${hpx2} -c "<</PageOffset [0 -${hpx}]>> setpagedevice" -f ${f}
done

ls -1 [ab]*_00[01-32]*.pdf | sort -n -k3 -t_ > fl
newFile=burst_"$fileName"
pdftk `cat fl`  cat output "$newFile"
cp "$newFile" ../.
cd ..
rm -rf burst_folder
