copy_dir="/tmp"

func()
{
	cd $1
	echo Текущий каталог $1
	ls -la | awk '{if($1~"^d") var="D"; else var="f";if($9) print var" "$9}' | cat -n
	echo -e "\033[33mВыберите каталог...\033[0m"
	read num
	dir=$(ls -a $1 | cat -n | awk '{if($1==num)print $2}' num=$num)
	path=$1/$dir

	echo 1 - Перейти в каталог
	echo 2 - Скопировать каталог
	read num

	if test $num = 1
		then
			func $path
		else
		if test $num = 2
			then
			if cp -r $path $copy_dir 
				then echo Каталог $dir скопирован в $copy_dir 
				else echo Не удалось скопировать каталог
			fi
			else
				echo Неверный выбор
				func $1
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
