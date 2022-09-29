# Author: Bob Boelhouwer, INT
# Date: 2022-09-20
#Usage: perl proc_doc.pl ../SABeD-Data/*.{DOC,docx}

use strict;
use warnings;

my @files = @ARGV;
foreach my $file (@files) {
#    printf STDERR "processing %s\n", $file; #REMOVE
    `unoconv -o tmp -d document -f txt $file`;
    my $newfile = `cat tmp.txt`;
    printResult ($file, $newfile);
}

sub printResult {
    my ($file, $text) = @_;
    if ($file =~ m!/([^/]+)\.(DOC|docx)$!) {
	my $filename = $1;
	my $newfile = "Conv/doc/" . $filename . ".txt";
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
