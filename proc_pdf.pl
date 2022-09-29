# Author: Bob Boelhouwer, INT
# Date: 2022-09-19
#Usage: perl proc_pdf.pl ../SABeD-Data/*.pdf

use strict;
use warnings;
use lib '.';
require filter;

my @files = @ARGV;
foreach my $file (@files) {
    my $newfile = `pdftotext $file -`;
    $newfile = filter::contrchr ($newfile);
    $newfile = filter::formulas ($newfile);
    printResult ($file, $newfile);
}

sub printResult {
    my ($file, $text) = @_;
    if ($file =~ m!/([^/]+)\.pdf$!) {
	my $filename = $1;
	my $newfile = "Conv/pdf/" . $filename . ".txt";
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
