#Create a simulator object
set ns [new Simulator]

#Open the nam trace file
set nf [open out.nam w]
$ns namtrace-all $nf


#/* open a trace file in write mode */
set tf [open bc.tr w]
$ns trace-all $tf

#Define a 'finish' procedure
proc finish {} {
    global ns nf
    $ns flush-trace
    #Close the trace file
    close $nf
    #Executenam on the trace file
    exec nam out.nam &
    exit 0
}

#Create 3 nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

#/*Letter M is capital Mb and D and T are capital*/
$ns duplex-link $n0 $n1 200Mb 10ms DropTail
$ns duplex-link $n1 $n2 100Mb 5ms DropTail

$ns queue-limit $n0 $n1 10


set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0

#A and N are capital
set null0 [new Agent/Null]
$ns attach-agent $n2 $null0


$ns color 1 Red
$udp0 set fid_ 1

#/* A,T,C,B and R are capital*/
set cbr0 [new Application/Traffic/CBR]

#/*S is capital, space after underscore*/
$cbr0 set packetSize_ 50O
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

$ns connect $udp0 $null0

$ns at 0.1 "$cbr0 start"
$ns at 1.0 "finish"
$ns run
