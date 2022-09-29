use strict;
use warnings;

my $str = "Anf Kyysy 23 . 9\23 ahdg";
printf "Letters: %s\n", cntLetters ($str);

sub cntLetters {
    my ($str) = @_;
    my $result = $str =~ s![A-z]!!g;
    return $result;
}
