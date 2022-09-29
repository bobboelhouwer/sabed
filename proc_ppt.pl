# Author: Bob Boelhouwer, INT
# Date: 2022-09-20
#Usage: perl proc_ppt.pl ../SABeD-Data/*.{ppt,pptm}

use strict;
use warnings;
use lib '.';
require filter;

my @files = @ARGV;
foreach my $file (@files) {
#    printf STDERR "processing %s\n", $file; #REMOVE
    `unoconv -o tmp -d presentation -f pdf $file`;
    my $newfile = `pdftotext tmp.pdf -`;
    $newfile = filter::contrchr ($newfile);
    $newfile = filter::formulas ($newfile);
    printResult ($file, $newfile);
}

sub printResult {
    my ($file, $text) = @_;
    if ($file =~ m!/([^/]+)\.pptm?$!) {
	my $filename = $1;
	my $newfile = "Conv/ppt/" . $filename . ".txt";
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
