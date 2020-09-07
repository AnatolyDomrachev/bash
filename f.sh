func()
{
	ls $1 | cat -n
	echo Enter directory number
	read num
	dir=$(ls $1 | cat -n | awk '{if($1==num)print $2}' num=$num)
	echo $1/$dir
}

func test_dir

