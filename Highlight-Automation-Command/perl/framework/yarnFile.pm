package framework::yarnFile;

######################################################################################
#
# PARSER for yarn.lock file
#
######################################################################################

use strict;
use warnings;
 
use framework::dataType;
use framework::detections;
use framework::Logs;
use Lib::Sources;

# my $DEBUG = 0;

my @dependencies = ();
my %H_names = ();

my @DEPENDENCIES_section = ();

use constant RECORD_DEFAULT => 0;
use constant RECORD_DEPENDENCIES => 1;

sub init() {
	@dependencies = ();
}

my %action = ('specs' => \&parseSpecs);

sub parseSpecs($$) {
	my $param = shift;
	my $mode = shift || RECORD_DEFAULT;

	if ($param =~ /^\s*([\@\/\w\-\.]+)\s*\"[\~\^]?(.*)\"/m) {
		my $name = $1;
		my $version = $2;

		if ($mode == RECORD_DEFAULT) {
			# print "ADD dependency : $name [$version]\n";
			push @dependencies, { 'name' => $name, 'version' => $version };
			$H_names{$name} = 1;
		}
		elsif ($mode == RECORD_DEPENDENCIES) {
			# print "ADD dependency of dependency : $name [$version]\n";
			push @DEPENDENCIES_section, { 'name' => $name, 'version' => $version };
		}
	}
	else {
		framework::Logs::Warning("Unknow dependency format : $param\n");
	}
}

sub applyAction($$$) {
	my $item = shift;
	my $param = shift;
	my $mode = shift;

	if (defined $action{$item}) {
		$action{$item}->($param, $mode);
	}
}

sub parseSection($;$;$) {
	my $content = shift;
	my $mode = shift;
	my $RootDependency = shift;

	my $item = "specs";

	# if ($content !~ /\S/) {
	# print "==============> WHITE LINE !!!\n";
	# }
	# else {
	# print "::::::::::$content\n";
	# }

	# check if content is a line or a line block
	if (ref($content) eq "SCALAR") {
		my $pos = pos($$content);
		$content = ${$content};
		pos($content) = $pos;
	}

	while ($content =~ /^(\s+([\w\-]+)\s*\"[\~\^]?(.*)\"\s*$)|[^\n]/gm) {
		# empty line => end of the section
		if (not defined $2 and not defined $3) {
			return;
		}
		else {
			my $line = $1;
			$item = $2;
			my $param = $3;
			if ($param =~ /\S/) {
				if ($item eq 'version') {
					$line =~ s/\bversion\b/$RootDependency/;
					applyAction("specs", $line, $mode);
				}
				else {
					applyAction("specs", $line, $mode);
				}
			}
		}
	}
}

sub parseVERSION($$) {
	return parseSection(shift, RECORD_DEFAULT, shift);
}

sub parseDEPENDENCIES($) {
	# SUMMARY OF DEPENDENCIES PLANNED BY THE DEVELOPPER.
	return parseSection(shift, RECORD_DEPENDENCIES);
}

sub parseYarnFile($) {
	my $content = shift;

	my $RootDependency;
	while ($$content =~ /\G(.*)\n/gc) {
		my $line = $1;
		if ($line =~ /^\"?(\@?[\/\w\-\.]+)/m) {
			# print "\nRootDependency = $1\n";
			$RootDependency = $1
		}
		elsif ($line =~ /^\s+(\w+)/) {
			if ($1 eq 'version') {
				# print "version!!!!\n";
				parseVERSION($line, $RootDependency);
			}
			elsif ($1 eq 'dependencies') {
			 	# print "dependencies!!!!\n";
			 	parseDEPENDENCIES($content);
			}
		}
	}
}

sub yarnFile($$$) {
	my $filename = shift;
	my $yarnfile_DB = shift;
	my $H_DatabaseName = shift;
	
	init();
	
	framework::Logs::printOut("yarn.lock : $filename\n");
	my $content = Lib::Sources::getFileContent($filename);
	if (! defined $content) {
		framework::Logs::Warning("Unable to read $filename for yarn.lock inspection purpose.\n");
		return undef;
	}
print "\n* Parsing yarn.lock\n";
	parseYarnFile($content);

	for my $dep (@DEPENDENCIES_section) {
		if (defined $H_names{$dep->{'name'}}) {
			# print "DEPENDENCY $dep->{'name'} OK\n";
		}
		else {
			framework::Logs::Warning("DEPENDENCY $dep->{'name'} is missing\n");
		}
	}

	my @itemDetections = ();
print "* Checking dependencies\n*************\n";
	for my $dep (@dependencies) {
		# For Memory : $H_DatabaseName is a HASH of all framework name in ower case, available for the technology concerned (here java).
		my $yarnFileItem = framework::detections::getEnvItem($dep->{'name'}, $dep->{'version'}, $yarnfile_DB, 'yarn.lock', $filename, $H_DatabaseName);
	
		if (defined $yarnFileItem) {
			
			push @itemDetections, $yarnFileItem;
		}
	}
	
	framework::Logs::Debug("-- End yarn.lock detection-- \n");
	return \@itemDetections;
}

1;
