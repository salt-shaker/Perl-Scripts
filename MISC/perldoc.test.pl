#!perl

# Prints out the perl documentation for specified module

# Perl atan2 Docuementation
@lines = `perldoc -u -f atan2`;
foreach (@lines) {
    s/\w<([^>]+)>/\U$1/g;
    print;
}

# Perl sprintf Documentation
@lines = `perldoc -f sprintf`;
foreach (@lines) {
    s/\w<([^>]+)>/\U$1/g;
    print;
}

# Perl Shuffle Documentation
@lines = `perldoc -q shuffle`;
foreach (@lines) {
    s/\w<([^>]+)>/\U$1/g;
    print;
}
