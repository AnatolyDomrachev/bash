#цвета
#удаление каталога
echo Размонтирование дисков
sudo umount /mnt
copy_dir="/tmp"

delete()
{
	echo Вы уверены, что хотите удалить каталог $1 \?
	echo 1 - Да 
	echo 2 - Нет 
	read num

	if test $num = 1
		then
		sudo rm -r $1
	fi
}

func()
{
cd "$1"
echo Текущий каталог $(pwd)
TMP=/tmp/$$
ls -a|egrep -v "^\.$" > $TMP 

num=1
IFS=$'\n'
for file in $(cat $TMP)
do
	if test -d $file
		then color=34
		else color=0
	fi
	echo -e "$num \033[${color}m $file \033[0m"
	((num++))
done

	echo -e "\033[33mВыберите каталог...\033[0m"
	read num
	dir="$(cat $TMP | awk '{if(NR==num)print $0}' num=$num)"
	path="$1/$dir"

	echo 1 - Перейти в каталог
	echo 2 - Скопировать каталог
	echo 3 - Удалить каталог
	read num

	if test $num = 1
		then
			func "$path"
		else
		if test $num = 2
			then
			if cp -r "$path" $copy_dir 
				then echo Каталог $dir скопирован в $copy_dir 
				else echo Не удалось скопировать каталог
			fi
			else
				if test $num = 3
				then
					delete "$path"
				else
					echo Неверный выбор
					func "$1"
				fi
		fi
	fi
}


#Название программы

echo "Программа автоматической заливки"

#подключаем новое устройство

#выводит список дисков

lsblk

echo -e "\033[32mВведите имя диска для монтирования(sdX):\033[0m"

#Вводим имя последнего диска в списке(т.к. последний подключившиеся)

read word

#Монтируется диск, название которого ввели в строке #11

if sudo mount /dev/$word /mnt/
then
	echo Диск монтирован
else
        echo Не удалось монтировать диск
	exit
fi

#Переходит в раздел где смонтирован диск

func /mnt

#Отображает смонтированные устройство в разделе
cd
sudo umount /mnt
echo Размонтирование дисков
