use 5.014;
use strict;
use warnings;

#BEGIN { $ENV{PERL_DL_DEBUG} = 1 };

package Greeter
{
	use constant ADADIR => '/usr/lib/gcc/x86_64-linux-gnu/4.4/rts-native/adalib/';
	use constant OURDIR => do { (my $f = __FILE__) =~ s{[^/]+$}//; $f || "." };
	
	require DynaLoader;
	our @ISA = 'DynaLoader';
	
	my $runtime = DynaLoader::dl_load_file(
		ADADIR.'/libgnat.so',
	) or die DynaLoader::dl_error();
	
	my $gep = DynaLoader::dl_find_symbol(
		$runtime,
		'__gnat_eh_personality',
	) or die DynaLoader::dl_error();
	
	my $libref = DynaLoader::dl_load_file(
		OURDIR.'/libgreeter.so',
		0x01,
	) or die DynaLoader::dl_error();
	
	my $func = DynaLoader::dl_find_symbol(
		$libref,
		'greeter__hello',
	) or die DynaLoader::dl_error();

	print $func, $/;
}