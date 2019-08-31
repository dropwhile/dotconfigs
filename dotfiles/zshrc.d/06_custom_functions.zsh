##########################
#### my custom functions
##########################

function hex-to-dec {
    print "obase=10; ibase=16; ${1:u}" | bc
}
