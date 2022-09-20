while ($file=shift(@ARGV)) {
    $cmd="soffice --headless --convert-to txt:Text $file";
    print STDERR "$cmd\n";
    `$cmd`;
}