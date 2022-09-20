while ($file=shift(@ARGV)) {
    $cmd="unoconv -d presentation $file";
    print STDERR "$cmd\n";
    `$cmd`;
}