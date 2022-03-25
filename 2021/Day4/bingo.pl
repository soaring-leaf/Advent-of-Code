#!/usr/bin/perl
use warnings;
use strict;

my @numDraw; # Array to hold the numbers in the order drawn
my @boards; # Array to hold each Hash-board
my $fastestWin = -1; # Count of Numbers drawn for the board with the fastest win
my $lastWin = 0; # Count of Numbers drawn for the board with the slowest win
my $bestBoard = -1; # Number of the winning board
my $bestBoardSlow = -1; # Number of the last winning board
my $bestScore = 0; # Score of the best board
my $bestScoreSlow = 0; # Score of the slowest winning board
my $currScore = 0; # Score of the current board to be calculated
my $readIn = ''; 

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","testInput.txt") or die "Can't open Test Input file $!";

$readIn = <INPUT>;
chomp($readIn);
@numDraw = split(',',$readIn);

# build the boards
while(<INPUT>) {
    chomp;

    my $sum = 0; # sum for the rows

    # Init a boardHash with:
            # r0 .. r4 = 0 - the number of row hits (top to bottom)
            # c0 .. c4 = 0 - num of col hits (left to right)
            # s? = sum of each row where ? = row number
    my %currBoard = ('r0',0,'r1',0,'r2',0,'r3',0,'r4',0,'c0',0,'c1',0,'c2',0,'c3',0,'c4',0); 

    for(my $row=0;$row<5;$row++) {
        $readIn = <INPUT>;
        chomp($readIn);
        my @newRow = split(' ',$readIn);

        for (my $i=0;$i<scalar(@newRow);$i++) {
            $sum += $newRow[$i];
            $currBoard{$newRow[$i]} = $row . ',' . $i;
        }

        $currBoard{('s'.$row)} = $sum;

        $sum = 0;
    }

    push(@boards,\%currBoard)
}

close(INPUT);

# evaluate each board one at a time until it wins or runs out of drawn numbers
# for each draw and hit: 
    # add one to the applicable row and column Key count
    # subtract the drawn number from the applicable row sum
# after 5 draws and each after, check for a winner 
# score the board and update the best board info if applicable

my $rNum = 0; # row for a hit number
my $cNum = 0; # col for a hit number

for(my $i=0; $i<scalar(@boards); $i++) {
    my %thisBoard = %{$boards[$i]};

    for(my $num=0; $num<scalar(@numDraw); $num++) {
        if(exists($thisBoard{$numDraw[$num]})) {
            ($rNum,$cNum) = split(',',$thisBoard{$numDraw[$num]});
            $thisBoard{'r'.$rNum}++;
            $thisBoard{'c'.$cNum}++;
            $thisBoard{'s'.$rNum} -= $numDraw[$num];
        }

        if($num > 4 && checkForWinner(\%thisBoard)) {
            $currScore = getBoardSum(\%thisBoard) * $numDraw[$num];

            # Part 1: Calc the score of the Fastest winning board
            if($fastestWin == -1 || $num < $fastestWin) {
                $fastestWin = $num;
                $bestScore = $currScore;
                $bestBoard = $i;
            }

            # Part 2: Calc the score of the Slowest winnning board
            if($lastWin < $num) {
                $lastWin = $num;
                $bestScoreSlow = $currScore;
                $bestBoardSlow = $i;
            }

            $num = scalar(@numDraw);
        }
    }
}

print "There are " . scalar(@boards) . " boards to choose from.\n\n";

# Part 1 answer:
print "Best board is $bestBoard, with a score of $bestScore.\n\n";

# Part 2 answer:
print "Slowest board to win is $bestBoardSlow, with a score of $bestScoreSlow.\n";

exit(0);
#==========================================================================
# Input is a Bingo Board (Hash)
# checks the Row and Column counts to see if 5 numbers have been hit for a winning board
sub checkForWinner {
    my $boardRef = $_[0];

    for(my $n=0; $n<5; $n++) {
        if($boardRef->{'r'.$n} == 5 || $boardRef->{'c'.$n} == 5) {
            return 1;
        }
    }

    return 0;
}

# gets the total sum of the numbers not hit from a winning board
sub getBoardSum {
    my $boardSum = 0;
    my $boardRef = $_[0];

    for(my $s=0; $s<5; $s++) {
        $boardSum += $boardRef->{'s'.$s};
    }

    return $boardSum;
}