# Author: Bob Boelhouwer, INT
# Date: 2022-09-19
#Usage: perl proc_pptx.pl ../SABeD-Data/*.pptx

use strict;
use warnings;
use lib '.';
require filter;

my @files = @ARGV;
foreach my $file (@files) {
    `unoconv -o tmp -d presentation -f pdf $file`;
    my $newfile = `pdftotext tmp.pdf -`;
    #    my $newfile = `perl pptx2txt.pl $file -`;
    $newfile = filter::contrchr ($newfile);
    printResult ($file, $newfile);
}

sub printResult {
    my ($file, $text) = @_;
    if ($file =~ m!/([^/]+)\.ppt[mx]$!) {
	my $filename = $1;
	my $newfile = "Conv/pptx/" . $filename . ".txt";
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
