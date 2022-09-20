use strict;
use warnings;

my @files = @ARGV;
foreach my $file (@files) {
    my $newfile = `pdftotext $file -`;
    $newfile =~ s!(||||||||||||||)! !g;
    printResult ($file, $newfile);
}

sub printResult {
    my ($file, $text) = @_;
    if ($file =~ m!/([^/]+)\.pdf$!) {
	my $filename = $1;
	my $newfile = "pdftxt/" . $filename . ".txt";
	my $out;
	if (!open ($out, ">" . $newfile)) {
	    printf STDERR "Unable to open %s (from %s)\n", $newfile, $file;
	}
	else {
	    print $out $text;
	    close ($out);
	}
    }
    else {
	printf STDERR "Problem with file name: %s\n", $file;
    }
}
