#!/bin/bash
owner=$1
rm repos_*.json || true
while true;do
	let page++
	sleep 1
	wget "https://api.github.com/users/$owner/repos?per_page=100&page=$page" -O repos_$page.json
	n=`cat repos_$page.json | jq '.[]|.full_name' | wc -l`
	echo $n
	if [ "x$n" != "x100" ]; then
      		break
  	fi
done
for repo in $(cat repos_*.json | jq '.[] | .name '| xargs -i echo {});do
	echo $repo
done
