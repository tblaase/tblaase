#!/bin/bash

# curl -L "https://api.github.com/users/tblaase/repos?type=owner"
curl -L "https://api.github.com/users/tblaase/repos?type=owner" | grep -o 'git@[^"]*'| awk 'NR > 3{ print $1 }' | cut -d'/' -f 2 | cut -d'.' -f 1 > my_repos.txt && curl -L "https://api.github.com/users/tblaase/repos?type=member" | grep -o 'git@[^"]*' | cut -d'/' -f 2 | cut -d'.' -f 1 >> my_repos.txt
export lines=$(expr $(wc -l my_repos.txt | cut -c -8 | cut -c 7-))
for (( i = 0; i < $lines; i++))
do
# 	# echo $i
	curl -L "https://api.codetabs.com/v1/loc?github=tblaase/$(awk -v i=$i 'NR == i' my_repos.txt)" | cut -d : -f 2 > myfile.loc && export LOC=$(expr $(wc -l myfile.loc | cut -c -8 | cut -c 7-) - 1) && awk -v LOC=$LOC 'NR == LOC' < myfile.loc | cut -c 2- >temp.loc && mv temp.loc myfile.loc && cat myfile.loc >>LOC_collection.loc
done