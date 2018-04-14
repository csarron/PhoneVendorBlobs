if [ $1 = "lib" ];then
	echo "\033[34m\033[1mpulling dependency libs for armeabi-v7a\033[0m"
elif [ $1 = "lib64" ];then
	echo "\033[34m\033[1mpulling dependency libs for arm64-v8a\033[0m"
else
	echo "\033[31moptions \033[1m$1\033[0m\033[31m not supported!\033[0m"
	echo "\033[1musage: \033[0m\033[36msh pull.sh lib\033[0m or \033[36msh pull.sh lib64\033[0m"
	exit 1
fi

while IFS='' read -r line || [[ -n "$line" ]]; do
    echo "\033[1mpulling: \033[0m\033[36m$line\033[0m"; 
    adb pull /system/$1/$line $1
    status=$?
    if [ $status -eq 0 ];then
   		echo "\033[36m$line\033[0m \033[32msuccessfully pulled from /system/$1!\033[0m"
	else
   		echo "\033[36m$line\033[0m \033[31mnot found in /system/$1\033[0m!, trying to pull from /vendor/$1"
	    adb pull /vendor/$1/$line $1 
	    status=$?
        if [ $status -eq 0 ];then
	   		echo "\033[36m$line\033[0m \033[32msuccessfully pulled from /vendor/$1!\033[0m"
		else
			echo "\033[36m$line\033[0m \033[31mnot found in /vendor/$1\033[0m"
		fi
	fi
done < $1/deps.txt