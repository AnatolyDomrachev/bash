func()
{
	ls $1 | cat -n
	echo Enter directory number
	read num
	ls $1 | cat -n | awk '{if($1==num)print $2}' num=$num
}

func test_dir

