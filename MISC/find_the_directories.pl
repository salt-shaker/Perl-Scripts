   #!/usr/bin/perl

    use strict;
    use warnings;

    my $dir = '/tmp';

    opendir(DIR, $dir) or die $!;

    while (my $file = readdir(DIR)) {

        # A file test to check that it is a directory
	# Use -f to test for a file
        next unless (-d "$dir/$file");

	print "$file\n";

    }

    closedir(DIR);
    exit 0;