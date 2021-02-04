BEGIN {} 
{
if ($6=="cwnd_")
{
printf("%f\t%f\t\n",$1,$7);

}
}
END{
}

for output:
$ ns demo1.tcl
$ awk -f ss3.awk file1.tr >a1
$ awk -f ss3.awk file1.tr >a2
$ xgraph a1 a2
