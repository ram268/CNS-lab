
# Create a simulator object 
set ns [new Simulator] 
  

# Open the NAM trace file 
set nf [open out.nam w] 
$ns namtrace-all $nf 
  
# Define a 'finish' procedure 
proc finish {} { 
    global ns nf 
    $ns flush-trace 
      
    # Close the NAM trace file 
    close $nf 
      
    # Execute NAM on the trace file 
    exec nam out.nam & 
    exit 0
} 
  
# Create four nodes 


#Create 6 nodes
set n0 [$ns node] 
$n0 color magenta
$n0 label src1
set n1 [$ns node] 
set n2 [$ns node] 
$n2 color magenta
$n2 label src2

set n3 [$ns node] 
$n3 color blue
$n3 label dest2
set n4 [$ns node] 
set n5 [$ns node] 
$n5 color blue
$n5 label dest1


#create link between the nodes
$ns make-lan "$n3 $n4 $n5" 0.2Mb 40ms LL Queue/DropTail Mac/802_3



#Create duplex links between the nodes
$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns duplex-link $n2 $n3 0.2Mb 100ms DropTail

#Orientation to the nodes
$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns duplex-link-op $n2 $n3 orient right

#$ns queue-limit $n2 $n3 20
#$ns simplex-link-op $n2 $n3 queuePos 0.5

#setup a tcp connection
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set sink5 [new Agent/TCPSink]
$ns attach-agent $n5 $sink5
$ns connect $tcp0 $sink5

#setup a FTP over a tcp connection
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ftp0 set packetSize_ 500 
$ftp0 set interval_ 0.0001 

$ns connect $tcp0 $sink5

set tcp2 [new Agent/TCP] 
$ns attach-agent $n2 $tcp2 
set ftp2 [new Application/FTP] 
$ftp2 attach-agent $tcp2 

$ftp2 set packetSize_ 600 
$ftp2 set interval_ 0.0001 
set sink3 [new Agent/TCPSink] 
$ns attach-agent $n3 $sink3

$ns connect $tcp2 $sink3 

set file1 [ open file1.tr w ] 
$tcp0 attach $file1
set file2 [ open file2.tr w ] 
$tcp2 attach $file2

$tcp0 trace cwnd_ 
$tcp2 trace cwnd_ 

$ns at 0.1 "$ftp0 start"
$ns at 5 "$ftp0 stop"

$ns at 7 "$ftp0 start"
$ns at 0.2 "$ftp2 start"
$ns at 8 "$ftp2 stop"

$ns at 14 "$ftp0 stop"

$ns at 10 "$ftp2 start"
$ns at 15 "$ftp2 stop"

$ns at 16 "finish"

#Run the simulation
$ns run



