# author: Bob Boelhouwer, INT
# Date: 2022 09 29
# Purpose: Een aantal functies om tekst te filteren in de diverse scripts

package filter;

require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(contrchr formulas);

use strict;
use warnings;

sub contrchr {
    my ($str) = @_;
    $str =~ s!(|||||||||||||||||||)! !g;
    return $str;
}

sub formulas {
    my ($str) = @_;
    my @txt = split ("\n", $str);
    my $result = "";
    foreach my $next (@txt) {
	my $len = length ($next);
	my $letters = cntLetters ($next);
	if (($len / 2) <= $letters) {# minder letters dan andere tekens
	    $result .= sprintf "%s\n", $next;
	}
    }
    return $result;
}

sub cntLetters {
    my ($str) = @_;
    my $result = $str =~ s![A-Za-z]!!g || 0;
    return $result;
}
