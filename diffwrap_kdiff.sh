#!/bin/bash

# Return an errorcode of 0 on successful merge, 1 if unresolved conflicts
# remain in the result.  Any other errorcode will be treated as fatal.
# Author: Michael Bradley

#NOTE: all output must be redirected to stderr with "1>&2" as all stdout output is written to the output file

VDIFF3="kdiff3"
DIFF3="diff3" 
DIFF="kdiff3"  

promptUser ()
{
    read answer
    case "${answer}" in

        "M"         ) 
        echo "" 1>&2
        echo "Attempting to merge ${baseFileName} with ${DIFF}" 1>&2
        $VDIFF3 $older $mine $theirs --L1 $labelOlder --L2 $labelMine --L3 $labelTheirs -o $output 1>&2
        bLoop=1
        if [ -f $output ]; then
            if [ -s $output ]; then
                #output succesfully written
                bLoop=0
            fi
        fi
        if [ $bLoop = 0 ]; then
            cat $output
            rm -f $output
            exit 0
        else
            echo "Merge failed, try again" 1>&2
        fi

        ;;

        "m"         ) 
        echo "" 1>&2
        echo "Attempting to auto-merge ${baseFileName}" 1>&2
        diff3 -L $labelMine -L $labelOlder -L $labelTheirs -Em $mine $older $theirs > $output
        if [ $? = 1 ]; then
            #Can't auto merge
            rm -f $output
            $VDIFF3 $older $mine $theirs --L1 $labelOlder --L2 $labelMine --L3 $labelTheirs -o $output --auto 1>&2
            bLoop=1
            if [ -f $output ]; then
                if [ -s $output ]; then
                    #output succesfully written
                    bLoop=0
                fi
            fi
            if [ $bLoop = 0 ]; then
                cat $output
                rm -f $output
                exit 0
            else
                echo "Merge failed, try again" 1>&2
            fi
        else
            #We can automerge, and we already did it
            cat $output
            rm -f $output
            exit 0
        fi
        ;;

        "diff3" | "Diff3" | "DIFF3"  )
        echo "" 1>&2
        echo "Diffing..." 1>&2
        $VDIFF3 $older $mine $theirs --L1 $labelOlder --L2 $labelMine --L3 $labelTheirs 1>&2
        ;;

        "diff" | "Diff" | "DIFF"  )
        echo "" 1>&2
        echo "Diffing..." 1>&2
        $DIFF $mine $theirs -L $labelMine -L $labelTheirs 1>&2
        ;;

        "A" | "a"   ) 
        echo "" 1>&2
        echo "Accepting remote version of file..." 1>&2
        cat ${theirs}
        exit 0
        ;;

        "I" | "i"   ) 
        echo "" 1>&2
        echo "Keeping local modifications..." 1>&2
        cat ${mine}
        exit 0
        ;;

        "R" | "r"   ) 
        echo "" 1>&2
        echo "Reverting to base..." 1>&2
        cat ${older}
        exit 0
        ;;

        "D" | "d"   ) 
        echo "" 1>&2
        echo "Runnig diff3..." 1>&2
        diff3 -L $labelMine -L $labelOlder -L $labelTheirs -Em $mine $older $theirs
        #Exit with return vaule of the diff3 (to write out files if necessary)
        exit $?
        ;;

        "S" | "s"   ) 
        echo "" 1>&2
        echo "Saving for later..." 1>&2
        cat ${mine}
        #Exit with return vaule of 1 to force writting of files
        exit 1
        ;;

        "Fail" | "fail" | "FAIL"   ) 
        echo "" 1>&2
        echo "Failing..." 1>&2 
        exit 2
        ;;

        "H" | "h"   ) 
        echo "" 1>&2
        echo "USAGE OPTIONS:" 1>&2 
        echo "  [A]ccept    Accept $labelTheirs and throw out local modifications" 1>&2
        echo "  [D]efault   Use diff3 to merge files (same behavior as vanilla SVN)" 1>&2
        echo "  [Fail]      Kills the command (not suggested)" 1>&2
        echo "  [H]elp      Print this message" 1>&2
        echo "  [I]gnore    Keep your locally modified version as is" 1>&2
        echo "  [M]erge     Manually merge using ${VDIFF3}" 1>&2
        echo "  [m]erge     Same as "M" but attempts to automerge if possible" 1>&2
        echo "  [R]evert    Revert to base version (${labelOlder})" 1>&2
        echo "  [S]ave      Same as 'I' but writes out rold, rnew, and rmine files to deal with later" 1>&2
        echo "  [diff]      Type 'diff' to diff versions $labelMine and $labelTheirsthe before making a descision" 1>&2
        echo "  [diff3]     Type 'diff3' to diff all three versions before making a descision" 1>&2
        echo "" 1>&2
        ;;

        *   ) 
        echo "'${answer}' is not an option, try again." 1>&2
        ;;
    esac 
}

if [ -z $2 ]
then
    echo ERROR: This script expects to be called by subversion
    exit 1
fi

if [ $2 = "-m" ]
then
    #Setup vars
    labelMine=${4}
    labelOlder=${6}
    labelTheirs=${8}
    mine=${9}
    older=${10}
    theirs=${11}
    output=${9}.svnDiff3TempOutput
    baseFileName=`echo $mine | sed -e "s/.tmp$//"`

    #Prompt user for direction
    while [ 1 ]
    do
        echo "" 1>&2
        echo "${baseFileName} requires merging." 1>&2 
        echo "" 1>&2
        echo "What would you like to do?" 1>&2
        echo "[M]erge [A]ccept [I]gnore [R]evert [D]efault [H]elp" 1>&2 
        promptUser
    done
else
    L="-L"         #Argument option for left label
    R="-L"         #Argument option for right label
    label1=$3       #Left label
    label2=$5       #Right label
    file1=$6        #Left file
    file2=$7        #Right file

    $DIFF $file1 $file2 $L "$label1" $L "$label2" &
    #$DIFF $file1 $file2 &
    #wait for the command to finish
    wait
fi
exit 0

